import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: check(),
    );
  }
}

class check extends StatefulWidget {
  const check({super.key});

  @override
  State<check> createState() => _checkState();
}

class _checkState extends State<check> {
  User current = FirebaseAuth.instance.currentUser!;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController age = TextEditingController();

  void fetchUserDetail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user data')
          .where('Email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        Map<String, dynamic> userdata = userDoc.data() as Map<String, dynamic>;
        setState(() {
          name.text = userdata["name"] ?? '';
          email.text = userdata["Email"] ?? '';
          mobile.text = userdata["mobile"] ?? '';
          age.text = userdata["age"] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'profile',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
            ),
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: mobile,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mobile',
            ),
          ),
          TextField(
            controller: age,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Age',
            ),
          ),
        ],
      ),
    );
  }
}
