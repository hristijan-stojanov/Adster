import 'package:adster/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:adster/model/Ad.dart';


class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String title = '';
  String priceFrom = '';
  String priceTo = '';
  String selectedAdType = 'AdType';
  String selectedLocation = 'All';
  List<Ad> ads = [];
  List<Ad> AdFromJson(String str) => List<Ad>.from(json.decode(str).map((x) => Ad.fromJson(x)));
  void _Search() async {

    try {

      final response = await Dio().get(
        'http://10.0.2.2:9090/api/search',
        data: {
          "title": title,
          "priceFrom": priceFrom,
          "priceTo": priceTo,
          "selectedAdType": selectedAdType,
          "selectedLocation": selectedLocation,
        },
        options: Options(
          contentType: 'application/json; charset=UTF-8',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataList= response.data;
        print(response.data);
        final List<Ad> fetchedAds = dataList.map((json) => Ad.fromJson(json)).toList();
        setState(() {
          ads = fetchedAds;
        });
        print('Successful');

      } else {
        print('Failed: ');

      }
    } catch (error) {
      print('Error sending login request: $error');

    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(listad: ads)), // Drug ekran
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Price from',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  priceFrom = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Price to',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  priceTo = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Type', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedAdType,
              items: <String>['AdType', 'Buying', 'Selling']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedAdType = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Text('City', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedLocation,
              items: <String>['All','Strumica', 'Skopje', 'Veles']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLocation = newValue!;
                });
              },
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _Search();
                },
                child: Text('Search'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}