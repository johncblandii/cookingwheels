$().ready(function() {
	$('textarea.tinymce').tinymce({
		script_url : '/javascripts/tiny_mce/tiny_mce.js',
		convert_urls : false,
		theme : "advanced",
		plugins : "safari,contextmenu,paste,xhtmlxtras",
		theme_advanced_blockformats : "p,h3,h4,pre,dt,dd",
		theme_advanced_buttons1 : "formatselect,|,bold,italic,underline,strikethrough,|,bullist,numlist,|,outdent,indent,blockquote,|,link,unlink,|,code",
		theme_advanced_buttons2 : "",
		theme_advanced_buttons3 : "",
		theme_advanced_path : false,
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,
		content_css : "/stylesheets/base.css"
	});
});