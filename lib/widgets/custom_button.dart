import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final onTap;
  CustomButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 500,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: CupertinoColors.activeGreen,
        ),
        height: 50,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 28,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
