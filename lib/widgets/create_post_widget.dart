import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_plate/screens/create_post.dart';

class CreatePostWidget extends StatelessWidget {

  final userImage;

  CreatePostWidget({this.userImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        elevation: 8,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(userImage),
                radius: 25,
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, ),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: FlatButton(
                    child: Text('Create New Post .....'),
                    onPressed: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context){
                        return CreatePostScreen();
                      }));
                    },
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
