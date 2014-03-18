module.exports = function(){
  var $ = require("jqueryify")
  var Spine = require("spine")
  Spine.$ = $;
  
  var Canton = require("./model/canton");
  
  var ClientesMap = require("./controller/map");
  
  var clientesMap = new ClientesMap({ el: $(".map-src")  });
  
  var j = require("../assets/cantones.json")
  
  console.log(j)
  
}

// Here you can require other files
//require('./app');

// Third party libraries/frameworks.
//require('angular/angular');
//require('jquery');

// And even resources on the internet
// lazyload( url, function(){} );
