import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onpressed;

  CustomButton({this.title, this.color, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onpressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: color,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18.0, fontFamily: 'Brand-Bold', color: Colors.white),
      ),
    );
  }
}
