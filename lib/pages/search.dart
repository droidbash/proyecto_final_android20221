import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final_android20221/imports/.services.dart';
import 'package:proyecto_final_android20221/widgets/my_map.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiRest apiRest = Provider.of<ApiRest>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: ((value) => apiRest.setKeyWords(value)),
                  decoration: const InputDecoration(
                    hintText: 'My City',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  initialValue:
                      apiRest.keyWords.isNotEmpty ? apiRest.keyWords : '',
                ),
              ),
              IconButton(
                onPressed: () {
                  apiRest.fetchData();
                },
                icon: const Icon(Icons.search_outlined),
              )
            ],
          ),
        ),
        apiRest.isLoading
            ? Expanded(
                child: Center(
                  child: Text(apiRest.msg ?? "Loading..."),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: apiRest.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.place_outlined,
                      ),
                      title: Text(apiRest.data[index].placeName ?? ""),
                      subtitle: Text(apiRest.data[index].id ?? ""),
                      onTap: () {
                        double lon = apiRest.data[index].center?[0] ?? 0;
                        double lat = apiRest.data[index].center?[1] ?? 0;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyMap(latitude: lat, longitude: lon),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
      ],
    );
  }
}
