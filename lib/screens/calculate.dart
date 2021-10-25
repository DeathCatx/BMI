import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final database = FirebaseDatabase.instance.reference();
  String? uid;
  double height=160,weight=40;
  double? bmi;
  var tcVisibility = false;
  String? usrCategory;

  double calBmi(double h, double w){
    double result = double.parse((w / (h * h) * 10000).toStringAsFixed(2));
    return result;
  }

  String category(double bmi){
    if(bmi < 20){
      return ("Underweight");
    }else if(bmi >= 20 && bmi <= 25){
      return ("Normal");
    }else if(bmi > 25 && bmi < 30){
      return ("Slightly Overweight");
    }else if(bmi >= 30 && bmi < 40){
      return ("Overweight");
    }else if(bmi > 40){
      return ("Extremely Overweight");
    }else{
      return ("Error");
    }
  }

  Future<void> insert() async {
    uid = FirebaseAuth.instance.currentUser!.uid;

    final DateTime now = DateTime.now();
    //print(now);
    final DateFormat formatter = DateFormat('yyyy,MM,dd');
    final String formatted = formatter.format(now);
    bmi = calBmi(height, weight);
    usrCategory = category(bmi!);
    final testing = <String, dynamic>{
      'BMI': bmi,
      'Category': usrCategory,
      'Date': formatted,
      'Height': height,
      'Weight': weight};
    database
        .child('BMIUSR/'+uid!+'/'+ formatted)
        .update(testing)
        .then((_) => print("Written in!"))
        .catchError((error) => print('Error: $error'));
    setState(() {
      tcVisibility = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final BMIRef = database.child('MyBMIUSR/');
    return Scaffold(
      backgroundColor: const Color.fromRGBO(211, 228, 205,1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(153, 167, 153,1),
        title: const Text("Calculate BMI"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(254, 245, 237,1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: const [
                            Icon(Icons.height),
                            SizedBox(width: 10,),
                            Text(
                              'Height(cm)',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                          activeTrackColor: Color.fromRGBO(173, 194, 169,1),
                          thumbColor: Color.fromRGBO(153, 167, 153,1)
                        ),
                        child: Slider(
                          value: height,
                          min: 0,
                          max: 250,
                          divisions: 250,
                          label: height.round().toString(),
                          onChanged: (value){
                            setState(() {
                              height = value;
                            });
                          }
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(254, 245, 237,1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: const [
                              Icon(Icons.monitor_weight),
                              SizedBox(width: 10,),
                              Text(
                                'Weight(kg)',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )

                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                            activeTrackColor: Color.fromRGBO(173, 194, 169,1),
                            thumbColor: Color.fromRGBO(153, 167, 153,1)
                        ),
                        child: Slider(
                            value: weight,
                            min: 0,
                            max: 250,
                            divisions: 250,
                            label: weight.round().toString(),
                            onChanged: (value){
                              setState(() {
                                weight = value;
                              });
                            }
                        ),
                      ),

                    ],
                  ),
                )
            ),
            const SizedBox(height: 20,),
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
              onPressed: insert,
              child: const Text('Calculate'),
            ),
            Visibility(
              visible: tcVisibility,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'BMI: '+ bmi.toString(),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ),
            ),
            Visibility(
              visible: tcVisibility,
              child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'You are '+ usrCategory.toString() + '.',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  )
              ),
            ),
          ],
        )
      )
    );
  }
}
