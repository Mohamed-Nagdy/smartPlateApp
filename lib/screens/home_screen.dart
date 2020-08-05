import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_plate/constants.dart';
import 'package:smart_plate/utilities/shared_data.dart';
import 'package:smart_plate/widgets/create_post_widget.dart';
import 'package:smart_plate/widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<SharedData>(context);

    return SafeArea(
      child: Scaffold(
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.activeGreen,
            middle: Text('Home Page', style: TextStyle(fontSize: 18, color: CupertinoColors.white), ),
          ),
          child: ListView.builder(itemBuilder: (context, index){
            if(index == 0)
              {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: CreatePostWidget(
                    userImage: IMAGES_LINK + provider.users[0].userImage,
                  ),
                );
              }
            else
              {
                return PostWidget(
                  date: provider.allPosts[index-1].postDate,
                  postContent: provider.allPosts[index-1].postContent,
                  postImage: IMAGES_LINK + provider.allPosts[index-1].postImage,
                  userImage: IMAGES_LINK + provider.allPosts[index-1].userImage,
                  userName: provider.allPosts[index-1].userName,
                );
              }

          },
          itemCount: provider.allPosts.length + 1,)
        ),
      ),
    );
  }
}
