import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/rendering.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  //String _display = 'Results go here';
  //String _test = 'Tests go here';
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _stream;
  String? uid;
  var tcVisibility = false;
  final List lists = ['test','test'];

  @override
  void initState(){
    super.initState();
    _activateListeners();
  }

  Future<void> _activateListeners() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    _stream = _database.child("BMIUSR/"+uid!).onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value);

      lists.clear();
      data.forEach((key, value) {
        //print("$key and $value");
        lists.add(value);
        //print(value['Category']);
      });
      /*lists.forEach((element) {
        print(element['BMI']);
      });
      //final bmi = data['BMI'] as double;
      setState(() {
        _display = "$data";
        _test = lists[lists.length-1]['Date'].toString();
      });*/
      if(mounted){
        setState(() {
          tcVisibility = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(173, 194, 169,1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(153, 167, 153,1),
        title: const Text("Charts"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                children: [
                  /*Text(
                    _display
                ),
                Text(
                    _test
                ),*/
                  Visibility(
                    visible: tcVisibility,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(254, 245, 237,1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: chartWidget(),
                        )
                    ),
                  ),
                  Visibility(
                    visible: tcVisibility,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(254, 245, 237,1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: chartWidgetH(),
                        )
                    ),
                  ),
                  Visibility(
                    visible: tcVisibility,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(254, 245, 237,1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: chartWidgetW(),
                        )
                    ),
                  ),
                ]
            )
        ),
      )

      //body: chartWidget(),
    );
  }

  Widget chartWidget(){
    List<TimeSeriesBMI> tsdata = [];
    for (var element in lists) {
      try{
        //print(element);
        final stringDate = element['Date'].split(",");
        int year = int.parse(stringDate[0]);
        int month = int.parse(stringDate[1]);
        int day = int.parse(stringDate[2]);
        //String actualDate = stringDate[0] + "-" + stringDate[1] + "-" + stringDate[2];
        //print(actualDate);
        double info = double.parse(element['BMI'].toString());
        //print(info);
        tsdata.add(TimeSeriesBMI(DateTime(year,month,day), info));
      } catch (e) {
        print("Error: $e");
      }
    }

    var series = [
      charts.Series<TimeSeriesBMI, DateTime>(
        id: 'BMI',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesBMI test, _) => test.time,
        measureFn: (TimeSeriesBMI testing, _) => testing.bmi,
        data: tsdata,
      )
    ];

    var chart = charts.TimeSeriesChart(
      series,
      animate: true,
      behaviors: [
        charts.ChartTitle('BMI Chart',
          behaviorPosition: charts.BehaviorPosition.top),
        charts.ChartTitle('Date',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleStyleSpec: const charts.TextStyleSpec(fontSize: 12)),
        charts.ChartTitle('BMI',
          behaviorPosition: charts.BehaviorPosition.start,
          titleStyleSpec: const charts.TextStyleSpec(fontSize: 12)),
      ],
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: 200.0,
            child: chart,
          ),
        ),
      ],
    );
  }

  Widget chartWidgetH(){
    List<TimeSeriesHeight> tsdata2 = [];
    for (var element in lists) {
      try{
        //print(element);
        final stringDate = element['Date'].split(",");
        int year = int.parse(stringDate[0]);
        int month = int.parse(stringDate[1]);
        int day = int.parse(stringDate[2]);
        //String actualDate = stringDate[0] + "-" + stringDate[1] + "-" + stringDate[2];
        //print(actualDate);
        double info = double.parse(element['Height'].toString());
        //print(info);
        tsdata2.add(TimeSeriesHeight(DateTime(year,month,day), info));
      } catch (e) {
        print("Error: $e");
      }
    }

    var series2 = [
      charts.Series<TimeSeriesHeight, DateTime>(
        id: 'Height',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesHeight test, _) => test.time,
        measureFn: (TimeSeriesHeight testing, _) => testing.height,
        data: tsdata2,
      )
    ];

    var chart = charts.TimeSeriesChart(
      series2,
      animate: true,
      behaviors: [
        charts.ChartTitle('Height Chart',
          behaviorPosition: charts.BehaviorPosition.top),
        charts.ChartTitle('Date',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleStyleSpec: const charts.TextStyleSpec(fontSize: 12)),
       charts.ChartTitle('Height',
          behaviorPosition: charts.BehaviorPosition.start,
          titleStyleSpec: const charts.TextStyleSpec(fontSize: 12)),
      ]
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: 200.0,
            child: chart,
          ),
        ),
      ],
    );
  }

  Widget chartWidgetW(){
    List<TimeSeriesWeight> tsdata3 = [];
    for (var element in lists) {
      try{
        //print(element);
        final stringDate = element['Date'].split(",");
        int year = int.parse(stringDate[0]);
        int month = int.parse(stringDate[1]);
        int day = int.parse(stringDate[2]);
        //String actualDate = stringDate[0] + "-" + stringDate[1] + "-" + stringDate[2];
        //print(actualDate);
        double info = double.parse(element['Weight'].toString());
        //print(info);
        tsdata3.add(TimeSeriesWeight(DateTime(year,month,day), info));
      } catch (e) {
        print("Error: $e");
      }
    }

    var series3 = [
      charts.Series<TimeSeriesWeight, DateTime>(
        id: 'Weight',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (TimeSeriesWeight test, _) => test.time,
        measureFn: (TimeSeriesWeight testing, _) => testing.weight,
        data: tsdata3,
      )
    ];

    var chart = charts.TimeSeriesChart(
      series3,
      animate: true,
      behaviors: [
        charts.ChartTitle('Weight Chart',
          behaviorPosition: charts.BehaviorPosition.top),
        charts.ChartTitle('Date',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleStyleSpec: const charts.TextStyleSpec(fontSize: 12)),
        charts.ChartTitle('Weight',
          behaviorPosition: charts.BehaviorPosition.start,
          titleStyleSpec: const charts.TextStyleSpec(fontSize: 12)),
      ],
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: 200.0,
            child: chart,
          ),
        ),
      ],
    );
  }

  @override
  void deactivate(){
    _stream.cancel();
    super.deactivate();
  }
}

class TimeSeriesBMI {
  final DateTime time;
  final double bmi;
  TimeSeriesBMI(this.time, this.bmi);
}

class TimeSeriesHeight {
  final DateTime time;
  final double height;
  TimeSeriesHeight(this.time, this.height);
}

class TimeSeriesWeight {
  final DateTime time;
  final double weight;
  TimeSeriesWeight(this.time, this.weight);
}
