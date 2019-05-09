function post_garden(name, address, lat, long, contact_name, contact_num, email, image, notes){
  var xhr = new XMLHttpRequest();
  var url = "./gardens";
  xhr.open("POST", url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var json = JSON.parse(xhr.responseText);
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
  console.log(data);
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
  var url = "./garden_produces";
  xhr.open("POST", url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var json = JSON.parse(xhr.responseText);
    }
  };
  var data = JSON.stringify({
    "garden_id" : garden_id,
    "produce_id" : produce_id,
    "available_at" : available,
    "readiness" : readiness,
    "planted_at" : planted_at
  });
  xhr.send(data);
}

function patch_garden(id, name, address, lat, long, contact_name, contact_num, email, image, notes){
  var xhr = new XMLHttpRequest();
  var url = "./gardens/"+id;
  xhr.open("PATCH", url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var json = JSON.parse(xhr.responseText);
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

function patch_produce(id, name, duration, image){
  var xhr = new XMLHttpRequest();
  var url = "./produces/" + id;
  xhr.open("PATCH", url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var json = JSON.parse(xhr.responseText);
    }
  };
  var data = JSON.stringify({
    "name": name,
    "duration": duration,
    "image" : image,
  });
  xhr.send(data);
}

function patch_garden_produce(id, garden_id, produce_id, available, readiness, planted_at){
  var xhr = new XMLHttpRequest();
  var url = "./garden_produces/" + id;
  xhr.open("PATCH", url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var json = JSON.parse(xhr.responseText);
    }
  };
  var data = JSON.stringify({
    "garden_id" : garden_id,
    "produce_id" : produce_id,
    "available_at" : available,
    "readiness" : readiness,
    "planted_at" : planted_at
  });
  xhr.send(data);
}

function delete_garden(id){
  var xhr = new XMLHttpRequest();
  var url = "./gardens/" + id
  xhr.open("DELETE", url, false);
  xhr.send();
  location.reload();
}

function delete_produce(id){
  var xhr = new XMLHttpRequest();
  var url = "./produces/" + id
  xhr.open("DELETE", url, false);
  xhr.send();
  location.reload();
}

function delete_produce_garden(id){
  var xhr = new XMLHttpRequest();
  var url = "./garden_produces/" + id
  xhr.open("DELETE", url, false);
  xhr.send();
  location.reload();
}

function delete_modal(garden_id){
  document.getElementById('delete_modal_footer').innerHTML = "<a onclick=\"delete_modal_close()\" class=\"modal-close waves-effect waves-green btn-flat\">Cancel</a><a onclick=\"delete_garden(" + garden_id + ")\" class=\"modal-close waves-effect waves-green btn-flat\">Delete</a>";
  var instance = M.Modal.getInstance(document.getElementById('delete_modal'));
  instance.open();
}

function delete_modal_close(){
  var instance = M.Modal.getInstance(document.getElementById('delete_modal'));
  instance.close();
}

function add_modal(){
  var instance = M.Modal.getInstance(document.getElementById('add_modal'));
  instance.open();
}

function add_modal_close(){
  var instance = M.Modal.getInstance(document.getElementById('add_modal'));
  instance.close();
}

function update_modal(garden_id){
  document.getElementById('update_modal_footer').innerHTML = "<a onclick=\"update_modal_close()\" class=\"modal-close waves-effect waves-green btn-flat\">Cancel</a><a onclick=\"update_garden(" + garden_id + ")\" class=\"modal-close waves-effect waves-green btn-flat\">Update</a>";
  var instance = M.Modal.getInstance(document.getElementById('update_modal'));
  instance.open();
}

function update_modal_close(){
  var instance = M.Modal.getInstance(document.getElementById('update_modal'));
  instance.close();
}

function populate_table(){
  getJSON("./gardens", function populate_table_helper_garden(data){
	 for(var i = 0; i <= data.length - 1; i++){
    document.getElementById('table').innerHTML += 
    ("<tr><td>" + data[i].name + "</td><td>" 
    + data[i].address + "</td><td>" 
    + data[i].contact_name + "</td><td>" 
    + data[i].contact_num + "</td><td>"
    + "<ul id=garden_id" + (data[i].id) + "></ul></td><td>"
    + data[i].notes + "</td><td><a onclick='delete_modal(" 
    + data[i].id + ")' class=\"waves-effect waves-teal btn-flat\"><i class=\"material-icons\">delete</i></a><a onclick='update_modal(" 
    + data[i].id + ")' class=\"waves-effect waves-teal btn-flat\"><i class=\"material-icons\">edit</i></a>" + "</td></tr>")
	 }
	 getJSON("./garden_produces", function populate_table_helper_garden_produces(data){
	 for(var i = 0; i <= data.length - 1; i++){
    document.getElementById('garden_id'+i).innerHTML += 
    ("<li><span class=\"produce_id" + data[i].produce_id + "\"></span>, " + data[i].available_at + "</li>")
	 }
	 getJSON("./produces", function populate_table_helper_produces(data){
	 for(var i = 0; i <= data.length - 1; i++){
	  var elements = document.getElementsByClassName('produce_id'+i);
	  for(var j = 0; j < elements.length; j++){
     elements[j].innerHTML += data[i].name;
	  }
	 }
  }, function(status) {
	  alert('Something went wrong.');
  });
  }, function(status) {
	  alert('Something went wrong.');
  });
  }, function(status) {
	  alert('Something went wrong.');
  });
}

