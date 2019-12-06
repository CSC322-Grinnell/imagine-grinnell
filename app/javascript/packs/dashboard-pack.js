import {populate_table_garden,
  populate_table_produce,
  add_garden,
  add_garden_modal,
  add_garden_modal_close,
  add_produce,
  add_produce_modal,
  add_produce_modal_close,
  update_produce,
  update_produce_modal_attempt2,
  update_garden,
  update_garden_modal,
  update_garden_modal_close,
  update_produce_modal_close,
  delete_garden_modal,
  delete_produce_modal,
  delete_produce,
  delete_garden} from '../dashboard';
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
window.update_garden_modal        = update_garden_modal;
window.update_garden              = update_garden;
window.update_produce             = update_produce;
window.update_produce_modal_attempt2       = update_produce_modal_attempt2;
window.delete_garden_modal        = delete_garden_modal;
window.delete_produce_modal       = delete_produce_modal;
window.delete_garden              = delete_garden;
window.delete_produce             = delete_produce;
