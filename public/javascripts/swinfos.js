var Condor; if (!Condor) Condor = {};

if (!Condor.swinfos) Condor.swinfos = {};

Condor.swinfos.defect_text = function (region, lookup) {
    var defect = lookup('defect');
    var swinfos_defect_path = lookup('swinfos_defect_path');
    return Condor.swinfos.make_link(swinfos_defect_path, defect);
};

Condor.swinfos.apar_text = function (region, lookup) {
    var apar = lookup('apar');
    var swinfos_apar_path = lookup('swinfos_apar_path');

    if (apar == "NEEDS_APAR")
	return "None";
    return Condor.swinfos.make_link(swinfos_apar_path, apar);
};

Condor.swinfos.ptf_text = function (region, lookup) {
    var ptf = lookup('ptf');
    var swinfos_ptf_path = lookup('swinfos_ptf_path');

    if (ptf == null)
	return "Not Built";
    return Condor.swinfos.make_link(swinfos_ptf_path, ptf);
};

Condor.swinfos.abstract_text = function (region, lookup) {
    var ab = lookup('abstract');
    if (ab == null)
	return "";
    return ab;
};

Condor.swinfos.lpp_text = function (region, lookup) {
    var lpp = lookup('lpp');
    var swinfos_lpp_path = lookup('swinfos_lpp_path');
    if (lpp == null)
	return "";
    return Condor.swinfos.make_link(swinfos_lpp_path, lpp);
};

Condor.swinfos.vrmf_text = function (region, lookup) {
    var vrmf = lookup('vrmf');
    var swinfos_fileset_path = lookup('swinfos_fileset_path');
    if (vrmf == null)
	return "";
    return Condor.swinfos.make_link(swinfos_fileset_path, vrmf);
};

Condor.swinfos.release_text = function (region, lookup) {
    var release = lookup('release');
    if (release == null)
	return lookup('version');
    return release;
};

Condor.swinfos.version_text = function (region, lookup) {
    var version = lookup('version');
    return version;
};

Condor.swinfos.service_pack_text = function (region, lookup) {
    var servicePack = lookup('service_pack');
    if (servicePack == null)
	return "";
    return servicePack;
};

Condor.swinfos.row_class = function (region, lookup) {
    return "nth-" + ((parseInt(lookup('ds_RowNumber')) % 4) + 1);
};

Condor.swinfos.make_link = function (ref, text) {
    return "<a href='" + ref + "'>" + text + "</a>"
};

Condor.swinfos.makeClip = function (ele) {
    var li = ele.down('.copy-to-clipboard');
    if (!li)
	return null;

    // First time we modify the text.
    // We also bind the onComplete function to the element
    if (!li.original_text) {
	li.original_text = li.innerHTML.replace(/^\s+|\s+$/g, "");
	li.innerHTML = "Copy '" + li.original_text + "' to clipboard";
    }

    var clip = new ZeroClipboard.Client(li);
    clip.ele = ele;
    clip.setText(li.original_text);
    clip.addEventListener('onComplete', function (c) {
	ele.hide();
	c.destroy();
    });
    return clip;
};

Condor.swinfos.doNothing = function (event) {
    event.stop();
};

Condor.swinfos.mouseDebug = function (event, str) {
    return;
    var left = " l: " + event.isLeftClick();
    var right = " r: " + event.isRightClick();
    var middle = " m: " + event.isMiddleClick();
    console.log(str + left + middle + right);
};

Condor.swinfos.tdMouseDown = function (event) {
    // event.stop();
    Condor.swinfos.mouseDebug(event, "down");
    if (event.isRightClick()) {
	if (this.ul.visible()) {
	    if (this.clip)
		this.clip.destroy();
	    this.ul.hide();
	} else {
	    this.ul.show();
	    this.clip = Condor.swinfos.makeClip(this.ul);
	    this.justOpened = true;
	}
    }
};

Condor.swinfos.tdMouseUp = function (event) {
    // event.stop();
    Condor.swinfos.mouseDebug(event, "up");
    
    // Not td's link or text so it must be something in the drop down
    // list.
    if (event.isRightClick() && this.justOpened) {
	var target = event.element();
	// If user clicks down on the td's text, then moves over to a
	// list item and releases, we want to pick that link.
	this.justOpened = false;
	if (target.up() != this) {
	    var href = target.readAttribute('href');
	    if (href) {
		window.location = href;
	    }
	    return;

	    // This doesn't work.  There is a "isTrusted" attribute
	    // that is false and is not settable.  I'm guessing that
	    // is the problem.
	    var doc = this.ownerDocument;
	    var eventObject = doc.createEvent('MouseEvents');
	    eventObject.initMouseEvent('click',	       // type
				       true,	       // bubbles
				       true,	       // cancelable
				       doc.defaultView, // windowObject
				       1,	       // detail
				       event.screenX,  // screenX
				       event.screenY,  // screenY
				       event.clientX,  // clientX
				       event.clientY,  // clientY
				       event.ctrlKey,  // ctrlKey
				       event.altKey,   // altKey
				       event.shiftKey, // shiftKey
				       event.metaKey,  // metaKey
				       0,	       // button
				       event.relatedTarget );
	    target.dispatchEvent(eventObject);
	}
    }
};

Condor.swinfos.tdClick = function (event) {
    // if left click and list is not open, just allow the event to
    // proceed
    Condor.swinfos.mouseDebug(event, "click");
    if (event.isLeftClick() && !this.ul.visible()) {
	return;
    }
    // Or, if we click one of the list items.
    var target = event.element();
    if (target.up() != this) {
	// console.log('not stopping');
	return;
    }
    event.stop();
};

Condor.swinfos.onPostUpdateElement = function (ele) {
    var ul = ele.down('ul');
    if (ul == null)
	return;
    // console.log("onPostUpdateElement");
    ele.observe('mousedown', Condor.swinfos.tdMouseDown.bindAsEventListener(ele));
    ele.observe('mouseup',   Condor.swinfos.tdMouseUp.bindAsEventListener(ele));
    ele.observe('click',     Condor.swinfos.tdClick.bindAsEventListener(ele));
    ele.observe('contextmenu', Condor.swinfos.doNothing.bindAsEventListener(ele));
    ele.ul = ul;
    ul.setStyle({
	position: 'absolute',
	zIndex: 1
    });
    // Eventually we might want to work when javascript is disabled.
    // If we do, we will send the ul not hidden and then hide it here.
    // ul.hide();
};

Condor.swinfos.onPostUpdate = function () {
    $('loading-data').hide();

    var table = $('ptfapardef_table');
    table.select('td').each(Condor.swinfos.onPostUpdateElement);
};

Condor.swinfos.regionCallback = function (state, notifier, data) {
    if (state == "onPostUpdate")
	Condor.swinfos.onPostUpdate();
    if (state == "onLoadingData")
	$('loading-data').show();
};

Spry.Data.Region.addObserver("ptfapardef_table", Condor.swinfos.regionCallback);

/*
document.observe('dom:loaded', function() {
    // Condor.swinfos.onPostUpdate();
    Spry.Data.Region.addObserver("ptfapardef_table", Condor.swinfos.regionCallback);
});
*/
