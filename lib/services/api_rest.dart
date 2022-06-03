import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_android20221/imports/.models.dart';

String authority = 'api.mapbox.com';
String unencodedPath = '/geocoding/v5/mapbox.places/';
String proximity = 'ip';
String types =
    'place,postcode,address,country,region,locality,district,neighborhood,poi';
String token =
    'sk.eyJ1IjoiZG1lbnJvZCIsImEiOiJjbDNmaHM3NWMwMDEwM2NsdmplOGx0OGRuIn0.l7lfj7CpOAcw608DC3xhgg';

class ApiRest extends ChangeNotifier {
  String keyWords = '';
  List<Data> data = [];
  String? msg;
  bool isLoading = true;
  ApiRest() {
    msg = 'creating connection';
    notifyListeners();
    fetchData();
  }
  setKeyWords(String keywords) {
    keyWords = keywords;
    data = [];
    notifyListeners();
  }

  fetchData() async {
    isLoading = true;
    msg = 'fetching data';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    final url = Uri.https(authority, '$unencodedPath$keyWords.json', {
      'proximity': proximity,
      'types': types,
      'access_token': token,
    });
    final resp = await http.get(url);
    print(resp.body);
    msg = 'parsing data';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    var list = json.decode(resp.body)["features"] as List<dynamic>;
    for (var element in list) {
      data.add(Data.fromJson(json.encode(element)));
    }
    msg = 'success';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
    notifyListeners();
  }
}
