var _gaq = _gaq || [];

$(document).ready(function() {
  _gaq.push(['_setAccount', "UA-212686-7"]);
  _gaq.push(['_trackPageview']);
  _gaq.push(['_trackPageLoadTime']);

  $("#sidebar a").bind('click', function() {
    var location = $(this).attr('name');
    _gaq.push(['_trackEvent', 'Sidebar', 'Link', location]);
    return true;
  });

  twttr.events.bind('tweet', function(event) {
    if (event) {
      var targetUrl;
      if (event.target && event.target.nodeName == 'IFRAME') {
        targetUrl = extractParamFromUri(event.target.src, 'url');
      }
      _gaq.push(['_trackSocial', 'twitter', 'tweet', targetUrl]);
    }
  });

  $("#show-sidebar").bind('click', function() {
    $("#sidebar").toggle();
    var arrow = $("#sidebar").is(':visible') ? "&uarr;" : "&darr;";
    $(this).html("About " + arrow);
    return false;
  });
});