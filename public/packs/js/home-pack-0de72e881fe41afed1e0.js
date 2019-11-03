/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/home-pack.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/google.js":
/*!**********************************!*\
  !*** ./app/javascript/google.js ***!
  \**********************************/
/*! exports provided: withGoogle */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "withGoogle", function() { return withGoogle; });
// Executes $callback passing a pointer to the google object after the google object is loaded
// The argument, then, should be a function that takes the google object as an argument.
// Example call:
//   withGoogle((google) => google.maps.show());
// Waiting for the entire window to load is probably kinda slow, this should probably be replaced with a callback for when the specific google maps script is loaded.
// The cleanest way to handle this would be to grab the script ahead of time and include it in the webpack bundle, but that also proved problematic.
function withGoogle(callback) {
  window.addEventListener('load', function () {
    callback(window.google);
  });
}

/***/ }),

/***/ "./app/javascript/home.js":
/*!********************************!*\
  !*** ./app/javascript/home.js ***!
  \********************************/
/*! exports provided: initMap, populate_produces */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "initMap", function() { return initMap; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "populate_produces", function() { return populate_produces; });
/* harmony import */ var misc__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! misc */ "./app/javascript/misc.js");
function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _nonIterableSpread(); }

function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance"); }

function _iterableToArray(iter) { if (Symbol.iterator in Object(iter) || Object.prototype.toString.call(iter) === "[object Arguments]") return Array.from(iter); }

function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = new Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } }


function initMap(google) {
  // Styles a map in night mode.
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {
      lat: 41.743611,
      lng: -92.724722
    },
    zoom: 14,
    disableDefaultUI: true,
    styles: [{
      'featureType': 'administrative',
      'stylers': [{
        'saturation': '-100'
      }]
    }, {
      'featureType': 'administrative.province',
      'stylers': [{
        'visibility': 'off'
      }]
    }, {
      'featureType': 'landscape',
      'stylers': [{
        'saturation': -100
      }, {
        'lightness': 65
      }, {
        'visibility': 'on'
      }]
    }, {
      'featureType': 'poi',
      'stylers': [{
        'saturation': -100
      }, {
        'lightness': '50'
      }, {
        'visibility': 'simplified'
      }]
    }, {
      'featureType': 'poi',
      'elementType': 'labels.icon',
      'stylers': [{
        'visibility': 'off'
      }]
    }, {
      'featureType': 'poi.business',
      'stylers': [{
        'visibility': 'simplified'
      }]
    }, {
      'featureType': 'poi.business',
      'elementType': 'labels.icon',
      'stylers': [{
        'visibility': 'off'
      }]
    }, {
      'featureType': 'road',
      'stylers': [{
        'saturation': '-100'
      }]
    }, {
      'featureType': 'road.arterial',
      'stylers': [{
        'lightness': '30'
      }]
    }, {
      'featureType': 'road.highway',
      'stylers': [{
        'visibility': 'simplified'
      }]
    }, {
      'featureType': 'road.local',
      'stylers': [{
        'lightness': '40'
      }]
    }, {
      'featureType': 'transit',
      'stylers': [{
        'saturation': -100
      }]
    }, {
      'featureType': 'water',
      'elementType': 'geometry',
      'stylers': [{
        'hue': '#ffff00'
      }, {
        'saturation': -97
      }, {
        'lightness': -25
      }]
    }, {
      'featureType': 'water',
      'elementType': 'labels',
      'stylers': [{
        'saturation': -100
      }, {
        'lightness': -25
      }]
    }]
  });
  var infowindow = new google.maps.InfoWindow();
  Object(misc__WEBPACK_IMPORTED_MODULE_0__["getJSON"])('./gardens', function (data) {
    var gardens = _toConsumableArray(Array(data.length)).map(function (_) {
      return Array(4);
    });

    for (var i = 0; i < data.length; i++) {
      gardens[i][0] = data[i].name;
      gardens[i][1] = data[i].lat;
      gardens[i][2] = data[i]["long"];
      gardens[i][3] = "\n        <div class=\"card z-depth-0\" style=\"width: 100%;\">\n          <div class=\"card-image\">\n            <img src=\"".concat(data[i].image, "\">\n            <span class=\"card-title\">\n              ").concat(data[i].name, "\n            </span>\n          </div>\n          <div class=\"card-content\">\n            <p>").concat(data[i].contact_name, "</p>\n            <p> ").concat(data[i].contact_number, "</p>\n            <p>").concat(data[i].address, "</p>\n            <ul id=garden_id ").concat(data[i].id, " class=\"collection\"></ul>\n          </div>\n        </div>");
      var marker = new google.maps.Marker({
        position: new google.maps.LatLng(gardens[i][1], gardens[i][2]),
        title: gardens[i][0],
        map: map
      });
      google.maps.event.addListener(marker, 'click', function (marker, i) {
        return function () {
          infowindow.setContent(gardens[i][3]);
          infowindow.open(map, marker);
          populate_produces();
        };
      }(marker, i));
    }
  }, function (_) {
    alert('Something went wrong.');
  });
}
function populate_produces() {
  Object(misc__WEBPACK_IMPORTED_MODULE_0__["getJSON"])('./garden_produces', function (data) {
    for (var i = 0; i <= data.length - 1; i++) {
      try {
        document.getElementById("garden_id".concat(data[i].garden_id)).innerHTML += "\n          <li class=\"collection-item light-green lighten-".concat(3 - data[i].readiness, "\">\n            <span class=\"produce_id").concat(data[i].produce_id, "\"></span>,\n            ").concat(data[i].available_at, "\n          </li>");
      } catch (exception) {// pass
      }
    }

    Object(misc__WEBPACK_IMPORTED_MODULE_0__["getJSON"])('./produces', function (data) {
      for (var _i = 0; _i <= data.length - 1; _i++) {
        var elements = document.getElementsByClassName("produce_id".concat(_i));

        for (var j = 0; j < elements.length; j++) {
          elements[j].innerHTML += data[_i].name;
        }
      }
    }, function (_) {
      alert('Something went wrong.');
    });
  }, function (_) {
    alert('Something went wrong.');
  });
}

