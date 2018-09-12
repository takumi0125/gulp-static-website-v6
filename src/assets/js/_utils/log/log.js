// console.log wrapper
const _ENV = require('../../_env.js');

function productionlog() {
  return
}

export default (function() {
  if (location.hostname == 'bodystyling.rizap.jp') {
    return productionlog
  }

  if (window.console != null) {
    if (window.console.log.bind != null) {
      return window.console.log.bind(window.console);
    } else {
      return window.console.log;
    }
  } else {
    return window.alert;
  }
})();
