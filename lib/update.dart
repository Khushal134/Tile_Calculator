import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileUpdatePage extends StatefulWidget {
  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Controllers for the TextFields
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
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _updateProfile() async {
    try {
      if (currentUser != null) {
        String email = currentUser!.email!;

        // Update the Firestore document
        await _db.collection('user data').doc(email).update({
          'name': _nameController.text,
          'mobile': _mobileController.text,
          'age': _ageController.text,
        });

        Fluttertoast.showToast(
          msg: 'Profile Updated Successfully',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      Fluttertoast.showToast(
        msg: 'Failed to update profile',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> deleteName() async {
    try {
      if (currentUser != null) {
        String email = currentUser!.email!;
        Map<String, dynamic> data1 = {'name': FieldValue.delete()};
        await _db
            .collection('user data')
            .doc(email)
            .update(data1)
            .then((value) => print('field deleted'));
        _nameController.clear();
        Fluttertoast.showToast(
          msg: 'Name Deleted successfully',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: '$e',
      );
    }
  }

  Future<void> deleteMobile() async {
    try {
      if (currentUser != null) {
        String email = currentUser!.email!;
        Map<String, dynamic> data3 = {'mobile': FieldValue.delete()};
        await _db
            .collection('user data')
            .doc(email)
            .update(data3)
            .then((value) => print('field deleted'));
        _mobileController.clear();
        Fluttertoast.showToast(
            msg: 'Mobile no. Deleted successfully',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> deleteAge() async {
    try {
      if (currentUser != null) {
        String email = currentUser!.email!;
        Map<String, dynamic> data4 = {'age': FieldValue.delete()};
        await _db
            .collection('user data')
            .doc(email)
            .update(data4)
            .then((value) => print('field deleted'));
        _ageController.clear();

        Fluttertoast.showToast(
            msg: 'Age Deleted successfully', backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: userData != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteName();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _emailController,
                          readOnly:
                              true, // You might not want to allow email editing
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                            labelText: 'Mobile',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteMobile();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteAge();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _updateProfile,
                          child: Text(
                            'Update Profile',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),

                          // style: ButtonStyle(
                          //   backgroundColor:
                          //       WidgetStateProperty.all(Colors.pink[50]),
                          // ),
                        ),
                        // SizedBox(height: 20),
                        // ElevatedButton(
                        //   onPressed: detele,
                        //   child: Text(
                        //     'Delete Account',
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
