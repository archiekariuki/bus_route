import 'package:bus_route/screens/LoginPage.dart';
import 'package:bus_route/screens/MainPage.dart';
import 'package:bus_route/widgets/CustomButton.dart';
import 'package:bus_route/widgets/ProgressDialogBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  void registerUser() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        'Registering..',
      ),
    );

    final User user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text)
            .catchError((ex) {
      //Catch error and display message
      Navigator.pop(context);
      showSnackBar(ex.message);
    }))
        .user;
    Navigator.pop(context);
    if (user != null) {
      DatabaseReference newDBRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');

      Map userMap = {
        'fullname': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };
      newDBRef.set(userMap);

      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text('Register',
                    style: TextStyle(fontSize: 30, fontFamily: 'Brand-Bold')),
                SizedBox(
                  height: 20,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Full Names',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        height: 50,
                        width: double.infinity,
                        child: CustomButton(
                          title: 'Register',
                          color: Theme.of(context).primaryColor,
                          onpressed: () async {
                            var connectivityResult =
                                await Connectivity().checkConnectivity();
                            if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                connectivityResult != ConnectivityResult.wifi) {
                              showSnackBar('No Internet Connection');
                              return;
                            }
                            //Validate Registration Form
                            if (fullNameController.text.length < 3) {
                              showSnackBar('Please provide a valid full name');
                              return;
                            }
                            if (phoneController.text.length < 10) {
                              showSnackBar(
                                  'Please provide a valid phone number');
                              return;
                            }
                            if (!emailController.text.contains('@')) {
                              showSnackBar(
                                  'Please provide a valid email address');
                              return;
                            }
                            if (passwordController.text.length < 8) {
                              showSnackBar('Please provide a valid password');
                              return;
                            }

                            registerUser();
                          },
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginPage.id, (route) => false);
                        },
                        child: Text('Already have an account? Sign In.'))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
