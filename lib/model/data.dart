// To parse this JSON data, do
//
//     final data = dataFromMap(jsonString);

import 'dart:convert';

class Data {
  Data({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.text,
    this.placeName,
    this.bbox,
    this.center,
    this.geometry,
    this.context,
  });

  String? id;
  String? type;
  List<String>? placeType;
  dynamic relevance;
  Properties? properties;
  String? text;
  String? placeName;
  List<double>? bbox;
  List<double>? center;
  Geometry? geometry;
  List<Context>? context;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromMap(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        bbox: json["bbox"] == null
            ? null
            : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        center: json["center"] == null
            ? null
            : List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType!.map((x) => x)),
        "relevance": relevance,
        "properties": properties!.toMap(),
        "text": text,
        "place_name": placeName,
        "bbox": List<dynamic>.from(bbox!.map((x) => x)),
        "center": List<dynamic>.from(center!.map((x) => x)),
        "geometry": geometry!.toMap(),
        "context": List<dynamic>.from(context!.map((x) => x.toMap())),
      };
}

class Context {
  Context({
    this.id,
    this.shortCode,
    this.wikidata,
    this.text,
  });

  String? id;
  String? shortCode;
  String? wikidata;
  String? text;

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        shortCode: json["short_code"],
        wikidata: json["wikidata"],
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "short_code": shortCode,
        "wikidata": wikidata,
        "text": text,
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String? type;
  List<double>? coordinates;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.wikidata,
  });

  String? wikidata;

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
      );

  Map<String, dynamic> toMap() => {
        "wikidata": wikidata,
      };
}
