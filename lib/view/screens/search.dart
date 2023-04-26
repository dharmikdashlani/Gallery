import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/helper/api_helper.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_changer_provider.dart';
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
                        left: 15, top: 5, bottom: 2, right: 5),
                    child: TextFormField(
                      cursorColor:
                          (Provider.of<ThemeControler>(context, listen: true)
                                  .t
                                  .isDark)
                              ? Colors.deepPurpleAccent
                              : Colors.amber,
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: (Provider.of<ThemeControler>(context,
                                            listen: true)
                                        .t
                                        .isDark)
                                    ? Colors.deepPurpleAccent
                                    : Colors.amber,
                                width: 3)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: (Provider.of<ThemeControler>(context,
                                          listen: true)
                                      .t
                                      .isDark)
                                  ? Colors.deepPurpleAccent
                                  : Colors.amberAccent,
                              width: 12.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 1, top: 5, bottom: 2, right: 10),
                  child: Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          getData = APIHelper.apiHelper
                              .fechPhotos(z: searchController.text);
                        });
                      },
                      child: Icon(
                        Icons.search,
                        size: 40,
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
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisSpacing: 5),
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 3,
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: Image.network(data[i].urls,
                                fit: BoxFit.fill, height: height * 0.14),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor:
                          (Provider.of<ThemeControler>(context, listen: true)
                                  .t
                                  .isDark)
                              ? Colors.deepPurpleAccent
                              : Colors.amberAccent,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
