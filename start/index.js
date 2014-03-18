var _3vot = require("3vot");
var fs = require("fs");
var app = require("../code/index.js")

document.body.innerHTML = fs.readFileSync("./apps/water/templates/layout.html");

var package = require("../package")

_3vot.init( {
  package: package,
  loginProviders: [ ] ,
  app: app
});




