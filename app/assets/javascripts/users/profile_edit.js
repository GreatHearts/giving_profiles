(function(){
  $(document).ready(function(){
    setDonationBars();
  });
  function setDonationBars(){
    $(".donations-bars > .donation-bar-container").each(function(index){
      _that = $(this);
      var container_width = $(".donations-bars").width();
      _that.css("width", _that.data("percent") * 1.0 * 75 / 100 + "%");
    });
  } 
})();