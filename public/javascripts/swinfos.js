function doNothing(event) {
    event.stop();
};

function defectMouseDown(event) {
    event.stop();
    if (event.isRightClick()) {
	this.ul.toggle();
    }
};

function defectMouseUp(event) {
    event.stop();
};

function defectClick(event) {
    // if left click and list is not open, just allow the event to
    // proceed
    if (event.isLeftClick() && !this.ul.visible()) {
	return;
    }
    event.stop();
};

document.observe('dom:loaded', function() {
    // javascript hooks for the Defect (first column)
    $$('td:first-child').each(function (ele) {
	var ul = ele.down('ul');
	if (ul == null)
	    return;
	ele.observe('mousedown', defectMouseDown.bindAsEventListener(ele));
	ele.observe('mouseup',   defectMouseUp.bindAsEventListener(ele));
	ele.observe('click',     defectClick.bindAsEventListener(ele));
	ele.observe('contextmenu', doNothing.bindAsEventListener(ele));
	ele.ul = ul;
/*
	ul.setStyle({
	    position: 'absolute'
	});
	ul.hide();
*/
    });

    $$('.clipboard').each(function (ele) {
	var clip = new ZeroClipboard.Client(ele);
	clip.setText("blah blah blah");
    });
});
