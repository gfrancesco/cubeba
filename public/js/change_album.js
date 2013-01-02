$(document).ready(function(){
  
  $(".link").click(function () {
   $("#gallery_left_column p:not(.link)").addClass("link");
   var id = this.id;
   $(this).removeClass("link");
   $(".jScrollbar_mask").css("top","0px");
   $(".jScrollbar_draggable a").css("top","0px");
   $(".jScrollbar_mask").load(
    id+".html", //pagina da caricare
    {}, //un oggetto JavaScript vuoto = nessun dato da inviare
    function () { //funzione di callback
         $("a[rel=thumb]").colorbox();
	 var js_mask = $('.jScrollbar_mask:visible');
         var js_news = $('.jScrollbar_gallery');	      
	 var diff = parseInt(js_mask.innerHeight()) - parseInt(js_news.height());
         if(diff < 0) $('.jScrollbar_draggable').hide();
	 else{
	   $('.jScrollbar_draggable').show();
	   $('.jScrollbar_gallery').jScrollbar({
	    allowMouseWheel : true,
	    scrollStep : 10
	   });
	 }
    }
   );
  });
  
});