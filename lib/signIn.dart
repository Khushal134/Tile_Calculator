// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tile_calculator/home_page.dart';
import 'package:tile_calculator/signup.dart';

class signIn extends StatelessWidget {
  const signIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: login(),
      ),
    );
  }
}

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _email1 = TextEditingController();
  TextEditingController _pass = TextEditingController();

  // FirebaseFirestore _data = FirebaseFirestore.instance;

  void _log() async {
    try {
      print("data");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email1.text.toString(),
        password: _pass.text.toString(),
      );
      //Get.off(Homepage());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
      );
      Fluttertoast.showToast(
        msg: 'Login success',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.lime,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // void signnav() {
  //   try {
  //     Get.off(Signup());
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // void signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Signup(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn '),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _email1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email Address',
                      prefixIcon: Icon(Icons.email),
                      // filled: true,
                      // fillColor: Colors.lightBlueAccent,
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
                      prefixIcon: Icon(Icons.password),
                      // filled: true,
                      // fillColor: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _log();
                  },
                  child: Text(
                    'Login',
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
                    Text('Create Account'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup(),
                          ),
                        );
                        //signnav();
                        //Get.to(Signup());
                      },
                      child: Text('Sign Up'),
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
