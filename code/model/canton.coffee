Spine = require('spine')
Assets = require("../assets")


class Canton extends Spine.Model 
  @configure "Canton", "name"
  
  @getCantonId: (pathId) ->
    return Assets.cantonesGADM[pathId]

  @getCantonFromPathId: (pathId) ->
    return Canton.find( @getCantonId(pathId) )

  @stats= {
    humano : 0 ,
    turistico:0 ,
    agroganaderia:0 ,
    industrial:0 ,
    total: 0
  }
  
  @generateStats: ->
    for canton in Canton.all()
      total = 0;
      for index, value in @stats
        value = canton[index + "_litros"]
        @stats[index] += value
        @stats.total += value

  @getStatPercent: (stat) ->
    return ( @stats[stat] / @stats["total"] ) * 100

  @getColor: (cantonValue, scale) ->
    color = scale(cantonValue).hex();

  
module.exports = Canton