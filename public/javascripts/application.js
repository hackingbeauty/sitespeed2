(function(){

	//Create Namespace
	if(!window.HPS) {window.HPS = {}}	


	//Opens all hrefs with rel="external" attribute in separate window - target=_blank doesn't validate
	var externalLinks = function(){		
		if (!document.getElementsByTagName) { 
			return; 
		}
		var anchors = document.getElementsByTagName("a");
		for (var i=0; i<anchors.length; i++) {
			var anchor = anchors[i];
			if (anchor.getAttribute("href") && anchor.getAttribute("rel") == "external") {
				anchor.target = "_blank";
			}
		} 
	}
	window.HPS.externalLinks = externalLinks;

})();
		
$(document).ready (function() {

	HPS.externalLinks();
	
});