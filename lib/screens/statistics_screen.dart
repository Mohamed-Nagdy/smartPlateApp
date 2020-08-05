import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:provider/provider.dart';
import 'package:smart_plate/screens/history_screen.dart';
import 'package:smart_plate/utilities/shared_data.dart';
import 'package:smart_plate/widgets/chart_custom_widget.dart';
import 'package:smart_plate/widgets/meal_container.dart';

class StatisticsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<SharedData>(context);

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(double.parse(provider.users[0].calories.toString()), Colors.red[200], rankKey: 'Q1'),
          new CircularSegmentEntry(double.parse(provider.users[0].proteinInGrams.toString()), Colors.green[200], rankKey: 'Q2'),
          new CircularSegmentEntry(double.parse(provider.users[0].carbInGrams.toString()), Colors.blue[200], rankKey: 'Q3'),
          new CircularSegmentEntry(double.parse(provider.users[0].fatInGrams.toString()), Colors.yellow[200], rankKey: 'Q4'),
        ],
        rankKey: 'Must Used',
      ),
    ];

    List<CircularStackEntry> data2 = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(double.parse(provider.meals[0].energy.toString()), Colors.red[200], rankKey: 'Q1'),
          new CircularSegmentEntry(double.parse(provider.meals[0].protein.toString()), Colors.green[200], rankKey: 'Q2'),
          new CircularSegmentEntry(double.parse(provider.meals[0].carbs.toString()), Colors.blue[200], rankKey: 'Q3'),
          new CircularSegmentEntry(double.parse(provider.meals[0].fat.toString()), Colors.yellow[200], rankKey: 'Q4'),
        ],
        rankKey: 'Current Used',
      ),
    ];

    return SafeArea(
      child: CupertinoPageScaffold(
        backgroundColor: Colors.white,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.activeGreen,
          middle: Text('Statistics', style: TextStyle(fontSize: 18, color: CupertinoColors.white),),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ChartCustomWidget(
                data: data,
                mainLabel: 'Wanted Quantities',
                label1: 'Calories ${double.parse(provider.users[0].calories.toString()).toStringAsFixed(2)}',
                label2: 'protein In Grams ${double.parse(provider.users[0].proteinInGrams.toString()).toStringAsFixed(2)} GM',
                label3: 'carb In Grams ${double.parse(provider.users[0].carbInGrams.toString()).toStringAsFixed(2)} GM',
                label4: 'fat In Grams ${double.parse(provider.users[0].fatInGrams.toString()).toStringAsFixed(2)} GM',
              ),

              ChartCustomWidget(
                data: data2,
                mainLabel: 'Last Meal Data',
                label1: 'Calories ${double.parse(provider.meals[0].energy.toString()).toStringAsFixed(2)}',
                label2: 'protein In Grams ${double.parse(provider.meals[0].protein.toString()).toStringAsFixed(2)} GM',
                label3: 'carb In Grams ${double.parse(provider.meals[0].carbs.toString()).toStringAsFixed(2)} GM',
                label4: 'fat In Grams ${double.parse(provider.meals[0].fat.toString()).toStringAsFixed(2)} GM',
              ),

              Container(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                height: 300,
                child: Material(
                  color: Colors.white,
                  elevation: 8,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Meals History',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                      Expanded(
                        child: BezierChart(
                          xAxisCustomValues: const [1, 2, 3, 4, 5],
                          bezierChartScale: BezierChartScale.CUSTOM,
                          series: [
                            BezierLine(
                              lineColor: Colors.red[200],
                              label: "Energy",
                              data: provider.energyPoints,
                              lineStrokeWidth: 3
                            ),
                            BezierLine(
                                lineColor: Colors.yellow[200],
                              label: "Fat",
                              data: provider.fatPoints,
                              lineStrokeWidth: 4,
                            ),
                            BezierLine(
                                lineColor: Colors.blue[200],
                              label: "Carbs",
                              data: provider.carbsPoints,
                              lineStrokeWidth: 5
                            ),
                            BezierLine(
                                lineColor: Colors.green[200],
                              label: "Protein",
                              data: provider.proteinPoints,
                              lineStrokeWidth: 6
                            ),
                          ],
                          config: BezierChartConfig(
                            verticalIndicatorStrokeWidth: 2.0,
                            verticalIndicatorColor: Colors.black12,
                            showVerticalIndicator: true,
                            contentWidth: MediaQuery.of(context).size.width * 2,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              MealContainer(
                title: 'Last Meal You Had',
                energy: provider.meals[0].energy,
                protein: provider.meals[0].protein,
                fat: provider.meals[0].fat,
                carbs: provider.meals[0].carbs,
                date: provider.meals[0].date,
                images: provider.meals[0].images,
                recipes: provider.meals[0].recipes,
                quarter1Weight: provider.meals[0].quarter1Weight,
                quarter2Weight: provider.meals[0].quarter2Weight,
                quarter3Weight: provider.meals[0].quarter3Weight,
                quarter4Weight: provider.meals[0].quarter4Weight,
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: FlatButton(
                  padding: EdgeInsets.all(10),
                  color: CupertinoColors.activeGreen,
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context){
                      return HistoryScreen();
                    }));
                  },
                  child: Text(
                    'See Your History',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