function add_garden(){
  if(!RegExp('^(?!\s*$).+').test(document.forms["add_garden"]["name"].value)){
    alert("Name must contain more than whitespace.");
    return;
  }
  else if(!RegExp('^(?!\s*$).+').test(document.forms["add_garden"]["address"].value)){
    alert("Address must contain more than whitespace.");
    return;
  }
  else if(!RegExp('(^\\+?([1-8])?\\d(\\.\\d+)?$)|(^-90$)|(^-(([1-8])?\\d(\\.\\d+)?$))').test(document.forms["add_garden"]["lat"].value)){
    alert("Lattitude should be in decimal format");
    return;
  }
  else if(!RegExp('(^\\+?([1-8])?\\d(\\.\\d+)?$)|(^-90$)|(^-(([1-8])?\\d(\\.\\d+)?$))').test(document.forms["add_garden"]["long"].value)){
    alert("Longitude should be in decimal format");
    return;
  }
  else if(!RegExp('^(?!\s*$).+').test(document.forms["add_garden"]["contact_name"].value)){
    alert("Contact Name must contain more than whitespace.");
    return;
  }
  else if(!RegExp('^(?!\s*$).+').test(document.forms["add_garden"]["contact_num"].value)){
    alert("Contact Number must contain more than whitespace.");
    return;
  }
  else if(!RegExp('^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$').test(document.forms["add_garden"]["email"].value)){
    alert("This does not seem to be a valid email address. If you think this is an error contact the administrator.");
    return;
  }
  else{
    post_garden( document.forms["add_garden"]["name"].value,
                 document.forms["add_garden"]["address"].value,
                 document.forms["add_garden"]["lat"].value,
                 document.forms["add_garden"]["long"].value,
                 document.forms["add_garden"]["contact_name"].value,
                 document.forms["add_garden"]["contact_num"].value,
                 document.forms["add_garden"]["email"].value,
                 document.forms["add_garden"]["image"].value,
                 document.forms["add_garden"]["notes"].value,
                );
    M.toast({html: 'Garden Updated!'})
  }
}

function update_garden(id){
  if(!RegExp('^(?!\s*$).+').test(document.forms["update_garden"]["name"].value)){
    alert("Name must contain more than whitespace.");
    return;
  }
  else if(!RegExp('^(?!\s*$).+').test(document.forms["update_garden"]["address"].value)){
    alert("Address must contain more than whitespace.");
    return;
  }
  else if(!RegExp('(^\\+?([1-8])?\\d(\\.\\d+)?$)|(^-90$)|(^-(([1-8])?\\d(\\.\\d+)?$))').test(document.forms["update_garden"]["lat"].value)){
    alert("Lattitude should be in decimal format");
    return;
  }
  else if(!RegExp('(^\\+?([1-8])?\\d(\\.\\d+)?$)|(^-90$)|(^-(([1-8])?\\d(\\.\\d+)?$))').test(document.forms["update_garden"]["long"].value)){
    alert("Longitude should be in decimal format");
    return;
  }
  else if(!RegExp('^(?!\s*$).+').test(document.forms["update_garden"]["contact_name"].value)){
    alert("Contact Name must contain more than whitespace.");
    return;
  }
  else if(!RegExp('^(?!\s*$).+').test(document.forms["update_garden"]["contact_num"].value)){
    alert("Contact Number must contain more than whitespace.");
    return;
  }
  else if(!RegExp('^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$').test(document.forms["update_garden"]["email"].value)){
    alert("This does not seem to be a valid email address. If you think this is an error contact the administrator.");
    return;
  }
  else{
    patch_garden(id,
                document.forms["update_garden"]["name"].value,
                document.forms["update_garden"]["address"].value,
                document.forms["update_garden"]["lat"].value,
                document.forms["update_garden"]["long"].value,
                document.forms["update_garden"]["contact_name"].value,
                document.forms["update_garden"]["contact_num"].value,
                document.forms["update_garden"]["email"].value,
                document.forms["update_garden"]["image"].value,
                document.forms["update_garden"]["notes"].value,
                );
    M.toast({html: 'Garden Updated!'})
  }
}

window.onload = function(){
  M.AutoInit();
  populate_table();
}