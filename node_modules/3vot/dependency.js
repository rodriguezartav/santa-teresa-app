var _3vot = require("3vot")

module.exports = {}
module.exports.getDependencyName = getDependencyName;
module.exports.loadDependency = loadDependency;

function getDependencyName(package){

  var deps = package.threevot.external;
  var composedDeps = [];
  var git = package.threevot.gitDependencies;
  var npm = package.dependencies;

  var keys = Object.keys(deps)
  var index = keys.length - 1
  while(index >= 0){
    dep = keys[index]
    composedDeps.push(dep + "-" + (npm[dep] || git[dep]) );
    index--;
  }

  return composedDeps.join("--");
}

function loadDependency(callback){
  LazyLoad = require("./lib/lazyload");
  var depName = getDependencyName(_3vot.package)

  if(depName.length == 0) return callback()

  return LazyLoad.js("/" + _3vot.package.profile + "/dependencies/" + depName + ".js", function() {
    callback(null)
  });
}
