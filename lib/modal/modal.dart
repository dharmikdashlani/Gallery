class Gallery {
  final String urls;
  final int likes;

  Gallery({
    required this.urls,
    required this.likes,
  });

  factory Gallery.fromMap({required Map data}) {
    return Gallery(
        urls: data['largeImageURL'],
        likes: data['likes']);
  }
}


class Thame {
  bool isDark;

  Thame({required this.isDark});
}