import 'package:fittribe/theme/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget{
  @override
    _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController= TextEditingController();
  TextEditingController _passwordController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);


    final logo = Image.asset(
      "assets/1.png",
      height: mq.size.height / 4,
    );

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "something@gmail.com",
        labelText: "Email",
        hintStyle: TextStyle(
          color: Colors.white
        ),
        labelStyle: TextStyle(
          color: Colors.white,
        ),

      ),
    );

    final passwordfield = Column(

      children: <Widget>[
      TextFormField(
        obscureText: true,
      controller: _passwordController,
      style: TextStyle(
        color: Colors.white,
      ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "password",
          labelText: "Password",
          hintStyle: TextStyle(
              color: Colors.white
          ),
          labelStyle: TextStyle(
            color: Colors.white,
          ),

      ),
    ),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  "Forgot Password",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {

                }),
          ],
        ),
    ],
    );






    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordfield,
        ],
      ),
    );



    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          try {
            await Firebase.initializeApp();
            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text
            );
            Navigator.of(context).pushNamed(AppRoutes.menu);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
            }
          }
        },
      ),
    );













    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Not a member?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.white,
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );













    return Scaffold(
      backgroundColor: Color(0xff8c52ff),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            height: mq.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                logo,
                fields,
                bottom,
              ],
            ),
          ),
        ),
      ),
    );

  }
  
}
