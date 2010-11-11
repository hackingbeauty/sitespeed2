(function(){

	if(!window.HPS) {window.HPS = {}} //Create Namespace

	//Opens all hrefs with rel="external" attribute in separate window - target=_blank doesn't validate
	window.HPS.externalLinks = function(){		
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
	
	window.HPS.showComponentsModal = function(){
		//$('#dialog').jqm({modal: true, trigger: 'a.showDialog'});
		$('#dialog').jqm({ajax:'@href',  trigger: 'a.showDialog'});
		$('#dialog').jqm();
	}
})();
		
$(document).ready (function() {
	window.HPS.externalLinks();
	window.HPS.showComponentsModal();
});