var ready;
ready = function() {

	$('.fab').hover(function () {
	    $(this).toggleClass('active');
	});
	$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	});

	// display options on hover
	$("tr").hover(function(){

		$(this).toggleClass('table-options-view');
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);