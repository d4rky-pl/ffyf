$(function() {
    var instagram_clientId = '8ff397f65c3a4a08950a29b0c1dee1c8';

    var load_image = function(img) {
        var bg = $("#bg"),
            preload = $("<img>");

        preload.load(function() {
            bg.fadeOut(500, function() {
                bg.css("background-image", "url(" + img + ")");
                bg.fadeIn(500);
            });
        }).attr("src", img);
    }

    var feed = new Instafeed({
        get: 'tagged',
        tagName: 'pizza',
        clientId: instagram_clientId,
        limit: 50,
        links: false,
        mock: true,
        success: function(json) {
            var pics = json.data;
            pics.sort(function() { return 0.5 - Math.random() });
            for(var i = 0, l = pics.length; i < l; i++) {
                var pic = pics[i],
                    loc = pic.location;

                if(loc != null && typeof loc.name != "undefined") {
                    load_image(pic.images.standard_resolution.url);
                    return true;
                }
            }
            console.log("no location in ", pics);
            feed.run();
            return false;
        }
    });

    var tags_available = [ 'burger', 'pizza', 'kebab', 'fastfood' ];

    window.setInterval(function() {
        feed.options.tagName = tags_available[Math.floor(Math.random() * 4)];
        feed.run();
    }, 3000);

    feed.run();
})