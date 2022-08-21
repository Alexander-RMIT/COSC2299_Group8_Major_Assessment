// Javascript file for navigation bar


var header = document.getElementById("navigation_bar");
var sticky = header.offsetTop;
var prevScrollpos = window.pageYOffset;
window.onscroll = function() {navbar_scroll()};

// Navigation bar
function navbar_scroll() {
    var curScrollPos = window.pageYOffset;
    if (window.pageYOffset > sticky) {
        header.classList.add("sticky");
        if (prevScrollpos > curScrollPos) {
            document.getElementById("navigation_bar").style.top = "0px";
            document.getElementById("navigation_bar").style.height = "64px";            
        }
        else {
            document.getElementById("navigation_bar").style.top = "-64px";
            document.getElementById("navigation_bar").style.height = "0px";
        }
        prevScrollpos = curScrollPos;
    }
    else {
        header.classList.remove("sticky");
        document.getElementById("content-wrapper").style.top = "92px";
    }
}

