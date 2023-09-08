import 'package:adster/main.dart';
import 'package:adster/widgets/ListViewMyAds.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/LoginForm.dart';
import '../screen/RegisterForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  bool showButtons = true;
  late String username ="ADSTER" ;
  Future <void> getusername()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'ADSTER';
      if(username!="ADSTER" || username=="")
        {
          showButtons = false;
        }

    });
  }
  Future <void> logOutUsername()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username',"ADSTER" );
    await prefs.setString('id',"" );
  }
  @override
  void initState() {
    super.initState();
    getusername();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                username,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          if (showButtons)
            ListTile(

              title: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Add a black border
                      borderRadius: BorderRadius.all(Radius.circular(5)), // Add rounded corners
                    ),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationForm()),
                        )
                      },
                      child: Text('Register'),
                    ),
                  ),
                  SizedBox(width: 10), // Add some spacing between buttons
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Add a black border
                      borderRadius: BorderRadius.all(Radius.circular(5)), // Add rounded corners
                    ),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginForm()),
                        ),
                      },
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
              onTap: () => {},
            ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {},
          ),
            ListTile(
              leading: Icon(Icons.my_library_books),
              title: Text('My ads'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListViewMyAds()),
                ),
              },
            ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add new add'),
            onTap: () => {},
          ),
          if (!showButtons)
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              logOutUsername(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage()),
              ),
            },
          ),
        ],
      ),
    );
  }
}
