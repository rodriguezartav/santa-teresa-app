var chroma = require("chroma-js/chroma")

module.exports = function(){
  var $ = require("jqueryify")
  var Spine = require("spine")
  Spine.$ = $;
  
  var Canton = require("./model/canton");
  
  var CantonMap = require("./controller/map");
  
    Canton.bind("refresh", function(){
      Canton.generateStats()
      
      var scale = chroma.scale(['#efefef', '#016c59']).domain([0,100,200,300,500,1000,1500,2000,3000,5000,7000,8000,10000,12000], 7, 'quantiles');
      
      $(".map-src").each(function( index, map ){
        new CantonMap( { el: $(map), scale: scale } );
      })
    })

  Canton.refresh( require("../assets/water_use_by_canton_2012.json") )

}
