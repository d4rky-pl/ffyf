$(function() {
    var checkbox = function(t,p) {
        if(t.prop('checked')) {
            p.addClass('active');
        } else {
            p.removeClass('active');
        }
    }
    $('label > input[type=checkbox]').each(function() {
        var t = $(this), p = t.parent('label');
        t.change(function() {
            checkbox(t,p);
        })
        checkbox(t,p);
    });
})