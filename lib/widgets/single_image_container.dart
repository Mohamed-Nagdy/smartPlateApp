import 'package:flutter/material.dart';

class SingleImageContainer extends StatelessWidget {

  final image, description, weight;

  SingleImageContainer({this.image, this.description, this.weight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Material(
        elevation: 5,
        child: Container(
          height: 170,
          width: 150,
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Image(image: NetworkImage(image), width: 100, height: 100,),
              Text(
                description,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18
                ),
              ),
              Text(
                '$weight GM',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
