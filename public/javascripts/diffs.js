
var diffControl = function () {
    var next_diff = 0;

    function show_thing(element) {
	var container = element.up();
	var objective = container.offsetTop + container.clientHeight / 2;
	container.scrollTop = element.offsetTop - objective;
    }

    function show_pair(idx) {
	var top = $("diff-top-" + idx)
	var bot = $("diff-bot-" + idx)
	if (top && bot) {
	    show_thing(top);
	    show_thing(bot);
	    $("hunk-index").update(idx);
	    next_diff = idx;
	}
    }

    return {
	next: function () {
	    show_pair(next_diff + 1);
	},

	prev: function () {
	    show_pair(next_diff - 1);
	},

	init: function() {
	    show_pair(1);
	}
    }
}();

document.observe('dom:loaded', function() {
    $('next-diff').observe('click', diffControl.next);

    $('prev-diff').observe('click', diffControl.prev);

    diffControl.init();
});
