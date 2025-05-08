import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  // controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      if (currentUser != null) {
        String email = currentUser!.email!;
        DocumentSnapshot userDoc =
            await _db.collection('user data').doc(email).get();
        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data() as Map<String, dynamic>?;

            _nameController.text = userData!['name'] ?? '';
            _emailController.text = userData!['Email'] ?? '';
            _mobileController.text = userData!['mobile'] ?? '';
            _ageController.text = userData!['age'] ?? '';
          });
        } else {
          print('No user data found');
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: userData != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${userData!['name']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${userData!['Email']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mobile: ${userData!['mobile']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Age: ${userData!['age']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
