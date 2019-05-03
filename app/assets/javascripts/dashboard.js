function post_garden(name, address, lat, long, contact_name, contact_num, email, image, notes){
  var xhr = new XMLHttpRequest();
  var url = "./gardens";
  xhr.open("POST", url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var json = JSON.parse(xhr.responseText);
        console.log(json);
    }
  };
  var data = JSON.stringify({
    "name": name,
    "address": address,
    "lat" : lat,
    "long" : long,
    "contact_name" : contact_name,
    "contact_num" : contact_num,
    "email" : email,
    "image" : image,
    "notes" : notes
  });
  xhr.send(data);
}

function post_produce(name, duration, image){
  var xhr = new XMLHttpRequest();
  var url = "./produces";
  xhr.open("POST", url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var json = JSON.parse(xhr.responseText);
        console.log(json);
    }
  };
  var data = JSON.stringify({
    "name": name,
    "duration": duration,
    "image" : image,
  });
  xhr.send(data);
}

function post_garden_produce(garden_id, produce_id, available, readiness, planted_at){
  var xhr = new XMLHttpRequest();
  var url = "./produces";
  xhr.open("POST", url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var json = JSON.parse(xhr.responseText);
        console.log(json);
    }
  };
  var data = JSON.stringify({
    "garden_id" : garden_id,
    "produce_id" : produce_id,
    "available" : available,
    "readiness" : readiness,
    "planted_at" : planted_at
  });
  xhr.send(data);
}

var getJSON = function(url) {
	return new Promise(function(resolve, reject) {
		var xhr = new XMLHttpRequest();
		xhr.open('get', url, true);
		xhr.responseType = 'json';
		xhr.onload = function() {
			var status = xhr.status;
			if (status == 200) {
				resolve(xhr.response);
			} else {
				reject(status);
			}
		};
		xhr.send();
	});
};


var get_gardens = function() {
  return getJSON("./gardens")
};

var get_produce = function() {
  return getJSON("./produces")
};

var get_garden_produces = function() {
  return getJSON("./garden_produces")
};

function test(){
  get_gardens().then(function(data){
    console.log(data);
  })
  get_produce().then(function(data){
    console.log(data);
  })
  get_garden_produces().then(function(data){
    console.log(data);
  })
  post_garden("xyz", "xyz", "1", "1", "xyz", "123", "xyz", "xyz", "xyz");
}

window.addEventListener("load", test());