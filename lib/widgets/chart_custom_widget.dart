import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'chart_content_description_widget.dart';

class ChartCustomWidget extends StatelessWidget {

  final data, label1, label2, label3, label4, mainLabel;

  ChartCustomWidget({this.data, this.label1, this.label2, this.label3, this.label4, this.mainLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 8,
        child: Container(
          padding: EdgeInsets.all(10),

          child: Column(
            children: <Widget>[
              Text(
                mainLabel,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedCircularChart(
                    size: const Size(200.0, 200.0),
                    initialChartData: data,
                    chartType: CircularChartType.Pie,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ChartContentDescription(
                        label: label1,
                        color: Colors.red[200],
                      ),
                      ChartContentDescription(
                        label: label2,
                        color: Colors.green[200],
                      ),
                      ChartContentDescription(
                        label: label3,
                        color: Colors.blue[200],
                      ),
                      ChartContentDescription(
                        label: label4,
                        color: Colors.yellow[200],
                      )

                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
