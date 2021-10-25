import 'package:bmi/components/layer_one.dart';
import 'package:bmi/components/layer_two.dart';
import 'package:bmi/components/login_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/primaryBg.png'),
            fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: const <Widget>[
            Positioned(
              top: 180,
              left: 59,
              child: Text(
                'BMI',
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              )
            ),
            Positioned(
              top: 130,
              right: 50,
              child: Icon(
                Icons.speed,
                size: 140,
                color: Color.fromRGBO(211, 228, 205, 1),
              ),
            ),
            Positioned(top: 260, right: 0, bottom: 0, child: LayerOne()),
            Positioned(top: 300, right: 0, bottom: 28, child: LayerTwo()),
            Positioned(top: 270, right: 0, bottom: 10, child: Logins()),
            /*Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (value){
                        _email = value;
                      },
                      decoration: const InputDecoration(
                          hintText: "Email"
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      onChanged: (value){
                        _password = value;
                      },
                      decoration: const InputDecoration(
                          hintText: "Password"
                      ),
                    ),
                  ],
                ),
            ),*/
          ]
        )
      )
      /*body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value){
                _email = value;
              },
              decoration: const InputDecoration(
                hintText: "Email"
              ),
            ),
            TextField(
              obscureText: true,
              onChanged: (value){
                _password = value;
              },
              decoration: const InputDecoration(
                hintText: "Password"
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: _loginUser,
                  child: const Text("Login"),
                ),
                MaterialButton(
                  onPressed: _createUser,
                  child: const Text("Create New Account"),
                ),
              ],
            )
          ]
        ),
      )*/
    );
  }
}
