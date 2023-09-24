import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
<<<<<<< HEAD
import 'package:http/http.dart' as http;
class AdForm extends StatefulWidget {

=======

class AdForm extends StatefulWidget {
>>>>>>> f5854988b1118ecf83b8fa9fa98379e1b1e8482a
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
<<<<<<< HEAD
  String selectedCategory = 'Arduino';
  String selectedCity = 'Skopje';

=======
  String selectedCategory = 'Kategorija 1';
  String selectedCity = 'Grad 1';
>>>>>>> f5854988b1118ecf83b8fa9fa98379e1b1e8482a

  List<File> images = [];


  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

<<<<<<< HEAD
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


=======
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Izvršete akcii za zapishuvanje na informaciite vo vašata backend logika
    }
  }

>>>>>>> f5854988b1118ecf83b8fa9fa98379e1b1e8482a
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
<<<<<<< HEAD
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
=======
>>>>>>> f5854988b1118ecf83b8fa9fa98379e1b1e8482a
                ElevatedButton(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
<<<<<<< HEAD
                  child: Text('Add Image'),
=======
                  child: Text('Dodadi Slika'),
>>>>>>> f5854988b1118ecf83b8fa9fa98379e1b1e8482a
                ),
                Column(
                  children: images.map((image) {
                    return Image.file(image);
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
<<<<<<< HEAD
                  child: Text('Save'),
=======
                  child: Text('Zachuvaj Oglas'),
>>>>>>> f5854988b1118ecf83b8fa9fa98379e1b1e8482a
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}