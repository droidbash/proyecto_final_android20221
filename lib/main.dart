import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final_android20221/imports/.pages.dart';
import 'package:proyecto_final_android20221/imports/.services.dart';

void main() {
  runApp(const Services());
}

class Services extends StatelessWidget {
  const Services({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiRest(),
        ),
      ],
      child: myApp(),
    );
  }
}

Widget myApp() => MaterialApp(
      title: 'Mapbox search',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox Search:'),
      ),
      body: const Search(),
    );
  }
}
