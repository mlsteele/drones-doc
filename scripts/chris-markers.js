window.chris_markers = {
  "features": [
    {
      "geometry": {
        "coordinates": [
          -71.09238982200623,
          42.36058930786782
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw5c1lp0",
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
          -71.09232544898987,
          42.36010174992793
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw5c3m71",
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
          -71.0936987400055,
          42.360212739059826
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw5c5ev2",
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
          -71.09301745891571,
          42.36055363302489
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw5c6uv3",
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
          -71.09426200389862,
          42.35959040460942
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw5ca9c4",
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
          -71.09279751777649,
          42.359657791439844
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw5cfkq5",
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
          -71.09361827373505,
          42.35930103681029
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huw5cjer6",
        "marker-color": "#1087bf",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    }
  ],
  "id": "mlsteele.i644gn50",
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
