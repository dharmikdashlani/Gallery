import 'package:flutter/material.dart';
import 'package:gallery/view/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'Provider/theme_changer_provider.dart';

void main() {
  runApp(
    const myApp(),
  );
}

// ignore: camel_case_types
class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

// ignore: camel_case_types
class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeControler())],
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const MyHomePage(),
            },
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(backgroundColor: Colors.amberAccent),
              primaryColor: Colors.deepPurple
            ),
            darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
              primaryColor: Colors.amberAccent
            ),
            themeMode:
                (Provider.of<ThemeControler>(context, listen: true).t.isDark)
                    ? ThemeMode.dark
                    : ThemeMode.light,
          );
        },
      ),
    );
  }
}

// class Themes {
//   static final light = ThemeData.light().copyWith(
//     backgroundColor: Colors.white,
//     buttonColor: Colors.cyan,
//     bottomAppBarColor: Colors.cyan,
//     buttonTheme: const ButtonThemeData(
//       buttonColor: Colors.cyan,
//       textTheme: ButtonTextTheme.primary,
//     ),
//   );
//   static final dark = ThemeData.dark().copyWith(
//     backgroundColor: Colors.black,
//     buttonColor: Colors.deepPurple,
//     bottomAppBarColor: Colors.deepPurple,
//     buttonTheme: const ButtonThemeData(
//       buttonColor: Colors.deepPurple,
//       textTheme: ButtonTextTheme.primary,
//     ),
//   );
// }
