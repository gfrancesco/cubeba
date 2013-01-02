$(document).ready(function(){
  var transition = 500;
  
 $("#arrow_right").click(function () {
     var img_in = $(".news_img:visible + .news_img").filter(":first");
     var news_in = $(".jScrollbar_mask:visible + .jScrollbar_mask").filter(":first");
     if (img_in.length == 0) img_in = $(".news_img").filter(":first");
     if (news_in.length == 0) news_in = $(".jScrollbar_mask").filter(":first");
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
 
 $("#arrow_left").click(function () {
     var img_out = $('.news_img:visible');
     var news_out = $('.jScrollbar_mask:visible');
     var prev_index = img_out.index()-1;
     var img_in = $(".news_img").eq(prev_index);
     var news_in = $(".jScrollbar_mask").eq(prev_index);
     img_out.hide('slide',{direction: "left"},transition);
     news_out.hide('slide',{direction: "left"},transition);
     img_in.show('slide',{direction: "right"},transition);
     news_in.show('slide',{direction: "right"},transition,
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
