/* -------------------- Check Browser --------------------- */
function browser() {
    function i(e) {
        return e in document.documentElement.style
    }
    var e = !!window.opera && !!window.opera.version,
        t = i("MozBoxSizing"),
        n = Object.prototype.toString.call(window.HTMLElement).indexOf("Constructor") > 0,
        r = !n && i("WebkitTransform");
    return e ? !1 : n || r ? !0 : !1
}

function retina() {
    retinaMode = window.devicePixelRatio > 1;
    return retinaMode
}

function hexToRgb(e) {
    var t = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(e);
    return t ? {
        r: parseInt(t[1], 16),
        g: parseInt(t[2], 16),
        b: parseInt(t[3], 16)
    } : null
}

function rgbToRgba(e, t) {
    if (jQuery.browser.version <= 8) {
        e = hexToRgb(e);
        rgba = "rgba(" + e.r + "," + e.g + "," + e.b + "," + t + ")"
    } else {
        e = e.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
        rgba = "rgba(" + e[1] + "," + e[2] + "," + e[3] + "," + t + ")"
    }
    return rgba
}

function widthFunctions(e) {
    $(".timeline") && $(".timeslot").each(function () {
        var e = $(this).find(".task").outerHeight();
        $(this).css("height", e)
    });
    var t = $("#sidebar-left").outerHeight(),
        n = $("#content").height(),
        r = $("#content").outerHeight(),
        i = $("header").height(),
        s = $("footer").height(),
        o = $(window).height(),
        u = $(window).width();
    if (u < 992) {
        $("#main-menu-min").removeClass("minified").addClass("full").find("i").removeClass("fa-angle-double-right").addClass("fa-angle-double-left");
        $("body").removeClass("sidebar-minified");
        $("#content").removeClass("sidebar-minified");
        $("#sidebar-left").removeClass("minified")
    }
    if (u > 767) {
        o - 80 > t && $("#sidebar-left").css("min-height", o - i - s - 30);
        o - 80 > n && $("#content").css("min-height", o - i - s - 30)
    } else $("#sidebar-left").css("min-height", "0px");
    u < 768 ? $(".chat-full") && $(".chat-full").each(function () {
        $(this).addClass("alt")
    }) : $(".chat-full") && $(".chat-full").each(function () {
        $(this).removeClass("alt")
    })
}
jQuery(document).ready(function (e) {

    //jQuery.browser.version.substring(0, 2) == "8." && e(".hideInIE8").remove();
    //e('a[href="#"][data-top!=true]').click(function (e) {
    //    e.preventDefault()
    //});

    e(".noty").click(function (t) {
        t.preventDefault();
        var n = e.parseJSON(e(this).attr("data-noty-options"));
        noty(n)
    });
    e("#myTab a:first").tab("show");
    e("#myTab a").click(function (t) {
        t.preventDefault();
        e(this).tab("show")
    });
    e('[rel="tooltip"],[data-rel="tooltip"]').tooltip({
        placement: "bottom",
        delay: {
            show: 400,
            hide: 200
        }
    });
    e('[rel="popover"],[data-rel="popover"],[data-toggle="popover"]').popover();
    e("#toggle-fullscreen").button().click(function () {
        var t = e(this),
            n = document.documentElement;
        if (!t.hasClass("active")) {
            e("#thumbnails").addClass("modal-fullscreen");
            n.webkitRequestFullScreen ? n.webkitRequestFullScreen(window.Element.ALLOW_KEYBOARD_INPUT) : n.mozRequestFullScreen && n.mozRequestFullScreen()
        } else {
            e("#thumbnails").removeClass("modal-fullscreen");
            (document.webkitCancelFullScreen || document.mozCancelFullScreen || e.noop).apply(document)
        }
    });
    e(".btn-close").click(function (t) {
        t.preventDefault();
        e(this).parent().parent().parent().fadeOut()
    });
    e(".btn-minimize").click(function (t) {
        t.preventDefault();
        var n = e(this).parent().parent().next(".box-content");
        n.is(":visible") ? e("i", e(this)).removeClass("fa-chevron-up").addClass("fa-chevron-down") : e("i", e(this)).removeClass("fa-chevron-down").addClass("fa-chevron-up");
        n.slideToggle("slow", function () {
            widthFunctions()
        })
    });
    e(".btn-setting").click(function (t) {
        t.preventDefault();
        e("#myModal").modal("show")
    })
});
jQuery(document).ready(function (e) {
    e(".discussions").find(".delete").click(function () {
        e(this).parent().fadeTo("slow", 0, function () {
            e(this).slideUp("slow", function () {
                e(this).remove()
            })
        })
    })
});
jQuery(document).ready(function (e) {
    e("#main-menu-toggle").click(function () {
        if (e(this).hasClass("open")) {
            e(this).removeClass("open").addClass("close");
            var t = e("#content").attr("class"),
                n = parseInt(t.replace(/^\D+/g, "")),
                r = n + 2,
                i = "span" + r;
            e("#content").addClass("full");
            e(".navbar-brand").addClass("noBg");
            e("#sidebar-left").hide()
        } else {
            e(this).removeClass("close").addClass("open");
            var t = e("#content").attr("class"),
                n = parseInt(t.replace(/^\D+/g, "")),
                r = n - 2,
                i = "span" + r;
            e("#content").removeClass("full");
            e(".navbar-brand").removeClass("noBg");
            e("#sidebar-left").show()
        }
    });
    e("#main-menu-min").click(function () {
        if (e(this).hasClass("full")) {
            e(this).removeClass("full").addClass("minified").find("i").removeClass("fa-angle-double-left").addClass("fa-angle-double-right");
            e("body").addClass("sidebar-minified");
            e("#content").addClass("sidebar-minified");
            e("#sidebar-left").addClass("minified");
            e(".dropmenu > .chevron").removeClass("opened").addClass("closed");
            e(".dropmenu").parent().find("ul").hide();
            e("#sidebar-left > div > ul > li > a > .chevron").removeClass("closed").addClass("opened");
            e("#sidebar-left > div > ul > li > a").addClass("open")
        } else {
            e(this).removeClass("minified").addClass("full").find("i").removeClass("fa-angle-double-right").addClass("fa-angle-double-left");
            e("body").removeClass("sidebar-minified");
            e("#content").removeClass("sidebar-minified");
            e("#sidebar-left").removeClass("minified");
            e("#sidebar-left > div > ul > li > a > .chevron").removeClass("opened").addClass("closed");
            e("#sidebar-left > div > ul > li > a").removeClass("open")
        }
    });
    e(".dropmenu").click(function (t) {
        t.preventDefault();
        if (e("#sidebar-left").hasClass("minified")) {
            if (!e(this).hasClass("open")) {
                e(this).parent().find("ul").first().slideToggle();
                e(this).find(".chevron").hasClass("closed") ? e(this).find(".chevron").removeClass("closed").addClass("opened") : e(this).find(".chevron").removeClass("opened").addClass("closed")
            }
        } else {
            e(this).parent().find("ul").first().slideToggle();
            e(this).find(".chevron").hasClass("closed") ? e(this).find(".chevron").removeClass("closed").addClass("opened") : e(this).find(".chevron").removeClass("opened").addClass("closed")
        }
    });
    if (e("#sidebar-left").hasClass("minified")) {
        e("#sidebar-left > div > ul > li > a > .chevron").removeClass("closed").addClass("opened");
        e("#sidebar-left > div > ul > li > a").addClass("open");
        e("body").addClass("sidebar-minified")
    }
});
jQuery(document).ready(function (e) {
    e("ul.main-menu").find("a").each(function () {
        if (e(e(this))[0].href == String(window.location)) {
            e(this).parent().addClass("active");
            e(this).parents("ul").add(this).each(function () {
                e(this).show();
                e(this).prev("a").find(".chevron").removeClass("closed").addClass("opened")
            })
        }
    })
});
jQuery(document).ready(function (e) {
    if (e(".boxchart").length)
        if (retina()) {
            e(".boxchart").sparkline("html", {
                type: "bar",
                height: "60",
                barWidth: "8",
                barSpacing: "2",
                barColor: "#ffffff",
                negBarColor: "#eeeeee"
            });
            if (jQuery.browser.mozilla) {
                e(".boxchart").css("MozTransform", "scale(0.5,0.5)").css("height", "30px;");
                e(".boxchart").css("height", "30px;").css("margin", "-15px 15px -15px -15px")
            } else e(".boxchart").css("zoom", .5)
        } else e(".boxchart").sparkline("html", {
            type: "bar",
            height: "30",
            barWidth: "4",
            barSpacing: "1",
            barColor: "#ffffff",
            negBarColor: "#eeeeee"
        });
    if (e(".linechart").length)
        if (retina()) {
            e(".linechart").sparkline("html", {
                width: "130",
                height: "60",
                lineColor: "#ffffff",
                fillColor: !1,
                spotColor: !1,
                maxSpotColor: !1,
                minSpotColor: !1,
                spotRadius: 2,
                lineWidth: 2
            });
            if (jQuery.browser.mozilla) {
                e(".linechart").css("MozTransform", "scale(0.5,0.5)").css("height", "30px;");
                e(".linechart").css("height", "30px;").css("margin", "-15px 15px -15px -15px")
            } else e(".linechart").css("zoom", .5)
        } else e(".linechart").sparkline("html", {
            width: "65",
            height: "30",
            lineColor: "#ffffff",
            fillColor: !1,
            spotColor: !1,
            maxSpotColor: !1,
            minSpotColor: !1,
            spotRadius: 2,
            lineWidth: 1
        });
    e(".chart-stat").length && (retina() ? e(".chart-stat > .chart").each(function () {
        var t = e(this).css("color");
        e(this).sparkline("html", {
            width: "180%",
            height: 80,
            lineColor: t,
            fillColor: !1,
            spotColor: !1,
            maxSpotColor: !1,
            minSpotColor: !1,
            spotRadius: 2,
            lineWidth: 2
        });
        if (jQuery.browser.mozilla) {
            e(this).css("MozTransform", "scale(0.5,0.5)");
            e(this).css("height", "40px;").css("margin", "-20px 0px -20px -25%")
        } else e(this).css("zoom", .5)
    }) : e(".chart-stat > .chart").each(function () {
        var t = e(this).css("color");
        e(this).sparkline("html", {
            width: "90%",
            height: 40,
            lineColor: t,
            fillColor: !1,
            spotColor: !1,
            maxSpotColor: !1,
            minSpotColor: !1,
            spotRadius: 2,
            lineWidth: 2
        })
    }))
});
jQuery(document).ready(function (e) {
    if (e(".todo-list").length) {
        e(".todo-actions > a").click(function () {
            if (e(this).find("i").attr("class") == "fa-check done") {
                e(this).find("i").removeClass("done");
                e(this).parent().parent().find("span").css({
                    opacity: 1
                });
                e(this).parent().parent().find(".desc").css("text-decoration", "none")
            } else {
                e(this).find("i").addClass("done");
                e(this).parent().parent().find("span").css({
                    opacity: .25
                });
                e(this).parent().parent().find(".desc").css("text-decoration", "line-through")
            }
            return !1
        });
        e(".todo-list > li > a.remove").click(function () {
            e(this).parent().slideUp();
            return !1
        });
        e(function () {
            e(".todo-list").sortable();
            e(".todo-list").disableSelection()
        })
    }
});
jQuery(document).ready(function (e) {
    e("#feed").length && e("#filter > li > a").click(function (t) {
        var n = e(this).attr("data-option-value");
        e(this).parent().parent().find("a").each(function () {
            e(this).removeClass("active")
        });
        e(this).addClass("active");
        e("#timeline > li").each(function () {
            e(this).hasClass(n) ? e(this).show() : n == "all" ? e(this).show() : e(this).hide()
        });
        t.preventDefault()
    })
});
jQuery(document).ready(function () {
    $(".skill-bar") && $(".meter > span").each(function () {
        var e = parseInt($(this).html().replace("%", ""));
        $(this).width(0).animate({
            width: e + "%",
            countNum: e + 1
        }, {
            duration: 3e3,
            easing: "linear",
            step: function () {
                $(this).text(Math.floor(this.countNum) + "%")
            },
            complete: function () {}
        })
    })
});
$(document).ready(function () {
    widthFunctions()
});
$(window).bind("resize", widthFunctions);