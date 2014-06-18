var ready = function() {

    $("#city").geocomplete({
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

	var cal =$("#datepicker").datepicker({
			closeText: 'Zavrieť',
			prevText: '&#x3c;Predchádzajúci',
			nextText: 'Nasledujúci&#x3e;',
			currentText: 'Dnes',
			monthNames: ['Január','Február','Marec','Apríl','Máj','Jún','Júl','August','September','Október','November','December'],
			monthNamesShort: ['Jan','Feb','Mar','Apr','Máj','Jún','Júl','Aug','Sep','Okt','Nov','Dec'],
			dayNames: ['Nedel\'a','Pondelok','Utorok','Streda','Štvrtok','Piatok','Sobota'],
			dayNamesShort: ['Ned','Pon','Uto','Str','Štv','Pia','Sob'],
			dayNamesMin: ['Ne','Po','Ut','St','Št','Pia','So'],
			weekHeader: 'Ty',
			dateFormat: 'dd-mm-yy',
			firstDay: 1,
			showMonthAfterYear: false,
			yearSuffix: '',

			onSelect: function(dateText, inst) {
				window.location.href = 'events/search?date='+dateText;
			}
});

	



}


$(document).ready(ready)
$(document).on('page:load', ready)
