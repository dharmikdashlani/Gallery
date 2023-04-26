import 'dart:convert';
import 'package:gallery/modal/modal.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Gallery>?> fechPhotos({String z = "Nature"}) async {
    int number = 100;
    String all = z;
    String apikey = "35786474-95b9afbf5a00837830250208e";
    String api =
        "https://pixabay.com/api/?key=$apikey&q=$z&per_page=$number&image_type=photo&pretty=true";
    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodeData = jsonDecode(res.body);

      // List<Gallery> gallery = Gallery.fromMap(data: decodeData);
      List info = decodeData['hits'];
      List<Gallery> gallery =
          info.map((e) => Gallery.fromMap(data: e)).toList();
      return gallery;
    }
    // return null;
  }
}
