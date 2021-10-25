import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Advice extends StatefulWidget {
  const Advice({Key? key}) : super(key: key);

  @override
  _AdviceState createState() => _AdviceState();
}

class _AdviceState extends State<Advice> {
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription tunggu;
  double bmi=0;
  String? uid, result="Please Enter Your Current BMI";

  void getAdvice() async{
    String after = " ";
    if(bmi>=30){
      after = "Current BMI:$bmi\n\nYou are obese. \nDo not eat anything oily and high sugar.\nSport recommended for obese: \n1. Swimming \n2. Jogging \n3. Walking";
    }else if(bmi>=25 && bmi<30){
      after = "Current BMI:$bmi\n\nYou are overweight. \nEat less oily food. Eat more vegetables and fruits.\nSport recommended for overweight: \n1.Swimming \n2. Jogging \n3. Cycling \n4. Gym";
    }else if(bmi>=18.5 && bmi<25){
      after = "Current BMI:$bmi\n\nYou are normal. Keep on good work. \nEat more vegetables and fruits. \nSport recommended for normal: \n1.Swimming \n2. Jogging \n3. Cycling \n4. Gym";
    }else if(bmi<18.5 && bmi<18.5){
      after = "Current BMI:$bmi\n\nYou are underweight. \nYou need to eat more carbohydrates and protein. \nSport recommended for underweight: \n1.Walking \n2. Jogging \n3. Gym";
    }else {
      after = "Invalid Input";
    }
    setState(() {
      result = after;
    });
  }

  Future<void> _getLatest() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    double latest;
    final List lists = ['test','test'];
    tunggu = database.child("BMIUSR/"+uid!).onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value);

      lists.clear();
      data.forEach((key, value) {
        lists.add(value);
      });
      latest = lists[lists.length-1]['BMI'];
      if(mounted){
        setState(() {
          bmi=latest;
          getAdvice();
        });
      };
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(211, 228, 205,1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(153, 167, 153,1),
          title: const Text("Get Health Advice"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                SliderTheme(
                  data: const SliderThemeData(
                      activeTrackColor: Color.fromRGBO(173, 194, 169,1),
                      thumbColor: Color.fromRGBO(153, 167, 153,1)
                  ),
                  child: Slider(
                      value: bmi,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: bmi.round().toString(),
                      onChanged: (value){
                        setState(() {
                          bmi = value.roundToDouble();
                        });
                      }
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(173, 194, 169,1),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Medium',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(254, 245, 237,1),
                    ),
                  ),
                  onPressed: getAdvice,
                  child: const Text('Get Advice'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(173, 194, 169,1),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Medium',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(254, 245, 237,1),
                    ),
                  ),
                  onPressed:_getLatest,
                  child: const Text('Get Latest BMI'),
                ),
                const SizedBox(height:10),
                SizedBox(
                  width: 350,
                  child: Text(
                    result.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Medium',
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  )
                )
              ],)
        )
    );
  }

  @override
  void deactivate(){
    tunggu.cancel();
    super.deactivate();
  }
}
