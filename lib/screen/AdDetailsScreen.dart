import 'dart:typed_data';

import 'package:adster/screen/MapScreen.dart';
import 'package:adster/screen/Search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import '../model/Ad.dart';

class AdDetailScreen extends StatelessWidget {
  final Ad ad;
  Future<Uint8List> _fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }


  AdDetailScreen({required this.ad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ad.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            children: ad.images.map((Imagee) {
              return FutureBuilder<Uint8List>(
                future: _fetchImage("http://10.0.2.2:9090/api/image/"+Imagee.name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error loading image');
                  } else if (snapshot.hasData) {
                    return  Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    );
                  }
                  return Text('No image');
                },
              );
            }).toList(),
          ),
          DataTable(
            columns: [
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Title',style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(ad.title)),
              ]),
              DataRow(cells: [
                DataCell(Text('Description',style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(ad.description)),
              ]),
              DataRow(cells: [
                DataCell(Text('Price',style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(ad.price.toString())),
              ]),
              DataRow(cells: [
                DataCell(Text('Type',style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(ad.type)),
              ]),
              // Dodajte poveke redovi za drugi atributi
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>MapPanel(Lon: ad.lon, Lat: ad.lat)),
              );
            },
            child: Text('Open Map'),
          ),
        ],
      ),
    );
  }}
