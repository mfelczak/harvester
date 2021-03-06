<?php

/**
 * @file plugins/generic/tinymce/TinyMCEPlugin.inc.php
 *
 * Copyright (c) 2005-2012 Alec Smecher and John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class TinyMCEPlugin
 * @ingroup plugins_generic_tinymce
 *
 * @brief TinyMCE WYSIWYG plugin for textareas - to allow cross-browser HTML editing
 */



import('lib.pkp.classes.plugins.GenericPlugin');

define('TINYMCE_INSTALL_PATH', 'lib' . DIRECTORY_SEPARATOR . 'pkp' . DIRECTORY_SEPARATOR . 'lib' . DIRECTORY_SEPARATOR . 'tinymce');
define('TINYMCE_JS_PATH', TINYMCE_INSTALL_PATH . DIRECTORY_SEPARATOR . 'jscripts' . DIRECTORY_SEPARATOR . 'tiny_mce');

class TinyMCEPlugin extends GenericPlugin {
	/**
	 * Register the plugin, if enabled
	 * @param $category string
	 * @param $path string
	 * @return boolean
	 */
	function register($category, $path) {
		if (parent::register($category, $path)) {
			if ($this->isMCEInstalled() && $this->getEnabled()) {
				HookRegistry::register('TemplateManager::display',array(&$this, 'callback'));
			}
			return true;
		}
		return false;
	}

	/**
	 * Get the name of the settings file to be installed site-wide when
	 * Harvester is installed.
	 * @return string
	 */
	function getInstallSitePluginSettingsFile() {
		return $this->getPluginPath() . '/settings.xml';
	}

	/**
	 * Hook callback function for TemplateManager::display
	 * @param $hookName string
	 * @param $args array
	 * @return boolean
	 */
	function callback($hookName, $args) {
		$templateManager =& $args[0];
		$request =& $this->getRequest();

		$page = $request->getRequestedPage();
		$op = $request->getRequestedOp();
		$baseUrl = $templateManager->get_template_vars('baseUrl');
		$additionalHeadData = $templateManager->get_template_vars('additionalHeadData');
		$allLocales = AppLocale::getAllLocales();
		$localeList = array();
		foreach ($allLocales as $key => $locale) {
			$localeList[] = String::substr($key, 0, 2);
		}

		$tinymceScript = '
		<script language="javascript" type="text/javascript" src="'.$baseUrl.'/'.TINYMCE_JS_PATH.'/tiny_mce_gzip.js"></script>
		<script language="javascript" type="text/javascript">
			tinyMCE_GZ.init({
				relative_urls : "false",
				plugins : "paste,jbimages,fullscreen",
				themes : "advanced",
				languages : "' . join(',', $localeList) . '",
				disk_cache : true
			});
		</script>
		<script language="javascript" type="text/javascript">
			tinyMCE.init({
				entity_encoding : "raw",
				plugins : "paste,jbimages,fullscreen",
				mode: "specific_textareas",
				editor_selector: "richContent",
				language : "' . String::substr(AppLocale::getLocale(), 0, 2) . '",
				relative_urls : false,
				forced_root_block : false,
				apply_source_formatting : false,
				theme : "advanced",
				theme_advanced_buttons1 : "cut,copy,paste,pastetext,pasteword,|,bold,italic,underline,bullist,numlist,|,link,unlink,help,code,fullscreen,jbimages",
				theme_advanced_buttons2 : "",
				theme_advanced_buttons3 : ""
			});
		</script>';

		$templateManager->assign('additionalHeadData', $additionalHeadData."\n".$tinymceScript);
		return false;
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName() {
		return __('plugins.generic.tinymce.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription() {
		if ($this->isMCEInstalled()) return __('plugins.generic.tinymce.description');
		return __('plugins.generic.tinymce.descriptionDisabled', array('tinyMcePath' => TINYMCE_INSTALL_PATH));
	}

	/**
	 * Check whether or not the TinyMCE library is installed
	 * @return boolean
	 */
	function isMCEInstalled() {
		return file_exists(TINYMCE_JS_PATH . '/tiny_mce.js');
	}

	/**
	 * Get a list of available management verbs for this plugin
	 * @return array
	 */
	function getManagementVerbs() {
		$verbs = array();
		if ($this->isMCEInstalled()) $verbs = parent::getManagementVerbs();
		return $verbs;
	}
}

?>
