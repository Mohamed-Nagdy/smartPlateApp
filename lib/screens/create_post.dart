import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_plate/constants.dart';
import 'package:smart_plate/models/post_model.dart';
import 'package:smart_plate/utilities/network.dart';
import 'package:smart_plate/utilities/shared_data.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  String _value = 'public';
  Future<File> file;
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  String postContent = '';
  String postTitle = '';

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<SharedData>(context);


    return SafeArea(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          actionsForegroundColor: Colors.white,
          backgroundColor: CupertinoColors.activeGreen,
          middle: Text('Create New Post', style: TextStyle(color: Colors.white, fontSize: 18),),
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(IMAGES_LINK + provider.users[0].userImage),
                      ),
                      Text(
                        provider.users[0].userName,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18
                        ),
                      ),
                      DropdownButton(
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: Text("Public"),
                              value: 'public',
                            ),
                            DropdownMenuItem(
                              child: Text("Doctors Only"),
                              value: 'doctor',
                            ),
                            DropdownMenuItem(
                                child: Text("All Users"),
                                value: 'allUsers'
                            ),
                            DropdownMenuItem(
                                child: Text("Only Me"),
                                value: 'onlyMe'
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Material(
                      elevation: 8,
                      child: TextField(
                        onChanged: (value){
                          postTitle = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Post Title',
                          labelStyle: TextStyle(color: Colors.grey[500],),
                          contentPadding: EdgeInsets.all(10)
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Material(
                      elevation: 8,
                      child: TextField(
                        onChanged: (value){
                          postContent = value;
                        },
                        decoration: InputDecoration(

                          labelText: 'Create New Post....',
                          labelStyle: TextStyle(color: Colors.grey[500],),
                          contentPadding: EdgeInsets.all(10)
                        ),
                        maxLines: 10,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: chooseImage,
                        child: Icon(
                          Icons.camera_alt,
                          size: 35,
                          color: CupertinoColors.activeGreen,
                        ),
                      ),

                      showImage(),

                    ],
                  ),
                  RaisedButton(
                    onPressed: (){
                      createPost(context);
                    },
                    color: CupertinoColors.activeGreen,
                    child: Text('Post', style: TextStyle(color: Colors.white, fontSize: 18),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            alignment: Alignment.centerLeft,
            width: 100,
            height: 100,
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  void createPost(BuildContext context) async
  {
    var provider = Provider.of<SharedData>(context, listen: false);
    String fileName = tmpFile.path.split('/').last;
    print(fileName);
    NetworkHelper helper = NetworkHelper();

    var response = await helper.postData(SERVER_LINK, {
      'postContent': postContent,
      'postTitle': postTitle,
      'userId' : provider.users[0].userId,
      'userName' : provider.users[0].userName,
      'imageLink' : provider.users[0].userImage,
      'postPrivacy' : _value,
      'post_image' : base64Image,
      'post_image_name' : fileName
    });

    Post post = Post();
    post.postId = response['post_id'];
    post.postTitle = response['post_title'];
    post.postContent = response['post_content'];
    post.userName = response['user_name'];
    post.userImage = response['user_image'];
    post.postImage = response['post_image'];
    post.postDate = response['post_date'];
    post.postPrivacy = response['post_privacy'];
    post.userId = response['user_id'];

    provider.addToAllPosts(post);

    provider.addToUserPosts(post);

    Navigator.pop(context);


  }
}
