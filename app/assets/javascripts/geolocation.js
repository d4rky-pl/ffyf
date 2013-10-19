$(function() {
    var located = {lat: null, lng: null};

    var locationHandler = function(position) {
        located.lat = position.coords.latitude;
        located.lng = position.coords.longitude;
    }

    var sendLocation = function() {
        $.ajax()
    }

    if(navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(locationHandler);
    }
});

