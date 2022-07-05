{capture name=path}
	<a href="{$link->getPageLink('my-account', true)|escape:'html'}" title="{l s='Manage my account' mod='blockmysales'}" rel="nofollow">{l s='My account' mod='blockmysales'}</a>
	<span class="navigation-pipe">{$navigationPipe}</span>
	<span class="navigation_page">{l s='Manage my products' mod='blockmysales'}</span>
{/capture}
{include file="$tpl_dir./errors.tpl"}

<h2>{l s='Manages my modules/plugins' mod='blockmysales'}</h2>
<br>
{if $customer_id}
	<div>
		{if $customer_id == 'all'}
			<div>{l s='Statistics are for download/sells of components submited by everybody.' mod='blockmysales'}</div>
		{else}
			<div>{l s='Statistics are for download/sells of components submited by for current user:' mod='blockmysales'}</div>
			<div><b>{l s='Name:' mod='blockmysales'} {$publisher}</b></div>
			<div><b>{l s='Company:' mod='blockmysales'} {$company}</b></div>
			<div><b>{l s='Email:' mod='blockmysales'} {$email}</b></div>
			<div><b>{l s='Country:' mod='blockmysales'} {$country}</b></div>
		{/if}
	</div>
	<br>
	{if $products}
	<ul>
		<li>{l s='To change your product information click on its name' mod='blockmysales'}</li>
		<li>{l s='To change its picture click on its picture' mod='blockmysales'}</li>
		<li>{l s='To remove or disable a product, send a mail to contact@dolibarr.org' mod='blockmysales'}</li>
	</ul>
	{/if}
	<div id="manageproduct_tabs">
		<ul>
			{if $products}
			<li><a href="#manageproduct_tabs-1">{l s='Your modules' mod='blockmysales'}</a></li>
			<li><a href="#manageproduct_tabs-2">{l s='Your payment information' mod='blockmysales'}</a></li>
			{/if}
			<li><a href="#manageproduct_tabs-3">{l s='Submit a module/plugin' mod='blockmysales'}</a></li>
		</ul>
		{if $products}
		<!-- Product list tab -->
		<div id="manageproduct_tabs-1">
			<table id="manageproduct_productlist">
				<tr bgcolor="#CCCCCC">
					<td nowrap="nowrap"><b>{l s='Picture' mod='blockmysales'}</b></td>
					<td nowrap="nowrap" width="100%"><b>{l s='Product' mod='blockmysales'}</b></td>
					<td nowrap="nowrap"><b>{l s='Nb' mod='blockmysales'}</b></td>
					<td nowrap="nowrap"><b>{l s='Amount' mod='blockmysales'}<br>{l s='earned (excl tax)' mod='blockmysales'}</b></td>
					<td nowrap="nowrap"><b>{l s='Tools' mod='blockmysales'}</b></td>
				</tr>
	
		    {foreach from=$products key=id item=item}
				<tr bgcolor="{$item.colorTab}">
	
					<td valign="top">
						<a href="{$item.productcardlink|escape:'html'}&tab=images"><img src="{$item.image_url}" border="1" /></a>
					</td>
		
				    <td>
				    	<a href="{$item.productcardlink|escape:'html'}&tab=modify">{$item.name}</a>
				    	<br>
				    	{l s='Current price:' mod='blockmysales'} {$item.price}{l s='€ excl tax' mod='blockmysales'}, {$item.price_ttc}{l s='€ incl tax' mod='blockmysales'}
						<br>
						{$item.description_short}
						<br>
						{l s='Ref:' mod='blockmysales'} {$item.reference}
						{if $item.active} <img src="{$base_dir_ssl}img/os/2.gif" alt="Enabled" title="Enabled" style="padding: 0px 5px;">{else}<img src="{$base_dir_ssl}img/os/6.gif" alt="Enabled" title="Enabled" style="padding: 0px 5px;">{/if}
						<br>
						{l s='File:' mod='blockmysales'} {$item.filename}
						<br>
						{l s='Date:' mod='blockmysales'} {dateFormat date=$item.datedeposit full=1}
					</td>
		
				    <td align="right" nowrap="nowrap">
						<a href="{$item.productcardlink|escape:'html'}">{$item.nbr_qtysold}</a>
						{if $item.nbr_achats && $item.nbr_qtysold != $item.nbr_achats} <br>+{$item.nbr_achats-$item.nbr_qtysold} {l s='refunded' mod='blockmysales'}<br>{/if}
					</td>
		
				    <td align="right">
						{if $item.nbr_amount > 0}{$foundationfeerate*100}% {l s='Of' mod='blockmysales'}<br>{/if}
						{$item.nbr_amount}&#8364;
					</td>
					
					<td align="right">
						<a href="{$phpself}?id_p={$item.id_product}&tab=submit">
							<img src="{$modules_dir}/blockmysales/img/icon_clone.png" alt="{l s='Clone this product card' mod='blockmysales'}" title="{l s='Clone this product card' mod='blockmysales'}" border="0" />
						</a>
					</td>
				</tr>
		    {/foreach}
			</table>
		</div><!-- End product list tab -->
		<!-- Payments list tab -->
		<div id="manageproduct_tabs-2">
			<br>
			{if $voucherareok}
				<div>
					<form name="filter" action="{$phpself}" method="POST">
					{l s='Filter on date between' mod='blockmysales'} <input type="text" id="dateafter" name="dateafter" size="11" {if $dateafter}value="{$dateafter|date_format:'%Y-%m-%d'}"{/if}>
					{l s='and' mod='blockmysales'} <input type="text" id="datebefore" name="datebefore" size="11" {if $dateafter}value="{$datebefore|date_format:'%Y-%m-%d'}"{/if}>
					<input type="submit" name="submit" value="{l s='Refresh' mod='blockmysales'}" class="button">
					<input type="hidden" name="id_customer" value="{if $customer_id}{$customer_id}{/if}"><a href="{$phpself}" class="button">{l s='Reset' mod='blockmysales'}</a>
					</form>
				</div>
				<div>{l s='Number of paid sells:' mod='blockmysales'} <b>{$totalnbsellpaid}</b></div>
				<div>{l s='Total of sells done:' mod='blockmysales'} <b>{$foundationfeerate*100}% x {if $totalvoucher_ht}({/if}{$totalamount}{if $totalvoucher_ht} - {$totalvoucher_ht}**){/if} = {$mytotalamount}{l s='€ excl tax' mod='blockmysales'}</b></div>
				<div>{l s='Total validated sells:' mod='blockmysales'} <b>{$foundationfeerate*100}% x {if $totalvoucherclaimable_ht}({/if}{$totalamountclaimable}{if $totalvoucherclaimable_ht} - {$totalvoucherclaimable_ht}**){/if} = {$mytotalamountclaimable}{l s='€ excl tax' mod='blockmysales'}</b></div>
				<div>{l s='* any sell is validated after a %s month delay' sprintf=$mindelaymonth mod='blockmysales'}</div>
				{if $totalvoucherclaimable_ht || $totalvoucher_ht}
					<div>{l s='** Total amount of vouchers offered excl tax' mod='blockmysales'}</div>
				{/if}

				{if $foundthirdparty}
					<p>
						<div>
						{if $customer_id == 'all'}
							{l s='Payments already distributed (invoices with "dolistore")' mod='blockmysales'}
						{else}
							{l s='Payments received back (all time)' mod='blockmysales'}
						{/if}
						</div>
						{if $dolistoreinvoiceslines}
							{foreach from=$dolistoreinvoiceslines key=id item=line}
								{$line}
							{/foreach}
						{/if}
					</p>
				{else}
					<br>
					<div class="alert alert-danger">
						{l s='Third party %s was not found into our payment backoffice system.' sprintf=$company mod='blockmysales'}<br>
						Search was done on <strong>{$searchwasdoneon}</strong><br>
						{l s='If you already received a payment, please contact us at contact@dolibarr.org to fix this, it means following information are wrong.' mod='bloackmysales'}
					</div>
					<div>
						{l s='If you never request any payment yet, you can trust following informations.' mod='bloackmysales'}
					</div>
				{/if}

				{if !$dateafter && !$datebefore}
					<p>
						<div>{l s='Remained amount to claim in %s month:' sprintf=$mindelaymonth mod='blockmysales'} {$remaintoreceivein2month}{l s='€ excl tax' mod='blockmysales'}</div>
						<div>
							{l s='Remained amount to claim today:' mod='blockmysales'}
							{if $showremaintoreceive}
								<b><font color="#DF7E00">{$remaintoreceive}{l s='€ excl tax' mod='blockmysales'}</font></b>
							{else}
								<b><font color="#DF7E00">{l s='Not possible, a payment was already done this month (after %s)' sprintf=$firstdayofmonth mod='blockmysales'}</font></b>
							{/if}
						</div>
					</p>
					<p>
						<div>
						{if $showremaintoreceive}
							<p>
								<div>{l s='Minimum amount to claim payments for your country' mod='blockmysales'} (<strong>{$country}</strong>): <strong>{$minamount}</strong>&#8364;</div>
								<div>{l s='Charge for change for your currency' mod='blockmysales'} (<strong>{$country}</strong>): <strong>{if $iscee}{l s='Free' mod='blockmysales'}{else}{l s='depends on your bank' mod='blockmysales'}{/if}</strong></div>
							</p>
						{/if}
						{if $remaintoreceive > 0 && $showremaintoreceive}
							<p>
								{if $customer_id != 'all'}
									<div>{l s='You can claim remained amount to pay by sending an invoice to' mod='blockmysales'} <b>Association Dolibarr, France</b>,</div>
									<div>{l s='with remain to pay' mod='blockmysales'} ({l s='Total excl tax' mod='blockmysales'} = <font color="#DF7E00">{$remaintoreceive}&#8364;</font>),</div>
									<div>{l s='by email to' mod='blockmysales'} <b>dolistore@dolibarr.org</b>. {l s='Don\'t forget to add your bank account number for bank transaction (BIC ou SWIFT).' mod='blockmysales'}</div>
									<div>{l s='If you need information about foundation:' mod='blockmysales'}</div>
									<div>{l s='Name:' mod='blockmysales'} Association Dolibarr</div>
									<div>{l s='VAT number:' mod='blockmysales'} {$vatnumber}</div>
									<div>{l s='Address:' mod='blockmysales'} 265, rue de la vallée, 45160 Olivet, FRANCE</div>
									<div>{l s='Web:' mod='blockmysales'} <a href="http://asso.dolibarr.org/" target="_blank">http://asso.dolibarr.org/</a></div>
									<div>{l s='Note: Your invoice must use euro currency, withdrawal order will also be done in euros.' mod='blockmysales'}</div>
								{else}
									<div>{l s='It is not possible to claim payments for the moment (amount lower than %s euros)' sprintf=$minamount mod='blockmysales'}</div>
								{/if}
							</p>
						{else}
							{if $customer_id != 'all'}
								<p>
									{if $showremaintoreceive}
										<div>{l s='It is not possible to claim payments for the moment. Your sold is null.' mod='blockmysales'}</div>
									{else}
										<div>
											{l s=', otherwise it should be' mod='blockmysales'} {$remaintoreceive}&#8364;
											{if $remaintoreceive < 0} - <font color="red">{l s='Negative amount. You recevied more than allowed.' mod='blockmysales'}</font>{/if}
										</div>
									{/if}
								</p>
							{/if}
						{/if}
						</div>
					</p>
				{/if}
				
				{if $soapclient_error || $webservice_error}
					{if $soapclient_error}
						<div><h3>{l s='Error: %s' sprintf=$soapclient_error mod='blockmysales'}</h3></div>
					{/if}
					{if $webservice_error}
						<div><h3>{l s='Error during call of web service %1$s result=%2$s %3$s' sprintf=[$webservice_error,$webservice_error_code,$webservice_error_label] mod='blockmysales'}</h3></div>
					{/if}
					<div>{l s='Due to a technical problem, your payment information are not available for the moment.' mod='blockmysales'}</div>
				{/if}
			{else}
				<font color="#AA0000">
				{foreach from=$badvoucherlist key=id item=voucher}
					<div>{l s='Error, a bad voucher %1$s name was found into database and applied to order %2$s. A voucher name must end with C[idseller]' sprintf=[$voucher.vouchername,$voucher.idorder] mod='blockmysales'}</div>
				{/foreach}
				<div>{l s='Please come back later when problem is fixed' mod='blockmysales'}</div>
				</font>
				<div>{l s='Due to a setup problem, your payment information are not available for the moment.' mod='blockmysales'}</div>
			{/if}
		</div><!-- End payments list tab -->
		{/if}
		<!-- Submit new product tab -->
		<div id="manageproduct_tabs-3">
			{if $action == 'create' && !$cancel}
				{if $create_flag < 0}
					{$create_errors}
				{else if $create_flag > 0}
					<div class="alert alert-success">{l s='Changes recorded..' mod='blockmysales'}</div>
				{/if}
			{/if}
			<div>
				<form name="fmysalesprod" method="POST" ENCTYPE="multipart/form-data" class="formsubmit"  action="{$phpself}?action=create&tab=submit">
					<table width="100%" border="0" style="padding-bottom: 5px;">
					<tr>
						<td colspan="2" nowrap="nowrap" align="center">
							<h4>
								{l s='Before submitting a module, make sure it complies with ' mod='blockmysales'}
								<a href="{l s='http://wiki.dolibarr.org/index.php/Module_Dolistore_Validation_Rules' mod='blockmysales'}" target="_blank">{l s='validation rules' mod='blockmysales'}</a>
							</h4>
						</td>
					</tr>
					{include file="$ps_bms_templates_dir/form_product.tpl"}
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="10" cellpadding="0">
								<tr>
									<td colspan="2" nowrap="nowrap" align="center">
										<input class="button_large_disabled" id="sub" name="sub" type="submit" value="{l s='Submit this product' mod='blockmysales'}" disabled="disabled">
										&nbsp; &nbsp; &nbsp;
										<input class="button_large" id="cancel" name="cancel" type="submit" value="{l s='Cancel' mod='blockmysales'}">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					</table>
				</form>
			</div>
		</div><!-- End submit new product tab -->
	</div>
	
	{if $products}
		<div id="sales_list_link"><a target="_blank" href="{$cardproduct}?id_p=download&id_customer={$customer_id}">{l s='Download the list of all sales' mod='blockmysales'}</a></div>
	{/if}
{else}
	<h3>{l s='This customer id can\'t be found.' mod='blockmysales'}</h3>
{/if}

<script>
{literal}
function toggleLanguageFlags(elt)
{
	$(elt).parents('.displayed_flag').siblings('.language_flags').toggle();
}
function changeLanguage(field, fieldsString, id_language_new, iso_code, hidelanguages = true, textarea = false, counter = false)
{
    $('div[id^='+field+'_]').hide();
    if (textarea) {
    	if (counter) {
    		$('span[class^=counter_]').hide();
    	}
        $('div[class^=language_current_'+field+']').hide();
    }
	var fields = fieldsString.split('¤');
	var base_dir_ssl = '{/literal}{$base_dir_ssl}{literal}'
	for (var i = 0; i < fields.length; ++i)
	{
		$('div[id^='+fields[i]+'_]').hide();
		$('#'+fields[i]+'_'+id_language_new).show();
		if (textarea) {
			if (counter) {
				$('span[class^=counter_'+id_language_new+']').show();
			}
			$('.'+'language_current_'+fields[i]+'_'+id_language_new).show();
		} else {
			$('#'+'language_current_'+fields[i]).attr('src', base_dir_ssl + 'img/l/' + id_language_new + '.jpg');
		}
	}
	if (hidelanguages) {
		$('#languages_' + field).hide();
	}
	id_language = id_language_new;
}
$(document).ready(function() {
	{/literal}
	var current_shop_id = {$current_shop_id|intval};
	var languages = {$languages|@json_encode nofilter};
	{if !$products}
		{literal}$( "#sales_list_link" ).hide();{/literal}
	{/if}
	{literal}
	$(function() {
		$( "#manageproduct_tabs" ).tabs(
		{/literal}{if $products}{literal}
			{
				beforeActivate: function( event, ui ) {
					var manageproducttab = ui.newPanel.attr('id');
					if (manageproducttab == 'manageproduct_tabs-3') {
						$( "#sales_list_link" ).hide();
					} else {
						$( "#sales_list_link" ).show();
					}
				}
			}
		{/literal}{/if}{literal}
		);
		{/literal}{if $dateafter || $datebefore}{literal}
			$( "#manageproduct_tabs" ).tabs("option", "active", $( "#manageproduct_tabs" ).find("manageproduct_tabs-2").index()-1 );
		{/literal}{/if}{literal}
		{/literal}{if $tab == 'submit'}{literal}
			$( "#manageproduct_tabs" ).tabs("option", "active", $( "#manageproduct_tabs" ).find("manageproduct_tabs-3").index() );
		{/literal}{/if}{literal}
	});
	$(function() {
		$( "#dateafter" ).datepicker({
			dateFormat: 'yy-mm-dd'
		});
	});
	$(function() {
		$( "#datebefore" ).datepicker({
			dateFormat: 'yy-mm-dd'
		});
	});
	getModuleName();
	setKeywords(true);
	$('#product_name_l1').on('keyup', function(e) {
		getModuleName();
	});
	$('#module_version').on('keyup', function(e) {
		var self = $(this);
		checkVersionFormat(e, self);
	});
	$('#dolibarr_min').on('keyup', function(e) {
		var self = $(this);
		checkVersionFormat(e, self);
		getModuleName();
		setKeywords();
	});
	$('#dolibarr_max').on('keyup', function(e) {
		var self = $(this);
		checkVersionFormat(e, self);
		getModuleName();
		setKeywords();
	});
	$('#sub').css('opacity', '0.5');
	$('#agreewithtermofuse, #agreetoaddwikipage').attr('checked', false);
	$('#agreewithtermofuse').change(function() {
		if ($(this).is(':checked') && $('#agreetoaddwikipage').is(':checked')) {
			$('#sub').removeClass('button_large_disabled').addClass('button_large').attr('disabled', false).css('opacity', '');
		}   
		else {
			$('#sub').removeClass('button_large').addClass('button_large_disabled').attr('disabled', 'disabled').css('opacity', '0.5');
		}
	});
	$('#agreetoaddwikipage').change(function() {
		if ($(this).is(':checked') && $('#agreewithtermofuse').is(':checked')) {
			$('#sub').removeClass('button_large_disabled').addClass('button_large').attr('disabled', false).css('opacity', '');
		}   
		else {
			$('#sub').removeClass('button_large').addClass('button_large_disabled').attr('disabled', 'disabled').css('opacity', '0.5');
		}
	});
	$(".tooltip").tooltip({
		placement : 'top',
		animation: true,
	});
	$(".tooltip-top").tooltip({
		placement : 'top',
		animation: true,
	});
	$(".tooltip-left").tooltip({
		placement : 'left',
		animation: true,
	});
	$(".tooltip-bottom").tooltip({
		placement : 'bottom',
		animation: true,
	});
	$(".tooltip-right").tooltip({
		placement : 'top',
		animation: true,
	});
	$(function () { $("[data-toggle='tooltip']").tooltip(); });
	function checkVersionFormat(e, self) {
		self.val(self.val().replace(/[^0-9\.\*x]/g, ''));
		if ((e.which != 46 || self.val().indexOf('.') != -1) && (e.which < 48 || e.which > 57))
		{
			e.preventDefault();
		}
	}
	function getModuleName() {
		var name = $('#product_name_l1').val();
		var dolibarr_min = $('#dolibarr_min').val();
		var dolibarr_max = $('#dolibarr_max').val();
		var version = (typeof dolibarr_min != 'undefined' && dolibarr_min ? dolibarr_min + ' - ' : '') + dolibarr_max;
		if (typeof name != 'undefined' && name && typeof version != 'undefined' && version) {
			$('#module_name_div').html(name + ' ' + version);
			$('#module_name_example').show();
		}
	}
	function setKeywords(split = false) {
		var dolibarr_min = $('#dolibarr_min').val().split(".");
		var dolibarr_max = $('#dolibarr_max').val().split(".");
		if (dolibarr_min[0] && dolibarr_max[0]) {
			var i;
			var max = ((dolibarr_max[0] - dolibarr_min[0]) + 1);
			$.each(languages, function(key, language) {
				var min = dolibarr_min[0];
				var dolibarr_tags = [];
				if (split == true) {
					var keywords = $("#keywords_" + language.id_lang + " input[name='keywords_" + language.id_lang + "']").val().split(",");
					keywords = keywords.filter(function(elem) {
						return elem.match(/^v?\d+$/) ? false : true;
					});
					keywords.join(',');
					$("#keywords_" + language.id_lang + " input[name='keywords_" + language.id_lang + "']").val(keywords);
				}
				for (i = 0; i < max; i++) {
					console.log("add v"+min.toString());
					dolibarr_tags.push("v"+min.toString());
					min++;
				}
				dolibarr_tags.join(',');
				$("#keywords_" + language.id_lang + " input[name='dolibarr_keywords_" + language.id_lang + "']").val(dolibarr_tags);
			});
		}
	}
});
</script>
{/literal}
{$tinymce}
