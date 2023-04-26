import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/helper/api_helper.dart';

import '../../modal/modal.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();

  late Future<List<Gallery>?> getData;

  @override
  void initState() {
    super.initState();
    getData = APIHelper.apiHelper.fechPhotos();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, top: 5, bottom: 2, right: 5),
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, top: 5, bottom: 2, right: 5),
                  child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          getData = APIHelper.apiHelper
                              .fechPhotos(z: searchController.text);
                        });
                      },
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: getData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error:${snapshot.error}");
                  } else if (snapshot.hasData) {
                    List<Gallery> data = snapshot.data;
                    return Container(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisSpacing: 5),
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 3,
                            child: Container(
                              child: Image.network(data[i].urls,
                                  fit: BoxFit.fill, height: height * 0.14),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
