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

var get_gardens = function() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', './gardens', true);
    xhr.responseType = 'json';
    xhr.onload = function() {
      var status = xhr.status;
      if (status === 200) {
        return xhr.response;
      } else {
        console.error("Something went wrong")
      }
    };
    xhr.send();
};

var get_produce = function() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', './produces', true);
    xhr.responseType = 'json';
    xhr.onload = function() {
      var status = xhr.status;
      if (status === 200) {
        return xhr.response;
      } else {
        console.error("Something went wrong")
      }
    };
    xhr.send();
};

var get_garden_produces = function() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', './garden_produces', true);
    xhr.responseType = 'json';
    xhr.onload = function() {
      var status = xhr.status;
      if (status === 200) {
        return xhr.response;
      } else {
        console.error("Something went wrong")
      }
    };
    xhr.send();
};

function test(){
  console.log(get_garden_produces());
}
window.addEventListener("load", test());