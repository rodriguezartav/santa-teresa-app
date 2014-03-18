var _3vot = require("./index")

function registerProviders(passedLoginProviders){
  for(loginProviderIndex in passedLoginProviders){
    var loginProvider = passedLoginProviders[loginProviderIndex];
    _3vot.loginProviders[loginProvider.name] = loginProvider.getProviderObject();
  }
}

function loginWithAllProviders(callback){
  request = new XMLHttpRequest
  request.withCredentials = true;
  request.open('GET', _3vot.endpoint + '/logins', true)
  request.send()

  request.onload = function() {
    _3vot.logins = JSON.parse(this.response)
    
    for( loginProviderKey in _3vot.loginProviders ){
      var loginProvider = _3vot.loginProviders[loginProviderKey]
      var shouldLogin = !loginProvider.validateProviderFromLogins();
      if( shouldLogin  ) return loginProvider.action();
    }
    
    callback(null, true);
  }

  request.onerror = function(err) {
    callback(err);
  }

}

module.exports = {
  registerProviders: registerProviders,
  loginWithAllProviders: loginWithAllProviders
}
