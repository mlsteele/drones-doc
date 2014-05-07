window.chris_markers = {
  "features": [
    {
      "geometry": {
        "coordinates": [
          -71.09310328960419,
          42.35947148649709
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw3hgef0",
        "marker-color": "#1087bf",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.093612909317,
          42.359744997819
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw3hoxs1",
        "marker-color": "#1087bf",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.09329640865326,
          42.35987977107598
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw3hsdb2",
        "marker-color": "#1087bf",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.09321594238281,
          42.360192919586375
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw3hvqj3",
        "marker-color": "#1087bf",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.09384894371033,
          42.36031976410849
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw3hxpd4",
        "marker-color": "#1087bf",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.09273850917816,
          42.35980842056418
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw3hzvs5",
        "marker-color": "#1087bf",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.09374701976776,
          42.35943977496246
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw3i75z6",
        "marker-color": "#1087bf",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    }
  ],
  "id": "mlsteele.i63nk5he",
  "type": "FeatureCollection"
}

video_ids = [
  "94302522",
  "94302520",
  "94300863", // chris ends here
  "94127335",
  "94127399",
  "94127285",
]
for (i=0; i<video_ids.length; i++) {
  window.chris_markers["features"][i]["properties"]["video-id"] = video_ids[i]
}
