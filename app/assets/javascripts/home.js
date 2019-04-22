function initMap() {
  // Styles a map in night mode.
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 41.743611, lng: -92.724722},
    zoom: 14,
    disableDefaultUI: true,
    styles: [
  {
    "featureType": "administrative",
    "stylers": [
      {
        "saturation": "-100"
      }
    ]
  },
  {
    "featureType": "administrative.province",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "landscape",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": 65
      },
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": "50"
      },
      {
        "visibility": "simplified"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "simplified"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "stylers": [
      {
        "saturation": "-100"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "stylers": [
      {
        "lightness": "30"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "stylers": [
      {
        "visibility": "simplified"
      }
    ]
  },
  {
    "featureType": "road.local",
    "stylers": [
      {
        "lightness": "40"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "saturation": -100
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "hue": "#ffff00"
      },
      {
        "saturation": -97
      },
      {
        "lightness": -25
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": -25
      }
    ]
  }
]
  });
  
  var imagine_grinnell = {lat: 41.752169, lng: -92.707852};

  var contentString = '<div class="card z-depth-0" style="width: 100%;"><div class="card-image"><img src="https://pbs.twimg.com/media/CD3ge1jUMAEKG1e.jpg"><span class="card-title">Imagine Grinnell</span></div><div class="card-content"><p>Imagine Grinnell turns imagination into action to create a more vibrant, sustainable, and healthy Grinnell. Our roots deepen relationships and enrich the community we serve.</p></div><div class="card-action"><ul class="collection"><li class="collection-item">Carrots</li><li class="collection-item">Cabbage</li> <li class="collection-item">Tomatos</li></ul></div></div>';
  
  var infowindow = new google.maps.InfoWindow({
    content: contentString
  });

  var marker = new google.maps.Marker({
    position: imagine_grinnell,
    map: map,
    title: 'Imagine Grinnell'
  });
  
  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
}