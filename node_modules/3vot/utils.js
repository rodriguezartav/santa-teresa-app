module.exports = {

  getCurrentUrl: function (){
    var currentUrl = window.location.href
    lastIndex = currentUrl[currentUrl.length -1];
    if(lastIndex != "/") currentUrl += "/"
    return currentUrl;
  },
  
  replaceAll: function (str, find, replace) {
    return str.replace(new RegExp(find.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'), 'g'), replace);
  }
  
}