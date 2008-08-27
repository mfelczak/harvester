{**
 * index.tpl
 *
 * Copyright (c) 2005-2008 Alec Smecher and John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site administration index.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="admin.siteAdmin"}
{assign var="helpTopicId" value="admin.index"}
{include file="common/header.tpl"}
{/strip}

<h3>{translate key="admin.siteManagement"}</h3>

<ul class="plain">
	<li>&#187; <a href="{url op="settings"}">{translate key="admin.siteSettings"}</a></li>
	<li>&#187; <a href="{url op="layout"}">{translate key="admin.layout"}</a></li>
	<li>&#187; <a href="{url op="languages"}">{translate key="common.languages"}</a></li>
	<li>&#187; <a href="{url op="plugins"}">{translate key="admin.plugins"}</a></li>
	<li>&#187; <a href="{url page="rtadmin"}">{translate key="admin.rtAdmin"}</a></li>
	<li>&#187; <a href="{url op="sortOrders"}">{translate key="admin.sortOrders"}</a></li>
	{call_hook name="Template::Admin::Index::SiteManagement"}
</ul>

<h3>{translate key="admin.archives"}</h3>

<ul class="plain">
	<li>&#187; <a href="{url op="createArchive"}">{translate key="admin.archives.addArchive"}</a></li>
	<li>&#187; <a href="{url op="archives"}">{translate key="admin.archives.manageArchives"}</a></li>
</ul>

<h3>{translate key="admin.adminFunctions"}</h3>

<ul class="plain">
	<li>&#187; <a href="{url op="systemInfo"}">{translate key="admin.systemInformation"}</a></li>
	<li>&#187; <a href="{url op="expireSessions"}" onclick="return confirm('{translate|escape:"jsparam" key="admin.confirmExpireSessions"}')">{translate key="admin.expireSessions"}</a></li>
	<li>&#187; <a href="{url op="clearDataCache"}">{translate key="admin.clearDataCache"}</a></li>
	<li>&#187; <a href="{url op="clearTemplateCache"}" onclick="return confirm('{translate|escape:"jsparam" key="admin.confirmClearTemplateCache"}')">{translate key="admin.clearTemplateCache"}</a></li>
	{call_hook name="Template::Admin::Index::AdminFunctions"}
</ul>

{include file="common/footer.tpl"}
