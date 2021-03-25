import 'package:final_project/component/color.dart';
import 'package:final_project/screens/signup_screen.dart';
import 'package:final_project/widget/button_reuse.dart';
import 'package:final_project/widget/custom_textField.dart';
import 'package:final_project/widget/header.dart';
import 'package:final_project/widget/social_icon.dart';
import 'package:final_project/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password, email;
  var spinner = false;
  var _auth = FirebaseAuth.instance;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
  ]);
  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
  ]);
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder:(context) => ModalProgressHUD(
          inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Header(
                  text: 'SIGN IN',

                ),
                Form(
                    key: _formKey,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      margin: EdgeInsets.only(left: 20, top: 20, right: 30),
                      child: Column(
                        children: [
                          customTextField(
                              hint: 'Email',
                              icon: Icons.email,
                              obscureText: false,
                              validator: emailValidator,
                              keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                              onChanged: (value) {
                                email = value;
                                //Do something with the user input.
                              },
                          ),
                          customTextField(
                              hint: 'Password',
                              icon: Icons.vpn_key,
                              obscureText: show,
                              validator: passwordValidator,
                              iconV: show?Icons.visibility:Icons.visibility_off ,
                              iconTap: (){
                                setState(() {
                                  show = !show;
                                });
                              },
                              keyboardType: TextInputType.visiblePassword,
                            controller:_passwordController ,
                            onChanged: (value) {
                              password = value;
                              //Do something with the user input.
                            },
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password?",
                            ),
                          ),
                          ButtonReuse(
                            text: 'SIGN IN',
                            width: double.infinity,
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                var connectivityResult = await (Connectivity()
                                    .checkConnectivity());
                                if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  // ignore: deprecated_member_use
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('No Internet Connection'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                  try {
                                    setState(() {
                                      spinner = true;
                                    });

                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                    _emailController.clear();
                                    _passwordController.clear();
                                    setState(() {
                                      spinner = false;
                                    });
                                  } catch (e) {
                                    setState(() {
                                      spinner = false;
                                    });
                                    if (e is FirebaseAuthException) {
                                      if (e.code == 'user-not-found') {
                                        // ignore: deprecated_member_use
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('user not found'),
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      } else if (e.code == 'wrong-password') {
                                        // ignore: deprecated_member_use
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('wrong password'),
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 5),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                }
                              }
                              //Implement login functionality.
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialIcons(
                                icon: FontAwesomeIcons.facebookF,
                                bg: lightBlue,
                                ic: Colors.white,
                              ),
                              SocialIcons(
                                  icon: FontAwesomeIcons.google,
                                  ic: Colors.white,
                                  bg: deepBlue),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have Account? ',
                                  style: TextStyle(color: Colors.black)),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()));
                                  },
                                  child: Text('Register',
                                      style: TextStyle(color: deepBlue))),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
