//Klik na event
var click = function() {
    $(".service-wrapper").click(function () {
        window.location = $(this).find("a").attr("href");
        return false;
    });

    $(".service-wrapper").mouseover(function () {
        $(this).addClass("highlight-yellow");
    });

    //rovnaka vyska eventov aj ked tam je iny content
    var heights = $(".service-wrapper").map(function() {
                return $(this).height();
                }).get(),
    maxHeight = Math.max.apply(null, heights);
    $(".service-wrapper").height(maxHeight);

    //set footer year
    //$("#year").text(new Date().getFullYear());
    $(".footer-copyright").append(new Date().getFullYear());
}

$(document).ready(click)
$(document).on('page:load', click)