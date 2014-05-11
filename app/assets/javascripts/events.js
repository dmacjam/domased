function codeAddress() {
    var city = document.getElementById('search_city').value;
    geocoder.geocode( { 'address': city}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            console.log(results[0].geometry.location.lat());
            console.log(results[0].formatted_address);
        } else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
}


$(function(){
    var input = document.getElementById('search_city');
    var options = {
        types: ['(cities)'],
        componentRestrictions: {country: 'sk'}
    };

    autocomplete = new google.maps.places.Autocomplete(input, options);
    geocoder = new google.maps.Geocoder();

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
        console.log(autocomplete.getPlace());
        codeAddress();
    });


});

