'use strict';

(function(){
  $(document).ready(function(){
    setDonationBars();
  });
  function setDonationBars(){
    $(".donation-distribution > .donation-bar").each(function(index){
      var $this = $(this);
      $this.css("width", computeBarCssPercent($this.data("percent")) + "%");
    });
  } 
  function computeBarCssPercent(givenPercent){
    return givenPercent * 75.0 / 100 ;
  }
})();