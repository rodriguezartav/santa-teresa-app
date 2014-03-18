Spine = require("spine")
chroma = require("chroma-js/chroma")

class Map extends Spine.Controller
  className: "app-canvas water-availability full-height"

  elements:
    ".list" : "list"
    ".canton-info-canvas" : "clienteCanvas"

  events:
    "click .btn-zoom" : "onZoom"

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

  constructor: ->
    super

    @assets =  require("../assets")
  ##  @scale = chroma.scale(['#c49cde', '#62c2e4']).domain([0, 30], 4);
    
    @scale = chroma.scale(['#f0776c','#fecf71', "f7fdca" , '#c4e17f']).domain([0, 3, 5, 10, 15, 50]);
    
    @cantonesGADM = {}
    @GADMcantones = {}

    @transformGADMCanton()
    
    @html require("../../templates/map-layout")(assets: @assets , scale: @scale)
    
    width = $(".map-wrapper").innerWidth()
    $("svg").css("width",  width);
    $("svg").css("height", width );

    @paths= @el.find("path")
    
    #@loadCantonInfo()

  loadCantonInfo: =>
    for path in @paths
      path = $(path)
      if path.data "id"
        path.bind "click", @onItemClick
        
      GADMId = path.data("id")
      canton = @GADMcantones[GADMId]

      clientes = Cliente.findAllByAttribute("SubRuta__c", canton.toString() )
      
      color = @scale(clientes.length);
      path.data "color" , color

      path.css "fill", color

  transformGADMCanton: =>  
    @GADMcantones = JSON.parse(@assets.cantonesGADM)
    for cantonGADM, canton of @GADMcantones
      @cantonesGADM[canton] = cantonGADM

  onItemClick: (e) =>
    target = $(e.target)

    
    prevSelectedPath = $('path').filter ->
      $(@).css('fill') == "#ffa500"

    prevSelectedPath.css("fill", prevSelectedPath.data("color"))
    
    target.css("fill", "#ffa500")
    
    id = target.data "id"
    target.data
    cantonId = @GADMcantones[id]
    @currentclientes = Cliente.findAllByAttribute("SubRuta__c", cantonId.toString())
    
    Cliente.trigger("select", @currentclientes)

    ##@clienteCanvas.html require("../../templates/popOverItem")(@currentclientes)
       
    #@el.find(".pop-over-menu-item").on "click" , @onPopOverMenuItemClick

    mixpanel.track "Canton Click", canton: @cantonId

  onPopOverMenuItemAtras: (e) =>
    @clienteCanvas.html @oldHtml

  onPopOverMenuItemClick: (e) =>
    target = $(e.target)
    menu = target.data "menu"

    @oldHtml = @clienteCanvas.find(".wrapper").detach();
    
    @clienteCanvas.html require("../../templates/popOverItem_#{menu}")(@currentCanton)

    $(".popOverMenuAtras").one "click" , @onPopOverMenuItemAtras

  onPopOverClose: ->
    $("path").popover('destroy')

  shutdown: ->
    $(".popOverClose").off "click",  @onPopOverClose


module.exports = Map