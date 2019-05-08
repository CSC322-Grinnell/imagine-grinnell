//= require jquery  
//= require turbolinks  
//= require materialize

var getJSON = function(url, successHandler, errorHandler) {
	var xhr = typeof XMLHttpRequest != 'undefined'
		? new XMLHttpRequest()
		: new ActiveXObject('Microsoft.XMLHTTP');
	xhr.open('get', url, true);
	xhr.onreadystatechange = function() {
		var status;
		var data;
		// https://xhr.spec.whatwg.org/#dom-xmlhttprequest-readystate
		if (xhr.readyState == 4) { // `DONE`
			status = xhr.status;
			if (status == 200) {
				data = JSON.parse(xhr.responseText);
				successHandler && successHandler(data);
			} else {
				errorHandler && errorHandler(status);
			}
		}
	};
	xhr.send();
};