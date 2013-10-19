$(function() {
    $('label > input[type=checkbox]').each(function() {
        var t = $(this), p = t.parent('label');
        t.change(function() {
            if(t.prop('checked')) {
                p.addClass('active');
            } else {
                p.removeClass('active');
            }
        })
    });
})