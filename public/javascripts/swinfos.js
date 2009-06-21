var Condor; if (!Condor) Condor = {};

if (!Condor.swinfos) Condor.swinfos = {};

Condor.swinfos.defect_text = function (region, lookup) {
    var defect = lookup('defect');
    var defect_path = lookup('defect_path');
    return Condor.swinfos.make_link(defect_path, defect);
};

Condor.swinfos.apar_text = function (region, lookup) {
    var apar = lookup('apar');
    var apar_path = lookup('apar_path');

    if (apar == "NEEDS_APAR")
	return "None";
    return Condor.swinfos.make_link(apar_path, apar);
};

Condor.swinfos.ptf_text = function (region, lookup) {
    var ptf = lookup('ptf');
    var ptf_path = lookup('ptf_path');

    if (ptf == null)
	return "Not Built";
    return Condor.swinfos.make_link(ptf_path, ptf);
};

Condor.swinfos.abstract_text = function (region, lookup) {
    var ab = lookup('abstract');
    if (ab == null)
	return "";
    return ab;
};

Condor.swinfos.lpp_text = function (region, lookup) {
    var lpp = lookup('lpp');
    var lpp_path = lookup('lpp_path');
    if (lpp == null)
	return "";
    return Condor.swinfos.make_link(lpp_path, lpp);
};

Condor.swinfos.vrmf_text = function (region, lookup) {
    var vrmf = lookup('vrmf');
    var fileset_path = lookup('fileset_path');
    if (vrmf == null)
	return "";
    return Condor.swinfos.make_link(fileset_path, vrmf);
};

Condor.swinfos.release_text = function (region, lookup) {
    var release = lookup('release');
    if (release == null)
	return lookup('version');
    return release;
};

Condor.swinfos.row_class = function (region, lookup) {
    return "nth-" + ((parseInt(lookup('ds_RowNumber')) % 4) + 1);
};

Condor.swinfos.make_link = function (ref, text) {
    return "<a href='" + ref + "'>" + text + "</a>"
};

/*

I'm not sure I need this right now.

function Condor.swinfos.doNothing(event) {
    event.stop();
};

function Condor.swinfos.defectMouseDown(event) {
    event.stop();
    if (event.isRightClick()) {
	this.ul.toggle();
    }
};

function Condor.swinfos.defectMouseUp(event) {
    event.stop();
};

function Condor.swinfos.defectClick(event) {
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
	ul.setStyle({
	    position: 'absolute'
	});
	ul.hide();
    });

    $$('.clipboard').each(function (ele) {
	var clip = new ZeroClipboard.Client(ele);
	clip.setText("blah blah blah");
    });
});
*/
