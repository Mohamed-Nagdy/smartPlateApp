import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:smart_plate/constants.dart';

class PostWidget extends StatefulWidget {
  final icon, userImage, userName, date, postContent, postImage;

  PostWidget(
      {this.icon,
      this.userImage,
      this.userName,
      this.date,
      this.postContent,
      this.postImage});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {

  var color = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: CupertinoColors.activeGreen,
          )),
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: widget.userImage.toString() == IMAGES_LINK ? AssetImage('images/unknown.jpg') : NetworkImage(widget.userImage),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.userName,
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                            Text(
                              widget.date,
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  widget.icon == null ? Container() : widget.icon
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ReadMoreText(
                  widget.postContent,
                  trimLines: 2,
                  colorClickableText: Colors.blueAccent,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Show more',
                  trimExpandedText: ' show less',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              widget.postImage.toString() == IMAGES_LINK ? Container() : Container(
                child: Image(
                  image: NetworkImage(widget.postImage),
                  height: 150,
                ),
                margin: EdgeInsets.all(10),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: CupertinoColors.activeGreen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              if(color == Colors.blueGrey)
                                {
                                  color = Colors.red;
                                }
                              else
                                {
                                  color = Colors.blueGrey;
                                }
                            });
                          },
                          child: Icon(
                            CupertinoIcons.heart_solid,
                            color: color,
                            size: 25,
                          ),
                        ),
                        Icon(
                          Icons.comment,
                          color: Colors.blueGrey,
                          size: 25,
                        ),
                        Icon(
                          CupertinoIcons.share_up,
                          color: Colors.blueGrey,
                          size: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
