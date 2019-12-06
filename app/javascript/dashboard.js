import {getJSON} from './misc';
import M from 'materialize-css';

function post_garden(name, address, lat, long, contact_name, contact_num, email, image, notes) {
  const xhr = new XMLHttpRequest();
  const url = './gardens';
  xhr.open('POST', url, true);
  xhr.setRequestHeader('Content-Type', 'application/json');
  //xhr.onreadystatechange = function () {
  //  if (xhr.readyState === 4 && xhr.status === 200) {
  //    const json = JSON.parse(xhr.responseText);
  //  }
  //};
  const data = JSON.stringify({
    'name': name,
    'address': address,
    'lat' : lat,
    'long' : long,
    'contact_name' : contact_name,
    'contact_number' : contact_num,
    'email' : email,
    'image' : image,
    'notes' : notes
  });
  console.log(data);
  xhr.send(data);
}

function post_produce(name, duration, image) {
  const xhr = new XMLHttpRequest();
  const url = './produces';
  xhr.open('POST', url, true);
  xhr.setRequestHeader('Content-Type', 'application/json');
  //xhr.onreadystatechange = function () {
  //  if (xhr.readyState === 4 && xhr.status === 200) {
  //    const json = JSON.parse(xhr.responseText);
  //  }
  //};

  const data = JSON.stringify({
    'name': name,
    'duration': duration,
    'image' : image,
  });
  xhr.send(data);
}

//function post_garden_produce(garden_id, produce_id, available, readiness, planted_at) {
//  const xhr = new XMLHttpRequest();
//  const url = './garden_produces';
//  xhr.open('POST', url, true);
//  xhr.setRequestHeader('Content-Type', 'application/json');
//  xhr.onreadystatechange = function () {
//    if (xhr.readyState === 4 && xhr.status === 200) {
//      const json = JSON.parse(xhr.responseText);
//    }
//  };
//  const data = JSON.stringify({
//    'garden_id' : garden_id,
//    'produce_id' : produce_id,
//    'available_at' : available,
//    'readiness' : readiness,
//    'planted_at' : planted_at
//  });
//  xhr.send(data);
//}

function patch_garden(id, name, address, lat, long, contact_name, contact_num, email, image, notes) {
 const xhr = new XMLHttpRequest();
 const url = `./gardens/${id}`;
 xhr.open('PATCH', url, true);
 xhr.setRequestHeader('Content-Type', 'application/json');
 //xhr.onreadystatechange = function () {
 //  if (xhr.readyState === 4 && xhr.status === 200) {
 //    const json = JSON.parse(xhr.responseText);
 //  }
 //};
 const data = JSON.stringify({
   'name': name,
   'address': address,
   'lat' : lat,
   'long' : long,
   'contact_name' : contact_name,
   'contact_number' : contact_num,
   'email' : email,
   'image' : image,
   'notes' : notes
 });
 xhr.send(data);
}

function patch_produce(id, name, duration, image) {
 const xhr = new XMLHttpRequest();
 const url = `./produces/${  id}`;
 xhr.open('PATCH', url, true);
 xhr.setRequestHeader('Content-Type', 'application/json');
 //xhr.onreadystatechange = function () {
 //  if (xhr.readyState === 4 && xhr.status === 200) {
 //    const json = JSON.parse(xhr.responseText);
 //  }
 //};
 const data = JSON.stringify({
   'name': name,
   'duration': duration,
   'image' : image,
 });
 xhr.send(data);
}

// function patch_garden_produce(id, garden_id, produce_id, available, readiness, planted_at) {
//  const xhr = new XMLHttpRequest();
//  const url = `./garden_produces/${  id}`;
//  xhr.open('PATCH', url, true);
//  xhr.setRequestHeader('Content-Type', 'application/json');
//  xhr.onreadystatechange = function () {
//    if (xhr.readyState === 4 && xhr.status === 200) {
//      const json = JSON.parse(xhr.responseText);
//    }
//  };
//  const data = JSON.stringify({
//    'garden_id' : garden_id,
//    'produce_id' : produce_id,
//    'available_at' : available,
//    'readiness' : readiness,
//    'planted_at' : planted_at
//  });
//  xhr.send(data);
// }

