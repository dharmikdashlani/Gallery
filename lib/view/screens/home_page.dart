import 'package:flutter/material.dart';
import 'package:gallery/view/screens/search.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:provider/provider.dart';
import '../../Provider/theme_changer_provider.dart';
import 'Setting.dart';
import 'home.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Photo Gallery",
          style: TextStyle(
              // color: Colors.black,
              ),
        ),
        // backgroundColor: Colors.amberAccent,
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true,
        // default: true, apply safe area wrapper
        labels: const ["Home", "Search", "Settings"],
        icons: const [Icons.home, Icons.search, Icons.settings],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: TextStyle(
          fontSize: 12,
          color: (Provider.of<ThemeControler>(context, listen: true).t.isDark)
              ? Colors.deepPurple
              : Colors.amberAccent,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor:
            (Provider.of<ThemeControler>(context, listen: true).t.isDark)
                ? Colors.deepPurpleAccent
                : Colors.amberAccent,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor:
            (Provider.of<ThemeControler>(context, listen: true).t.isDark)
                ? Colors.deepPurpleAccent
                : Colors.amberAccent,
        tabIconSelectedColor: Colors.white,
        // tabBarColor: (Provider.of<ThemeControler>(context,
        //     listen: true)
        //     .t
        //     .isDark)
        //     ? Colors.deepPurple
        //     : Colors.lime,
        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        // swipe navigation handling is not supported
        controller: _tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const Center(
            child: Home(),
          ),
          const Center(
            child: Search(),
          ),
          const Center(
            child: ThemeChange(),
          ),
        ],
      ),
      // backgroundColor: Colors.white24,
    );
  }
}
