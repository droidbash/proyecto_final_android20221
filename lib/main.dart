import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final_android20221/services/api_rest.dart';

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
      title: 'API-REST',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiRest apiRest = Provider.of<ApiRest>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox Search:'),
      ),
      body: apiRest.isLoading
          ? Center(
              child: Text(apiRest.msg ?? "Loading..."),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'My City',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          initialValue: apiRest.keyWords
                              .substring(0, apiRest.keyWords.indexOf('.')),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search_outlined))
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: apiRest.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.place_outlined,
                        ),
                        title: Text(apiRest.data[index].placeName ?? ""),
                        subtitle: Text(apiRest.data[index].id ?? ""),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