export function delete_garden(id) {
 const xhr = new XMLHttpRequest();
 const url = `./gardens/${  id}`;
 xhr.open('DELETE', url, false);
 xhr.send();
 location.reload();
}

export function delete_produce(id) {
 const xhr = new XMLHttpRequest();
 const url = `./produces/${  id}`;
 xhr.open('DELETE', url, false);
 xhr.send();
 location.reload();
}

//function delete_produce_garden(id) {
//  const xhr = new XMLHttpRequest();
//  const url = `./garden_produces/${  id}`;
//  xhr.open('DELETE', url, false);
//  xhr.send();
//  location.reload();
//}

export function delete_garden_modal(garden_id) {
 document.getElementById('delete_garden_modal_footer').innerHTML = `
   <a onclick="delete_garden_modal_close()" class="modal-close waves-effect waves-green btn-flat">
     Cancel
   </a>
   <a onclick="delete_garden(${garden_id})" class="modal-close waves-effect waves-green btn-flat">
     Delete
   </a>`;

 const instance = M.Modal.getInstance(document.getElementById('delete_garden_modal'));
 instance.open();
}

function delete_garden_modal_close() {
 const instance = M.Modal.getInstance(document.getElementById('delete_garden_modal'));
 instance.close();
}

export function add_garden_modal() {
  const instance = M.Modal.getInstance(document.getElementById('add_garden_modal'));
  instance.open();
}

export function add_garden_modal_close() {
  const instance = M.Modal.getInstance(document.getElementById('add_garden_modal'));
  instance.close();
}

export function update_garden_modal(garden_id) {
 document.getElementById('update_garden_modal_footer').innerHTML = `
   <a onclick="update_garden_modal_close()" class="modal-close waves-effect waves-green btn-flat">
     Cancel
   </a>
   <a onclick="update_garden(${garden_id})" class="modal-close waves-effect waves-green btn-flat">
     Update
   </a>`;

 const instance = M.Modal.getInstance(document.getElementById('update_garden_modal'));
 instance.open();
}

export function update_garden_modal_close() {
  const instance = M.Modal.getInstance(document.getElementById('update_garden_modal'));
  instance.close();
}

export function populate_table_garden() {
  getJSON('./gardens', (data) => {
    for (let i = 0; i <= data.length - 1; i++) {
      document.getElementById('garden_table').innerHTML += `
        <tr>
          <td>${data[i].name}</td>
          <td>${data[i].address}</td>
          <td>${data[i].lat}, ${data[i].long}</td>
          <td>${data[i].contact_name}</td>
          <td>${data[i].contact_number}</td>
          <td>
            <ul id=garden_id${data[i].id}></ul>
          </td>
          <td>${data[i].notes}</td>
          <td>
            <a onclick='delete_garden_modal(${data[i].id})' class="waves-effect waves-teal btn-flat">
              <i class="material-icons">delete</i>
            </a>
            <a onclick='update_garden_modal(${data[i].id})' class="waves-effect waves-teal btn-flat">
              <i class="material-icons">edit</i>
            </a>
          </td>
        </tr>`;

      console.log(typeof data[i].contact_name);
    }
    getJSON('./garden_produces', (data) => {
      for (let i = 0; i <= data.length - 1; i++) {
        document.getElementById(`garden_id${data[i].garden_id}`).innerHTML += `
          <li>
            <span class="produce_id${data[i].produce_id}"></span>,
            ${data[i].available_at}
          </li>`;
      }
      getJSON('./produces', (data) => {
        for (let i = 0; i <= data.length - 1; i++) {
          const elements = document.getElementsByClassName(`produce_id${i}`);
          for (let j = 0; j < elements.length; j++) {
            elements[j].innerHTML += data[i].name;
          }
        }
      }, (status) => {
        alert(`Something went wrong: ${status}`);
      });
    }, (status) => {
      alert(`Something went wrong: ${status}`);
    });
  }, (status) => {
    alert(`Something went wrong: ${status}`);
  });
}

