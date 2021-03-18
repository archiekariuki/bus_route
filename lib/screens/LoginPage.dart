import 'package:bus_route/screens/MainPage.dart';
import 'package:bus_route/screens/RegistrationPage.dart';
import 'package:bus_route/widgets/CustomButton.dart';
import 'package:bus_route/widgets/ProgressDialogBox.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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

  void login() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog('Logging you in'),
    );

    final User user = (await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((onError) {
      Navigator.pop(context);
      showSnackBar(onError.message);
    }))
        .user;
    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        }
      });
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
                  height: 150,
                ),
                Text('Sign In',
                    style: TextStyle(fontSize: 30, fontFamily: 'Brand-Bold')),
                SizedBox(
                  height: 20,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text('Forgot Password')],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: CustomButton(
                        title: 'Login',
                        color: Theme.of(context).primaryColor,
                        onpressed: () async {
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No Internet Connection');
                            return;
                          }
                          if (!emailController.text.contains('@')) {
                            showSnackBar('Please put in valid email address');
                          }
                          if (passwordController.text.length < 8) {
                            showSnackBar('Password Incorrect');
                          }
                          login();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, RegistrationPage.id, (route) => false);
                        },
                        child: Text('Don\'t have an account? Sign Up Here.'))
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
