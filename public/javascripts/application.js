// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var Condor = {
    listClicked : function(event) {
	var target = this.up(1).down('.command-list');
	$$('.command-list').each(function(ele) {
	    if (target != ele)
		ele.hide();
	});
	target.toggle();
    }
};

document.observe('dom:loaded', function() {
    $$('.command-list').each(function (ele) {
	ele.hide();
    });
    $$('.command-list-span').each(function (ele) {
	ele.observe('click', Condor.listClicked.bindAsEventListener(ele));
    });
});