export function add_garden() {
  if (!RegExp('^(?!\\s*$).+').test(document.forms['add_garden']['name'].value)) {
    alert('Name must contain more than whitespace.');
    return;
  } else if (!RegExp('^(?!\\s*$).+').test(document.forms['add_garden']['address'].value)) {
    alert('Address must contain more than whitespace.');
    return;
  } else if (!RegExp('(^\\+?([1-8])?\\d(\\.\\d+)?$)|(^-90$)|(^-(([1-8])?\\d(\\.\\d+)?$))').test(document.forms['add_garden']['lat'].value)) {
    alert('Lattitude should be in decimal format');
    return;
  } else if (!RegExp('(^\\+?([1-8])?\\d(\\.\\d+)?$)|(^-90$)|(^-(([1-8])?\\d(\\.\\d+)?$))').test(document.forms['add_garden']['long'].value)) {
    alert('Longitude should be in decimal format');
    return;
  } else if (!RegExp('^(?!\\s*$).+').test(document.forms['add_garden']['contact_name'].value)) {
    alert('Contact Name must contain more than whitespace.');
    return;
  } else if (!RegExp('^(?!\\s*$).+').test(document.forms['add_garden']['contact_num'].value)) {
    alert('Contact Number must contain more than whitespace.');
    return;
  } else if (!RegExp('^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$').test(document.forms['add_garden']['email'].value)) {
    alert('This does not seem to be a valid email address. If you think this is an error contact the administrator.');
    return;
  } else {
    post_garden( document.forms['add_garden']['name'].value,
      document.forms['add_garden']['address'].value,
      document.forms['add_garden']['lat'].value,
      document.forms['add_garden']['long'].value,
      document.forms['add_garden']['contact_name'].value,
      document.forms['add_garden']['contact_num'].value,
      document.forms['add_garden']['email'].value,
      document.forms['add_garden']['image'].value,
      document.forms['add_garden']['notes'].value,
    );
    M.toast({html: 'Garden Added!'});
  }
}

export function update_garden(id) {
 if (!RegExp('^(?!\\s*$).+').test(document.forms['update_garden']['name'].value)) {
   alert('Name must contain more than whitespace.');
   return;
 } else if (!RegExp('^(?!\\s*$).+').test(document.forms['update_garden']['address'].value)) {
   alert('Address must contain more than whitespace.');
   return;
 } else if (!RegExp('(^\\+?([1-8])?\\d(\\.\\d+)?$)|(^-90$)|(^-(([1-8])?\\d(\\.\\d+)?$))').test(document.forms['update_garden']['lat'].value)) {
   alert('Lattitude should be in decimal format');
   return;
 } else if (!RegExp('(^\\+?([1-8])?\\d(\\.\\d+)?$)|(^-90$)|(^-(([1-8])?\\d(\\.\\d+)?$))').test(document.forms['update_garden']['long'].value)) {
   alert('Longitude should be in decimal format');
   return;
 } else if (!RegExp('^(?!\\s*$).+').test(document.forms['update_garden']['contact_name'].value)) {
   alert('Contact Name must contain more than whitespace.');
   return;
 } else if (!RegExp('^(?!\\s*$).+').test(document.forms['update_garden']['contact_num'].value)) {
   alert('Contact Number must contain more than whitespace.');
   return;
 } else if (!RegExp('^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$').test(document.forms['update_garden']['email'].value)) {
   alert('This does not seem to be a valid email address. If you think this is an error contact the administrator.');
   return;
 } else {
   patch_garden(id,
     document.forms['update_garden']['name'].value,
     document.forms['update_garden']['address'].value,
     document.forms['update_garden']['lat'].value,
     document.forms['update_garden']['long'].value,
     document.forms['update_garden']['contact_name'].value,
     document.forms['update_garden']['contact_num'].value,
     document.forms['update_garden']['email'].value,
     document.forms['update_garden']['image'].value,
     document.forms['update_garden']['notes'].value,
   );
   M.toast({html: 'Garden Updated!'});
 }
}

