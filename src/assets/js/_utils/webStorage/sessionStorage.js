// localStorage
var isSessionStorageAvailable = true;
var setSessionStorage, getSessionStorage, removeSessionStorage, clearSessionStorage;

if(window.localStorage) {
  try {
    localStorage.setItem('checkIfUseSessionStorage', '1');
    localStorage.removeItem('checkIfUseSessionStorage');
  } catch (err) {
    isSessionStorageAvailable = false;
  }
} else {
  isSessionStorageAvailable = false;
}

if(isSessionStorageAvailable) {
  setSessionStorage = function(key, value) {
    return localStorage.setItem(key, value);
  }
  getSessionStorage = function(key) {
    return localStorage.getItem(key);
  }
  removeSessionStorage = function(key) {
    return localStorage.removeItem(key);
  }
  clearSessionStorage = function() {
    return localStorage.clear();
  }
} else {
  setSessionStorage = function() { return null }
  getSessionStorage = function() { return null }
  removeSessionStorage = function() { return null }
  clearSessionStorage = function() { return null }
}

export { setSessionStorage, getSessionStorage, removeSessionStorage, clearSessionStorage };
