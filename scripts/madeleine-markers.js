(function(){

var madeleine_markers = {
  "features": [
    {
      "geometry": {
        "coordinates": [
          -71.08756721019745,
          42.36092227209174
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huvblr4p0",
        "marker-color": "#9c89cc",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.08705759048462,
          42.36053381365895
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huvblz021",
        "marker-color": "#9c89cc",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.08756184577942,
          42.35958102789931
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huvbm3162",
        "marker-color": "#9c89cc",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.08704149723053,
          42.361100645057334
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huvbm67s3",
        "marker-color": "#9c89cc",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.08855426311493,
          42.361548557160845
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huvbm8q04",
        "marker-color": "#9c89cc",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.08825385570525,
          42.36001058013719
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huvbmb5t5",
        "marker-color": "#9c89cc",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    // {
    //   "geometry": {
    //     "coordinates": [
    //       -71.0876852273941,
    //       42.36163972472002
    //     ],
    //     "type": "Point"
    //   },
    //   "properties": {
    //     "description": "",
    //     "id": "marker-huvbmlv57",
    //     "marker-color": "#9c89cc",
    //     "marker-size": "medium",
    //     "marker-symbol": "",
    //     "title": ""
    //   },
    //   "type": "Feature"
    // }
  ],
  "id": "seveneightn9ne.i5pp9ic8",
  "type": "FeatureCollection"
}

var video_ids = [
  'madeleine-next-big-step',
  'madeleine-military',
  'madeleine-ban',
  'madeleine-everyday-life',
  'madeleine-media-portrayal',
  'madeleine-the-word-drone'
]

for (i=0; i<video_ids.length; i++) {
  madeleine_markers["features"][i]["properties"]["video-id"] = video_ids[i]
  madeleine_markers["features"][i]["properties"]["video-person-name"] = 'madeleine'
}

window.people_markers = window.people_markers || {};
window.people_markers['madeleine'] = madeleine_markers

}).call(this);