export function delete_produce_modal(produce_id) {
 document.getElementById('delete_produce_modal_footer').innerHTML = `
   <a onclick="delete_produce_modal_close()" class="modal-close waves-effect waves-green btn-flat">
     Cancel
   </a>
   <a onclick="delete_produce(${produce_id})" class="modal-close waves-effect waves-green btn-flat">
     Delete
   </a>`;

 const instance = M.Modal.getInstance(document.getElementById('delete_produce_modal'));
 instance.open();
}

function delete_produce_modal_close() {
 const instance = M.Modal.getInstance(document.getElementById('delete_produce_modal'));
 instance.close();
}

export function add_produce_modal() {
  const instance = M.Modal.getInstance(document.getElementById('add_produce_modal'));
  instance.open();
}

export function add_produce_modal_close() {
  const instance = M.Modal.getInstance(document.getElementById('add_produce_modal'));
  instance.close();
}

export function update_produce_modal_attempt2(produce_id) {
 document.getElementById('update_produce_modal_footer').innerHTML = `
   <a onclick="update_produce_modal_close()" class="modal-close waves-effect waves-green btn-flat">
     Cancel
   </a>
   <a onclick="update_produce(${produce_id})" class="modal-close waves-effect waves-green btn-flat">
     Update
   </a>`;

 const instance = M.Modal.getInstance(document.getElementById('update_produce_modal'));
 instance.open();
}

export function update_produce_modal_close() {
  const instance = M.Modal.getInstance(document.getElementById('update_produce_modal'));
  instance.close();
}

export function populate_table_produce() {
  getJSON('./produces', (data) => {
    for (let i = 0; i <= data.length - 1; i++) {
      document.getElementById('produces_table').innerHTML += `
      <tr>
        <td>${data[i].name}</td>
        <td>${data[i].duration}</td>
        <td>${data[i].image}</td>
        <td>
          <a onclick='delete_produce_modal(${data[i].id})' class="waves-effect waves-teal btn-flat">
            <i class="material-icons">delete</i>
          </a>
          <a onclick='update_produce_modal_attempt2(${data[i].id})' class="waves-effect waves-teal btn-flat">
            <i class="material-icons">edit</i>
          </a>
        </td>
      </tr>`;
    }
  }, (status) => {
    alert(`Something went wrong: ${status}`);
  });
}

export function add_produce() {
  if (!RegExp('^(?!\\s*$).+').test(document.forms['add_produce']['name'].value)) {
    alert('Name must contain more than whitespace.');
    return;
  } else if (!RegExp('^(?!\\s*$).+').test(document.forms['add_produce']['duration'].value)) {
    alert('Duration must contain more than whitespace.');
    return;
  } else if (!RegExp('^(?!\\s*$).+').test(document.forms['add_produce']['image'].value)) {
    alert('Image must contain more than whitespace.');
    return;
  } else {
    post_produce( document.forms['add_produce']['name'].value,
      document.forms['add_produce']['duration'].value,
      document.forms['add_produce']['image'].value,
    );
    M.toast({html: 'Produce Added!'});
  }
}

export function update_produce(id) {
 if (!RegExp('^(?!\\s*$).+').test(document.forms['update_produce']['name'].value)) {
   alert('Name must contain more than whitespace.');
   return;
 } else if (!RegExp('^(?!\\s*$).+').test(document.forms['update_produce']['duration'].value)) {
   alert('Duration must contain more than whitespace.');
   return;
 } else if (!RegExp('^(?!\\s*$).+').test(document.forms['update_produce']['image'].value)) {
   alert('Image must contain more than whitespace.');
   return;
 } else {
   patch_produce(id,
     document.forms['update_produce']['name'].value,
     document.forms['update_produce']['duration'].value,
     document.forms['update_produce']['image'].value,
   );
   M.toast({html: 'Produce Updated!'});
 }
}
