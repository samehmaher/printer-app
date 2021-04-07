import 'package:final_project/component/color.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:final_project/widget/button_reuse.dart';
import 'package:final_project/widget/custom_textField.dart';
import 'package:final_project/widget/header.dart';
import 'package:final_project/widget/social_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String password, name, email;
  bool spinner = false;
  var _formKey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is Required'),
    EmailValidator(errorText: 'Email not Valid'),
  ]);
  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password at least 8 chars'),
    PatternValidator(r'(?=.?[#?!@$%^&-])',
        errorText: 'password must have special chars')
  ]);
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Header(
                  text: 'Register',
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
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: emailValidator,
                            onChanged: (value) {
                              email = value;
                              //Do something with the user input.
                            },
                          ),
                          customTextField(
                            hint: 'Password',
                            icon: Icons.vpn_key,
                            obscureText: show,
                            keyboardType: TextInputType.visiblePassword,
                            iconV: show?Icons.visibility:Icons.visibility_off ,
                            iconTap: (){
                              setState(() {
                                show = !show;
                              });
                            },
                            controller: _passwordController,
                            validator: passwordValidator,
                            onChanged: (value) {
                              password = value;
                              //Do something with the user input.
                            },
                          ),
                          ButtonReuse(
                            text: 'REGISTER',
                            width: double.infinity,
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult !=
                                        ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
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
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                    Navigator.pop(context);

                                    setState(() {
                                      spinner = false;
                                    });
                                  } catch (e) {
                                    setState(() {
                                      spinner = false;
                                    });
                                    if (e is FirebaseAuthException) {
                                      if (e.code == 'email-already-in-use') {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Email Already in Use'),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        ));
                                      }
                                    }
                                  }
                                }
                              }
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
                              Text('Already have Account? ',
                                  style: TextStyle(color: Colors.black)),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text('Sign In',
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
