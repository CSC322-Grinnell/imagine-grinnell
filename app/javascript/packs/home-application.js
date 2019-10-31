/* eslint no-console:0 */
// This file (and any others in this directory) serves as an entrypoint for application
// javascript.
// You should probably put application logic in other files, and then import things here
// and make one or two function calls.
// You're therefore encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'home-application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import {initMap, populate_produces} from '../home';
import {withGoogle} from '../google';
withGoogle((google) => {
  initMap(google);
  populate_produces();
});
