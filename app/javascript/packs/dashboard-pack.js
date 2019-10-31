import {populate_table_garden,
  populate_table_produce,
  add_garden,
  add_garden_modal,
  add_garden_modal_close,
  add_produce,
  add_produce_modal,
  add_produce_modal_close,
  update_garden_modal_close,
  update_produce_modal_close} from '../dashboard';
import M from 'materialize-css';

// Run after the page is fully loaded - TODO: Check if required
window.addEventListener('load', () => {
  M.AutoInit();
  populate_table_garden();
  populate_table_produce();
});

// Add functions called by html to global scope
window.add_garden                 = add_garden;
window.add_garden_modal           = add_garden_modal;
window.add_garden_modal_close     = add_garden_modal_close;
window.add_produce                = add_produce;
window.add_produce_modal          = add_produce_modal;
window.add_produce_modal_close    = add_produce_modal_close;
window.update_garden_modal_close  = update_garden_modal_close;
window.update_produce_modal_close = update_produce_modal_close;
