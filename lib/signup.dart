import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tile_calculator/home_page.dart';
import 'package:tile_calculator/signIn.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: createac(),
      ),
    );
  }
}

class createac extends StatefulWidget {
  const createac({super.key});

  @override
  State<createac> createState() => _sreateacState();
}

class _sreateacState extends State<createac> {
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _repass = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _age = TextEditingController();

  FirebaseFirestore _db = FirebaseFirestore.instance;

  void _saved() async {
    try {
      String email = _email.text.trim();
      print("data");
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.toString(),
        password: _pass.text.toString(),
      );
      //Get.to(Homepage());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
      _db.collection('user data').doc(email).set(
        {
          'name': _name.text.toString(),
          'Email': _email.text.toString(),
          'mobile': _mobile.text.toString(),
          'age': _age.text.toString(),
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: 'The password provided is too weak.',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.lime,
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'The account already exists for that email.',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.lime,
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _pass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Password',
                      // prefixIcon: Icon(Icons.password),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _repass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Verify Password',
                      // prefixIcon: Icon(Icons.password),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    maxLength: 10,
                    controller: _mobile,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Mobile Number',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: TextField(
                    maxLength: 2,
                    controller: _age,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Age',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    var pass1 = _pass.text;
                    var pass2 = _repass.text;

                    if (pass2 == pass1) {
                      print('correct');
                      _saved();
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Already have an account'),
                    TextButton(
                      onPressed: () {
                        //Get.to(() => signIn());
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => signIn()),
                        );
                      },
                      child: Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
