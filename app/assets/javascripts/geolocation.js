$(function() {
    var located = {lat: null, lng: null, address: null};

    var locationHandler = function(position) {
        located.lat = position.coords.latitude;
        located.lng = position.coords.longitude;

        sendLocation();
    };

    var sendLocation = function() {
        $.ajax({
            type: "POST",
            url: Routes.geolocations_path(),
            data: located,
            success: function(data) {
                var $input = $('input[name=search]');
                if($input.val() == '') {
                    located.address = data.address;
                    $('input[name=search]').val(located.address);
                }
            }
        })
    };

    var storeInCookie = function() {
        $.cookie('location', located);
    };

    if(navigator.geolocation && !$.cookie('location')) {
        navigator.geolocation.getCurrentPosition(locationHandler);
    }
});

