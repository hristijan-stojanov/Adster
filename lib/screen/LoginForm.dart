import 'package:adster/screen/RegisterForm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {

      final response = await Dio().get(
        'http://10.0.2.2:9090/apiLogin',
        data: {
          "username": username,
          "password": password,

        },
        options: Options(
          contentType: 'application/json; charset=UTF-8',
        ),
      );

      if (response.statusCode == 200) {
        print('Login successful');
        SharedPreferences prefs = await SharedPreferences.getInstance();

        List<String> argument = response.data.toString().split("/");
        await prefs.setString('username',argument[0] );
        await prefs.setString('id',argument[1] );
      } else {
        print('Login failed: ');

      }
    } catch (error) {
      print('Error sending login request: $error');

    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()), // Drug ekran
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loginUser,
              child: Text('Login'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Navigate to registration page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationForm()),
                );
              },
              child: Text('Not registered? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}


