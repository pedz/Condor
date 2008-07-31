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
    },

    gotoConcat : function(event) {
	event.stop();
	var form = this.up("form");
	var text = form.childElements().find( function(c) {
	    return c.readAttribute("type") == "text";
	});
	var value = text.getValue();
	var path = form.readAttribute("action");
	window.location = path + "/" + value;
    }
};

document.observe('dom:loaded', function() {
    $$('.command-list').each(function (ele) {
	ele.hide();
    });

    $$('.command-list-span').each(function (ele) {
	ele.observe('click', Condor.listClicked.bindAsEventListener(ele));
    });

    // For the welcome page
    $$('.concat-fields').each( function (ele) {
	ele.observe('click', Condor.gotoConcat.bindAsEventListener(ele));
    });
});
