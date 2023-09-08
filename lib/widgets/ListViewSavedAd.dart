import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adster/model/Ad.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/AdDetailsScreen.dart';

class ListViewSevedAd extends StatefulWidget {
  @override
  _ListViewSevedAd createState() => _ListViewSevedAd();
}

class _ListViewSevedAd extends State<ListViewSevedAd> {
  late List<Ad> ads = [];
  late String id='';
  List<Ad> AdFromJson(String str) => List<Ad>.from(json.decode(str).map((x) => Ad.fromJson(x)));

  Future<void> fetchAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    final response = await http.get(Uri.parse('http://10.0.2.2:9090/api/savedAds/'+id));

    if (response.statusCode == 200) {
      final List<Ad> fetchedAds = AdFromJson(response.body);
      setState(() {
        ads = fetchedAds;
      });
    } else {
      throw Exception('Failed to fetch ads');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Seved Ad")),
    body: ListView.builder(
      itemCount: ads.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child:InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdDetailScreen(ad: ads[index]),
                ),
              );
            },


            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Image.network("http://10.0.2.2:9090/api/image/"+ads[index].images[0].name),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ads[index].title),
                      Text(ads[index].description),


                    ],
                  ),
                ),
              ],
            ),

          ),
        );
      },

    )
 );
  }
}