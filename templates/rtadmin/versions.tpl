{**
 * versions.tpl
 *
 * Copyright (c) 2005-2012 Alec Smecher and John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin version list
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="rt.versions"}
{assign var="helpTopicId" value="admin.rtAdmin"}
{include file="common/header.tpl"}
{/strip}

<br/>

<div id="versions">
<table class="listing" width="100%">
	<tr><td class="headseparator" colspan="3">&nbsp;</td></tr>
	<tr valign="top">
		<td class="heading" width="40%">{translate key="rt.version.title"}</td>
		<td class="heading" width="20%">{translate key="rt.version.locale"}</td>
		<td class="heading" width="40%" align="right">&nbsp;</td>
	</tr>
	<tr><td class="headseparator" colspan="3">&nbsp;</td></tr>
	{iterate from=versions item=version}
		<tr valign="top">
			<td>{$version->getTitle()|escape}</td>
			<td>{$version->getLocale()|escape}</td>
			<td align="right"><a href="{url op="validateUrls" path=$version->getVersionId()}" class="action">{translate key="rt.admin.validateUrls.validate"}</a>&nbsp;|&nbsp;<a href="{url op="editVersion" path=$archiveId|default:0|to_array:$version->getVersionId()}" class="action">{translate key="rt.admin.versions.metadata"}</a>&nbsp;|&nbsp;<a href="{url page="rtadmin" op="contexts" path=$archiveId|default:0|to_array:$version->getVersionId()}" class="action">{translate key="rt.contexts"}</a>&nbsp;|&nbsp;<a href="{url op="exportVersion" path=$version->getVersionId()}" class="action">{translate key="rt.admin.versions.export"}</a>&nbsp;|&nbsp;<a href="{url op="deleteVersion" path=$archiveId|default:0|to_array:$version->getVersionId()}" onclick="return confirm('{translate|escape:"jsparam" key="rt.admin.versions.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
		</tr>
		<tr><td class="{if $versions->eof()}end{/if}separator" colspan="3"></td></tr>
	{/iterate}
	{if $versions->wasEmpty()}
		<tr valign="top">
			<td class="nodata" colspan="3">{translate key="common.none"}</td>
		</tr>
		<tr><td class="endseparator" colspan="3"></td></tr>
	{else}
		<tr>
			<td align="left">{page_info iterator=$versions}</td>
			<td colspan="2" align="right">{page_links anchor="versions" name="versions" iterator=$versions}</td>
		</tr>
	{/if}
	</table>
<br/>

<a href="{url op="createVersion"}" class="action">{translate key="rt.admin.versions.createVersion"}</a><br/>

<a href="{url op="restoreVersions" path=$archiveId|default:0}" onclick="return confirm('{translate|escape:"jsparam" key="rt.admin.versions.confirmRestore"}')" class="action">{translate key="rt.admin.versions.restoreVersions"}</a>

<br/>
<br/>

<form method="post" action="{url op="importVersion" path=$archiveId|default:0}" enctype="multipart/form-data">
	<input type="file" class="uploadField" name="versionFile" />
	<input type="submit" class="button" value="{translate key="rt.admin.versions.importVersion"}" />
</form>
</div>

{include file="common/footer.tpl"}