/***/ }),

/***/ "./app/javascript/misc.js":
/*!********************************!*\
  !*** ./app/javascript/misc.js ***!
  \********************************/
/*! exports provided: getJSON */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "getJSON", function() { return getJSON; });
function getJSON(url, successHandler, errorHandler) {
  var xhr = typeof XMLHttpRequest !== 'undefined' ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP'); // eslint-disable-line no-undef

  xhr.open('get', url, true);

  xhr.onreadystatechange = function () {
    var status;
    var data; // https://xhr.spec.whatwg.org/#dom-xmlhttprequest-readystate

    if (xhr.readyState === 4) {
      // `DONE`
      status = xhr.status;

      if (status === 200) {
        data = JSON.parse(xhr.responseText);
        successHandler && successHandler(data);
      } else {
        errorHandler && errorHandler(status);
      }
    }
  };

  xhr.send();
}

/***/ }),

/***/ "./app/javascript/packs/home-pack.js":
/*!*******************************************!*\
  !*** ./app/javascript/packs/home-pack.js ***!
  \*******************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _home__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../home */ "./app/javascript/home.js");
/* harmony import */ var _google__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../google */ "./app/javascript/google.js");
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


Object(_google__WEBPACK_IMPORTED_MODULE_1__["withGoogle"])(function (google) {
  Object(_home__WEBPACK_IMPORTED_MODULE_0__["initMap"])(google);
  Object(_home__WEBPACK_IMPORTED_MODULE_0__["populate_produces"])();
});

/***/ })

/******/ });
//# sourceMappingURL=home-pack-0de72e881fe41afed1e0.js.map