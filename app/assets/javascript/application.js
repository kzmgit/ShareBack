// Loads all Semantic javascripts
//= require semantic-ui


// Semantic UIのタブ機能を使用するためのjs
/*global $*/
document.addEventListener("turbolinks:load", function() {
  $(function(){
    $('.menu .item').tab();
  })
})