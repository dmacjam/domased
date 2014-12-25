//Klik na event
var click = function() {
    $(".service-wrapper").click(function () {
        window.location = $(this).find("a").attr("href");
        return false;
    });

    $(".service-wrapper").mouseover(function () {
        $(this).addClass("highlight-yellow");
    });
}

$(document).ready(click)
$(document).on('page:load', click)