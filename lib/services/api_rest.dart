import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_android20221/model/data.dart';

String authority = 'api.mapbox.com';
String unencodedPath = '/geocoding/v5/mapbox.places/';
String proximity = 'ip';
String types =
    'place,postcode,address,country,region,locality,district,neighborhood,poi';
String token =
    'sk.eyJ1IjoiZG1lbnJvZCIsImEiOiJjbDNmNmpkZzYwY3V0M2dwcXR3dW1vdjd6In0.ld7ZfkyjMYL-m7uGAT8d7A';

class ApiRest extends ChangeNotifier {
  String keyWords = 'Riviera Ensenada.json';
  List<Data> data = [];
  String? msg;
  bool isLoading = true;
  ApiRest() {
    msg = 'creating connection';
    notifyListeners();
    fetchData();
  }
  fetchData() async {
    isLoading = true;
    msg = 'fetching data';
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.https(authority, unencodedPath + keyWords, {
      'proximity': proximity,
      'types': types,
      'access_token': token,
    });
    final resp = await http.get(url);
    msg = 'parsing data';
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    var list = json.decode(resp.body)["features"] as List<dynamic>;
    for (var element in list) {
      data.add(Data.fromJson(json.encode(element)));
    }
    msg = 'success';
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    isLoading = false;
    notifyListeners();
  }
}
