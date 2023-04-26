import 'package:flutter/material.dart';
import 'package:gallery/helper/api_helper.dart';
import 'package:gallery/modal/modal.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_changer_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Gallery>?> getData;

  @override
  void initState() {
    super.initState();
    getData = APIHelper.apiHelper.fechPhotos();
  }

  //
  // List<dynamic> photos = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: getData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Error:${snapshot.error}");
          } else if (snapshot.hasData) {
            List<Gallery> data = snapshot.data;
            return Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1, mainAxisSpacing: 5),
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
          return Center(
            child: CircularProgressIndicator(
              backgroundColor:
                  (Provider.of<ThemeControler>(context, listen: true).t.isDark)
                      ? Colors.deepPurpleAccent
                      : Colors.amberAccent,
            ),
          );
        },
      ),
    );
  }
}
