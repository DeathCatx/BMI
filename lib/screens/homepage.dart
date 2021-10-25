import 'package:bmi/screens/advice.dart';
import 'package:bmi/screens/calculate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chart.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(211, 228, 205,1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                    padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.speed,
                    size: 80,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "BMI Calculator",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins-Medium',
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(173, 194, 169,1),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(254, 245, 237,1),
                ),
              ),
              onPressed: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Calculate()),
              );},
              child: const Text("Calculate BMI"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(173, 194, 169,1),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(254, 245, 237,1),
                ),
              ),
              onPressed: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Chart()),
              );},
              child: const Text('Display Chart'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(173, 194, 169,1),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(254, 245, 237,1),
                ),
              ),
              onPressed: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Advice()),
              );},
              child: const Text('Get Health Advice'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(173, 194, 169,1),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(254, 245, 237,1),
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
