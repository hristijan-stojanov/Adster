import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdForm extends StatefulWidget {
  @override
  _AdFormState createState() => _AdFormState();
}

class _AdFormState extends State<AdForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  bool isExchangePossible = false;
  bool isDeliveryPossible = false;
  double? price;

  String type = 'Buying';
  String condition = 'New';
  String selectedCategory = 'Kategorija 1';
  String selectedCity = 'Grad 1';

  List<File> images = [];


  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Izvršete akcii za zapishuvanje na informaciite vo vašata backend logika
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create ad'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  validator: (value) {
                    if (value==null) {
                      return 'Polinjeto e zadolžitelno';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  validator: (value) {
                    if (value==null) {
                      return 'Polinjeto e zadolžitelno';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isExchangePossible,
                      onChanged: (value) {
                        setState(() {
                          isExchangePossible = value ?? false;
                        });
                      },
                    ),
                    Text('Is Exchange Possible'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isDeliveryPossible,
                      onChanged: (value) {
                        setState(() {
                          isDeliveryPossible = value ?? false;
                        });
                      },
                    ),
                    Text('Is Delivery Possible'),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price (euro)'),
                  onChanged: (value) {
                    setState(() {
                      price = double.tryParse(value);
                    });
                  },
                  validator: (value) {
                    if (value==null) {
                      return 'Polinjeto e zadolžitelno';
                    }
                    if (price == null) {
                      return 'Vnesete validna cena';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: type,
                  onChanged: (value) {
                    setState(() {
                      type = value!;
                    });
                  },
                  items: ['Buying', 'Selling']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                      .toList(),
                  decoration: InputDecoration(labelText: 'Ad Type'),
                ),
                DropdownButtonFormField<String>(
                  value: condition,
                  onChanged: (value) {
                    setState(() {
                      condition = value!;
                    });
                  },
                  items: ['New', 'Old'] // Dodajte gi svoite opcii spored potrebite
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                      .toList(),
                  decoration: InputDecoration(labelText: 'condition'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                  child: Text('Dodadi Slika'),
                ),
                Column(
                  children: images.map((image) {
                    return Image.file(image);
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Zachuvaj Oglas'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}