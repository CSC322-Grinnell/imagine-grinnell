// Executes $callback passing a pointer to the google object after the google object is loaded
// The argument, then, should be a function that takes the google object as an argument.
// Example call:
//   withGoogle((google) => google.maps.show());
// Waiting for the entire window to load is probably kinda slow, this should probably be replaced with a callback for when the specific google maps script is loaded.
// The cleanest way to handle this would be to grab the script ahead of time and include it in the webpack bundle, but that also proved problematic.
export function withGoogle(callback) {
  window.addEventListener('load', () => {
    callback(window.google);
  });
}
