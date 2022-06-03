import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MyMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MyMap({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  MapboxMapController? mapController;
  var isLight = true;

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      styleString: isLight ? MapboxStyles.LIGHT : MapboxStyles.DARK,
      //accessToken: MapsDemo.ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: 15.0,
        bearing: 0.0,
        tilt: 0.0,
      ),
      onStyleLoadedCallback: _onStyleLoadedCallback,
    );
  }
}
