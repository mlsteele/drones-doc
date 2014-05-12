(function(){

var andy_markers = {
  "features": [
    {
      "geometry": {
        "coordinates": [
          -71.09088242053986,
          42.361374149287755
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huv9oc150",
        "marker-color": "#f1f075",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.09073758125305,
          42.361897371454674
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huv9ov9u2",
        "marker-color": "#f1f075",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.08976662158966,
          42.36133847489044
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huv9p1o34",
        "marker-color": "#f1f075",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.09091460704803,
          42.36078353721286
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huv9p3fk5",
        "marker-color": "#f1f075",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.08935356140137,
          42.361774493913025
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huv9p58d6",
        "marker-color": "#f1f075",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    {
      "geometry": {
        "coordinates": [
          -71.08823776245117,
          42.36058930786782
        ],
        "type": "Point"
      },
      "properties": {
        "description": "",
        "id": "marker-huv9p7mi7",
        "marker-color": "#f1f075",
        "marker-size": "medium",
        "marker-symbol": "",
        "title": ""
      },
      "type": "Feature"
    },
    // {
    //   "geometry": {
    //     "coordinates": [
    //       -71.08921408653259,
    //       42.36102533208919
    //     ],
    //     "type": "Point"
    //   },
    //   "properties": {
    //     "description": "",
    //     "id": "marker-huv9peuk8",
    //     "marker-color": "#f1f075",
    //     "marker-size": "medium",
    //     "marker-symbol": "",
    //     "title": ""
    //   },
    //   "type": "Feature"
    // }
  ],
  "id": "seveneightn9ne.i5pi77en",
  "type": "FeatureCollection"
}

var video_ids = [
  'andy-people-word-drone',
  'andy-research',
  'andy-the-word-drone',
  'andy-amazon-air',
  'andy-ban',
  'andy-future-uses'
]

for (i=0; i<video_ids.length; i++) {
  andy_markers["features"][i]["properties"]["video-id"] = video_ids[i]
  andy_markers["features"][i]["properties"]["video-person-name"] = 'andy'
}

window.people_markers = window.people_markers || {};
window.people_markers['andy'] = andy_markers

}).call(this);
