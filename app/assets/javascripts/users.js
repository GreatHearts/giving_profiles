(function(){
  $(document).ready(function(){
    setDonationBars();
  });

   //experimental function. just place holder for now. will be properly implemented later. 
  function setDonationBars(){
    var donations_bars = $(".donations-bars");
    grid_template_columns = "";

    $(".donations-bars > .donation-bar").each(function(index){
      _that = $(this);
      grid_template_columns = grid_template_columns + " " +  _that.data("percent") + "%";
    });

    $(".donations-bars").css("grid-template-columns", grid_template_columns);

    // this is a hack to adjust space because column grid space pushes div outside of container. 
    // Will change this during proper implementation.
    $(".donations-bars").css("padding-right", (($(".donations-bars > div").length -1)* 1) + "px");  
  } 
})();