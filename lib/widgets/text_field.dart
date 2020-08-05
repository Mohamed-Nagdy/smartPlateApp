import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final enable, controller, onChange, label;
  CustomTextField({this.enable=false, this.controller, this.onChange, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 30,
      child: TextField(
        enabled: enable,
        style: TextStyle(
            color: Colors.black
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[500]),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          focusColor: CupertinoColors.activeGreen,
          hoverColor: CupertinoColors.activeGreen,
        ),
        controller: controller,
        onChanged: onChange,
      ),
    );
  }
}
