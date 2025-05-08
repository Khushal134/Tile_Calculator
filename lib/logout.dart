import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tile_calculator/signup.dart';

class logout extends StatelessWidget {
  const logout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: logouts(),
      ),
    );
  }
}

class logouts extends StatefulWidget {
  const logouts({super.key});

  @override
  State<logouts> createState() => _logoutsState();
}

class _logoutsState extends State<logouts> {
  void _signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Out'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _signout();
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
