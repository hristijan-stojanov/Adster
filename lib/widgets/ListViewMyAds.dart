import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adster/model/Ad.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/AdDetailsScreen.dart';

class ListViewMyAds extends StatefulWidget {
  @override
  _ListViewMyAdsState createState() => _ListViewMyAdsState();
}

class _ListViewMyAdsState extends State<ListViewMyAds> {
  late List<Ad> ads = [];
  late String id ="" ;
  List<Ad> AdFromJson(String str) => List<Ad>.from(json.decode(str).map((x) => Ad.fromJson(x)));


  Future<void> fetchAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    final response =
    await http.get(Uri.parse('http://10.0.2.2:9090/api/myAds/'+id));

    if (response.statusCode == 200) {
      final List<Ad> fetchedAds = AdFromJson(response.body);
      setState(() {
        ads = fetchedAds;
      });
    } else {
      throw Exception('Failed to fetch ads');
    }
  }
  Future<void> DeleteAd(String idAd)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    final response = await http.get(Uri.parse('http://10.0.2.2:9090/api/delete/'+id+'/'+idAd));

    if (response.statusCode == 200) {
      print("200 OK");

    } else {
      throw Exception('Failed to delete ad');
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
      appBar: AppBar(title: Text("My Ads")),
      body: ListView.builder(
        itemCount: ads.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
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
                    child: Image.network(
                        "http://10.0.2.2:9090/api/image/" +
                            ads[index].images[0].name),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ads[index].title, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(ads[index].price.toString()+" EUR",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,)),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                DeleteAd(ads[index].id.toString());
                                setState(() {
                                  ads.removeAt(index);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: Text("Delete"),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Implement edit functionality here
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              child: Text("Edit"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
