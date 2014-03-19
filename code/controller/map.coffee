Spine = require("spine")
chroma = require("chroma-js/chroma")
Assets =  require("../assets")

Canton = require("../model/canton");


class Map extends Spine.Controller
  className: "map-controller"

  elements:
    ".list" : "list"
    ".canton-info-canvas" : "clienteCanvas"

  events:
    "click .btn-zoom" : "onZoom"

  constructor:  ->
    super
    @cantonValueName = @el.data("use")
    
    @html require("../../templates/map-layout")(assets: Assets, name: @cantonValueName )

    for path in @el.find("path")
      path = $(path)
      if path.data "id"
        path.bind "click", @onItemClick
        
      canton = Canton.getCantonFromPathId( path.data("id") )
      cantonValue = canton[ @cantonValueName + "_litros"]
      path.data("canton_id", canton.id)
      
      color = Canton.getColor( cantonValue, @scale )
      path.data "color" , color
      path.css "fill", color


    progressBar = @el.find(".progress-bar")
    progressBar.css "width", Canton.getStatPercent( @cantonValueName ) + "%"
    progressBar.html parseInt( Canton.getStatPercent( @cantonValueName ) ) + "%"


    @el.find("svg").height("500px")
    @el.find("svg").width("500px")


  onZoom: (e) ->
    target = $(e.target)
    @el.find("svg")
    type = target.data("type")
    svg = @el.find("svg")
    svg.css("height", "+=100" ) if type == "in"
    svg.css("width", "+=100" ) if type == "in"

    if type == "out"
      svg.css("height",  500  ) 
      svg.css("width",  500  )

  onItemClick: (e) =>
    target = $(e.target)
    canton = Canton.find( target.data('canton_id') )
    console.log( canton.name )
    console.log( canton[@cantonValueName + "_litros"]  )
    

module.exports = Map