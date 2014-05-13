$(document).ready(function() {

    $("#search_city").geocomplete({
        types: ['(cities)'],
        details: "form"
});

    $("#event_address").geocomplete();

})

