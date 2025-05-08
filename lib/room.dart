import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tile_calculator/calculate.dart';
import 'package:tile_calculator/logout.dart';
import 'package:tile_calculator/update.dart';

class room extends StatelessWidget {
  const room({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: abc(),
      ),
    );
  }
}

class abc extends StatefulWidget {
  const abc({super.key});

  @override
  State<abc> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<abc> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? getAuth = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
              //close drawer, if drawer is open
            } else {
              scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue[200],
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        weight: 300,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('User Email Id: $getAuth'),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => room(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              title: Text('profile'),
              leading: Icon(Icons.calculate),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileUpdatePage()));
              },
            ),
            ListTile(
              title: Text('Claculate Tiles number'),
              leading: Icon(Icons.calculate),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => calculate()));
              },
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.logout),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => logout(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome to home page ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
