$(function() {
    var located = {lat: null, lng: null};

    var locationHandler = function(position) {
        located.lat = position.coords.latitude;
        located.lng = position.coords.longitude;

        sendLocation();
    }

    var sendLocation = function() {
        $.ajax({
            type: "POST",
            url: Routes.geolocations_path(),
            data: located,
            success: function() {
                console.log('aaa');
            }
        })
    }

    if(navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(locationHandler);
    }
});

