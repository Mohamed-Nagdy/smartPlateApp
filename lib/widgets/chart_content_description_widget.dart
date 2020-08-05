import 'package:flutter/material.dart';

class ChartContentDescription extends StatelessWidget {

  final color, label;

  ChartContentDescription({this.color, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 15,
          height: 15,
          color: color,
        ),
        SizedBox(width: 10,),
        Text(
          label,
          style: TextStyle(
              fontSize: 18
          ),
        ),
      ],
    );
  }
}
