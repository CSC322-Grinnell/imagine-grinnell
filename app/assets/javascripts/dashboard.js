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

function delete_garden(garden_id){
  var xhr = new XMLHttpRequest();
  var url = "./gardens/" + garden_id
  xhr.open("DELETE", url, false);
  xhr.send();
  location.reload();
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
    "available" : available,
    "readiness" : readiness,
    "planted_at" : planted_at
  });
  xhr.send(data);
}

function delete_modal(garden_id){
  document.getElementById('delete_modal_footer').innerHTML = "<a onclick=\"delete_modal_close()\" class=\"modal-close waves-effect waves-green btn-flat\">Cancel</a><a onclick=\"delete_garden(" + garden_id + ")\" class=\"modal-close waves-effect waves-green btn-flat\">Delete</a>";
  document.getElementById('delete_modal').style.display = "block";//Messed around with reccomended ways of doing it and couldn't get them to work so doing it this way. Sorry.
}

function delete_modal_close(){
  document.getElementById('delete_modal').style.display = "none";//Messed around with reccomended ways of doing it and couldn't get them to work so doing it this way. Sorry.
}

function populate_table(){
  getJSON("./gardens", function populate_table_helper_garden(data){
	 for(var i = 0; i <= data.length - 1; i++){
    document.getElementById('table').innerHTML += 
    ("<tr><td>" + data[i].name + "</td><td>" 
    + data[i].address + "</td><td>" 
    + data[i].contact_name + ", " 
    + data[i].contact_num + "</td><td>"
    + "<ul id=garden_id" + (data[i].id) + "></ul></td><td>"
    + data[i].notes + "</td><td><a onclick='delete_modal(" 
    + data[i].id + ")' class=\"waves-effect waves-teal btn-flat\"><i class=\"material-icons\">delete</i></a>"
    + "" + "</td></tr>")
	 }
  }, function(status) {
	  alert('Something went wrong.');
  });
  getJSON("./garden_produces", function populate_table_helper_garden_produces(data){
	 for(var i = 0; i <= data.length - 1; i++){
    document.getElementById('garden_id'+i).innerHTML += 
    ("<li>" + data[i].produce_id + "</li>")
	 }
  }, function(status) {
	  alert('Something went wrong.');
  });
}

window.onload = function(){
  populate_table();
}