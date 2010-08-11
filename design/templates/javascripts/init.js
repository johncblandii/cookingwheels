// On document load
$().ready(function() {
	/// TinyMCE
	$('textarea.tinymce').tinymce({
		// Location of TinyMCE script
		script_url : '/javascripts/tiny_mce/tiny_mce.js',

		// General options
		convert_urls : false,
		theme : "advanced",
		plugins : "safari,contextmenu,paste,xhtmlxtras",

		// Theme options
		theme_advanced_blockformats : "p,h3,h4,pre,dt,dd",
		theme_advanced_buttons1 : "formatselect,|,bold,italic,underline,strikethrough,|,bullist,numlist,|,outdent,indent,blockquote,|,link,unlink,|,code",
		theme_advanced_buttons2 : "",
		theme_advanced_buttons3 : "",
		theme_advanced_path : false,
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "/stylesheets/base.css"
	});
	
	// Site search box
	var searchBox = $("#search-query");
	searchBox.addClass("init");
	searchBox.val("Search...");
	// Click
	searchBox.click(function(){
		if(searchBox.attr("class") == "init") {
			searchBox.val("");
			searchBox.removeClass("init");
		}
	});
	// Blur
	searchBox.blur(function(){
		if(searchBox.attr("value") == "") {
			searchBox.val("Search...");
			searchBox.addClass("init");
		}
	});
	
	// Form focus class
	$(".focus").focus();
	
	// New window class
	$('a.new-window').click(function(){
		window.open(this.href);
		return false;
	});
	
	// jQuery Tools CSS Tabs
	// :first selector is optional if you have only one tabs on the page
	$("ul.tabs:first").tabs("div.panes:first > div");
	
	// Track plugin download in Google Analytics
	$("a[rel=non-html]").click(function(){
		pageTracker._trackPageview(this.href);
	});
	
});