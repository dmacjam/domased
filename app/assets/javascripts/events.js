var ready = function() {

    $("#search_city").geocomplete({
        types: ['(cities)'],
        details: "form"
	});

    
    $("#event_address").geocomplete({
		details: ".details",
        detailsAttribute: "data-geo"
	});

    
    
    $('#event_form_date').datepicker({ dateFormat: "dd-mm-yy", minDate: 0, firstDay: 1 ,
    	dayNamesMin: [ "Ne", "Po", "Ut", "St", "Št", "Pi", "So" ],
    monthNames: [ "Januar", "Februar", "Marec", "April", "Maj", "Jun", "Jul", "August", "September", "Oktober", "November", "December" ]
    });


    $('#event_form_time').timepicker({ 'timeFormat': 'H:i', 'scrollDefaultTime': '16:00' });	
}


$(document).ready(ready)
$(document).on('page:load', ready)
