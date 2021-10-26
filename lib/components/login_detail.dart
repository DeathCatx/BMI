import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config.dart';

class Logins extends StatefulWidget {
  const Logins({Key? key}) : super(key: key);

  @override
  _LoginsState createState() => _LoginsState();
}

class _LoginsState extends State<Logins> {
  String? _email,_password;
  String error=" ";
  var tcVisibility = false;

  Future<void> _createUser() async {
    try{
      setState(() {
        tcVisibility = false;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email!, password: _password!);
    } on FirebaseAuthException catch (e){
      //print("Error: $e");
      setState(() {
        error = "Error: $e";
        tcVisibility = true;
      });
    } catch (e){
      //print("Error: $e");
      setState(() {
        error = "Error: $e";
        tcVisibility = true;
      });
    }
  }

  Future<void> _loginUser() async {
    try{
      setState(() {
        tcVisibility = false;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email!, password: _password!);
    } on FirebaseAuthException catch (e){
      //print("Error: $e");
      setState(() {
        error = "Error: $e";
        tcVisibility = true;
      });
    } catch (e){
      //print("Error: $e");
      setState(() {
        error = "Error: $e";
        tcVisibility = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 584,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const Positioned(
            left: 40,
            top: 99,
            child: Text(
              'Email',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
              left: 40,
              right: 40,
              top: 129,
              child: SizedBox(
                width: 310,
                child: TextField(
                  onChanged: (value){
                    _email = value;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(color: hintText),
                  ),
                ),
              )),
          const Positioned(
            left: 40,
            top: 199,
            child: Text(
              'Password',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
              left: 40,
              right: 40,
              top: 229,
              child: SizedBox(
                width: 310,
                child: TextField(
                  enableSuggestions: false,
                  obscureText: true,
                  onChanged: (value){
                    _password = value;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: hintText),
                  ),
                ),
              )),
          Positioned(
              top: 320,
              right: 60,
              child: Container(
                width: 99,
                height: 35,
                decoration: const BoxDecoration(
                  color: signInButton,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: MaterialButton(
                  onPressed: _loginUser,
                  child: const Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w400),
                  ),
                )
              )
          ),
          Positioned(
              top: 320,
              left: 50,
              right: MediaQuery.of(context).size.width/2,
              child: SizedBox(
                width: 170,
                height: 35,
                child: MaterialButton(
                  onPressed: _createUser,
                  child: const Text(
                    'Create an account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w400),
                  ),
                )
              )
          ),
          Positioned(
            top: 380,
            //bottom: 50,
            left: 50,
            right: 50,
            child: Visibility(
              visible: tcVisibility,
              child: Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w400),
              )
            )
          ),
        ],
      ),
    );
  }
}
