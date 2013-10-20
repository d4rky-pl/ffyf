$(function() {

    $.cookie.json = true;

    var cookie_name = 'places';
    var $selector = $('.place-info .desc').find('.likes, .dislikes');

    $selector.on('click.vote', function(){
        var $element = $(this);

        if(!$element.hasClass('active') && $element.siblings('.active').length == 0) {
            var kind = $element.hasClass('likes') ? 'likes' : 'dislikes';
            updateCookie($element, kind);
            vote($element, kind);
            markAsVoted($element)
        }

        var tip_data = {'toggle': 'tooltip', 'title': 'You already voted'};

        $element.data(tip_data).tooltip();
        $element.siblings().first().data(tip_data).tooltip();
    });

    var voted_list = function() {
        var already_voted = $.cookie(cookie_name);

        if(!already_voted) { already_voted = {likes: [], dislikes: []}};
        return already_voted;
    }

    var updateCookie = function($el, kind) {
        var place_id = $el.parents('.place-info').data('id');

        var old_list = voted_list();
        old_list[kind].push(place_id);

        $.cookie(cookie_name, old_list);
    };

    var vote = function($el, kind) {
        var place_id = $el.parents('.place-info').data('id');
        var route = kind == 'likes' ? Routes.like_path(place_id) : Routes.dislike_path(place_id);
        $.ajax({
            type: "POST",
            url: route,
            success: function(data) {
                $el.find('b').html(data);
            }
        })
    }

    var alreadyVoted = function(id) {
        var list = voted_list();


        if($.inArray(id, list.likes) != -1) {
            return 'likes';
        }

        if($.inArray(id, list.dislikes) != -1) {
            return 'dislikes';
        }

        return false;
    }

    var markAsVoted = function($el) {
        $el.addClass('active');
        $el.off('click.vote');
    };

    // mark if already voted on page load
    var initialize = function() {
        var place_id = $('.place-info').data('id');
        var has_voted_on = alreadyVoted(place_id);
        if(has_voted_on) {
            markAsVoted($('.' + has_voted_on));
        }
    }();


});