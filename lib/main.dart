import 'package:adster/screen/Search.dart';
import 'package:adster/widgets/ListViewAd.dart';
import 'package:adster/widgets/ListViewSavedAd.dart';
import 'package:adster/widgets/SideDrawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool _showSidebar = false;
    return Scaffold(
      drawer: SideDrawer(),
      appBar:  AppBar(title: Text("ADSTER"),
          actions:[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen()),
            );
          } ,
        ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListViewSevedAd()),
                );
              } ,
            ),

      ]),
      body: ListViewAd(),

    );
  }
}








