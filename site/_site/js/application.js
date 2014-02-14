
$(document).ready(function() {
  ga('create', 'UA-212686-7', 'andregoncalves.com');
  ga('send', 'pageview');

  $("#sidebar a").bind('click', function() {
    var location_name = $(this).attr('name');
    var location = $(this).attr('href');

    ga('send', { 'hitType': 'event', 'eventCategory': 'sidebar', 'eventAction': 'link', 'eventLabel': location_name, 'hitCallback': function() {
      document.location = location;
    }});
    return false;
  });

  twttr.events.bind('tweet', function(event) {
    if (event) {
      var targetUrl;
      if (event.target && event.target.nodeName == 'IFRAME') {
        targetUrl = extractParamFromUri(event.target.src, 'url');
      }
      ga('send', 'social', 'twitter', 'tweet', targetUrl);
    }
  });

  $("#show-sidebar").bind('click', function() {
    $("#sidebar").toggle();
    var arrow = $("#sidebar").is(':visible') ? "&uarr;" : "&darr;";
    $(this).html("About " + arrow);
    return false;
  });
});