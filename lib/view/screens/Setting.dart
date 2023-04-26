import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_changer_provider.dart';

class ThemeChange extends StatefulWidget {
  const ThemeChange({Key? key}) : super(key: key);

  @override
  State<ThemeChange> createState() => _ThemeChangeState();
}

class _ThemeChangeState extends State<ThemeChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (Provider.of<ThemeControler>(context,
                                      listen: true)
                                  .t
                                  .isDark)
                              ? Colors.white
                              : Colors.black,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Change Theme Mode"),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Switch(
                    inactiveTrackColor: (Provider.of<ThemeControler>(context,
                        listen: true)
                        .t
                        .isDark)
                        ? Colors.deepPurpleAccent
                        : Colors.amberAccent,
                    activeColor: (Provider.of<ThemeControler>(context,
                        listen: true)
                        .t
                        .isDark)
                        ? Colors.deepPurpleAccent
                        : Colors.amberAccent,
                    value: Provider.of<ThemeControler>(context).t.isDark,
                    onChanged: (Val) {
                      Provider.of<ThemeControler>(context, listen: false)
                          .setDark();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
