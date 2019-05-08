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

  var infowindow = new google.maps.InfoWindow();
  
  getJSON("./gardens", function populate_table_helper_garden(data){
   var gardens = [...Array(data.length)].map(e => Array(4));
	 for(var i = 0; i < data.length; i++){
	   gardens[i][0]=data[i].name;
	   gardens[i][1]=data[i].lat;
	   gardens[i][2]=data[i].long;
	   gardens[i][3]="<div class=\"card z-depth-0\" style=\"width: 100%;\"><div class=\"card-image\"><img src=\""+
	   "https://pbs.twimg.com/media/CD3ge1jUMAEKG1e.jpg"+ //TODO: Replace this with data[i].image
	   "\"><span class=\"card-title\">" +
	   data[i].name + "</span></div><div class=\"card-content\"><p>" + 
	   data[i].contact_name + "</p><p>" + 
	   data[i].contact_number + "</p><p>" + 
	   data[i].address + "</p></div><div class=\"card-action\"><ul class=\"collection\"><li class=\"collection-item\">Carrots</li><li class=\"collection-item\">Cabbage</li> <li class=\"collection-item\">Tomatos</li></ul></div></div>";
	   var marker = new google.maps.Marker({
      position: new google.maps.LatLng(gardens[i][1], gardens[i][2]),
      title: gardens[i][0],
      map: map
	   });
	   google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
      infowindow.setContent(gardens[i][3]);
      infowindow.open(map, marker);
      }
     })(marker, i));
	 }
  }, function(status) {
	  alert('Something went wrong.');
  });
}