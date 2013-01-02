$(document).ready(function(){
  var transition = 500;
  
  $("li").click(function () {
   var id = this.id;
   var id_i = '#' + id + '_i';
   var id_t = '#' + id + '_t';
   var img_in = $(id_i);
   var news_in = $(id_t);
   var img_out = $('.news_img:visible');
   var news_out = $('.jScrollbar_mask:visible');

   img_out.hide('slide',{direction: "right"},transition);
   news_out.hide('slide',{direction: "right"},transition);
   img_in.show('slide',{direction: "left"},transition);
   news_in.show('slide',{direction: "left"},transition,
   	function(){
	 $(".jScrollbar_mask").css("top","0px");
         $(".jScrollbar_draggable a").css("top","0px");
         var js_mask = $('.jScrollbar_mask:visible');
         var js_news = $('.jScrollbar_news');	      
	 var diff = parseInt(js_mask.innerHeight()) - parseInt(js_news.height());
         if(diff < 0) $('.jScrollbar_draggable').hide();
	 else $('.jScrollbar_draggable').show();
       }
   );

  });
  
});
