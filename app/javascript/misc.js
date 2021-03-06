export function getJSON(url, successHandler, errorHandler) {
  const xhr = typeof XMLHttpRequest !== 'undefined'
    ? new XMLHttpRequest()
    : new ActiveXObject('Microsoft.XMLHTTP'); // eslint-disable-line no-undef
  xhr.open('get', url, true);
  xhr.onreadystatechange = function() {
    let status;
    let data;
    // https://xhr.spec.whatwg.org/#dom-xmlhttprequest-readystate
    if (xhr.readyState === 4) { // `DONE`
      status = xhr.status;
      if (status === 200) {
        data = JSON.parse(xhr.responseText);
        successHandler && successHandler(data);
      } else {
        errorHandler && errorHandler(status);
      }
    }
  };
  xhr.send();
}
