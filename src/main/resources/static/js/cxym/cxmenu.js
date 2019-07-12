var mainnumber = window.parent.mainnumber;
function event(){
    $("#ypjgcx").bind("click dbclick", function() {
        window.location.href = "/cxym/ypzlcx.html";
    });
    $("#zlxxcx").bind("click dbclick", function() {
        window.location.href = "/cxym/zlxxcx.html";
    });
    $("#czjlcx").bind("click dbclick", function() {
        window.location.href = "/cxym/cxzyInfo_b.html";
    });
    $("#yecx").bind("click dbclick", function() {
        window.parent.ttype=30;
        window.location.href = "/main/readcard.html";
    });
    $("#zjpb").bind("click dbclick", function() {
        window.location.href = "/cxym/zjpb.html";
    });
    $("#myddc").bind("click dbclick", function() {
        window.location.href = "/cxym/myddc.html";
    });
    $("#mzsfcx").bind("click dbclick", function() {
        window.parent.ttype=10;
        window.location.href = "/main/readcard.html";

    });

    $("#main").bind("click dbclick", function() {

        window.location.href="/ml/main/main.html";
    });
    $("#pre").bind("click dbclick", function() {

        window.location.href="/main/main.html";
    });
}


function init(){
    //$("#waiting").show();
    event();
}
init();
