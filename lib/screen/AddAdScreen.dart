import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
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
  String selectedCategory = 'Arduino';
  String selectedCity = 'Skopje';


  List<File> images = [];


  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {

      Map<String, dynamic> data = {
        'title': title,
        'description': description,
        'isExchangePossible': isExchangePossible,
        'isDeliveryPossible': isDeliveryPossible,
        'price': price,
        'type': type,
        'condition': condition,

      };


      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:9090/api/add'),
      );


      for (var image in images) {
        request.files.add(
          await http.MultipartFile.fromPath('images', image.path),
        );
      }


      for (var entry in data.entries) {
        request.fields[entry.key] = entry.value.toString();
      }


      var response = await request.send();


      if (response.statusCode == 200) {

        print('200 OK.');
      } else {

        print('erorr: ${response.statusCode}');
      }
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
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                    });
                  },
                  items: ['Skopje', 'Strumica'] // Dodajte gi svoite opcii spored potrebite
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                      .toList(),
                  decoration: InputDecoration(labelText: 'City'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  items: ['Arduino', 'kategorija1','kategorija2'] // Dodajte gi svoite opcii spored potrebite
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                      .toList(),
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                  child: Text('Add Image'),
                ),
                Column(
                  children: images.map((image) {
                    return Image.file(image);
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}