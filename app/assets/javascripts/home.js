// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
   $("#address-info").tooltip({placement: 'bottom'});
   var egg = new Konami(function() {
       // play FUCK YES
       var fuck_yes = $("<iframe src='//www.youtube.com/embed/630E6kpJ6CE?autoplay=1'></iframe>");
       fuck_yes.appendTo("body").hide();

       tags_available = ['vodka', 'booze', 'beer', 'alcohol', 'party'];

       // unfuck header
       $("#f-word").text("UCK");
       window.title = 'FUCK YEAH FAST FOOD - UNFUCKED EDITION';
   });
});