import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_plate/constants.dart';
import 'package:smart_plate/utilities/network.dart';
import 'package:smart_plate/utilities/shared_data.dart';
import 'package:smart_plate/widgets/create_post_widget.dart';
import 'package:smart_plate/widgets/post_widget.dart';

class PersonalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<SharedData>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CupertinoPageScaffold(
          backgroundColor: Colors.white,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.activeGreen,
              middle: Text('Profile', style: TextStyle(fontSize: 18, color: CupertinoColors.white), ),
            ),
            child: ListView.builder(itemBuilder: (context, index){
              if(index == 0)
              {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[

                      // user profile image
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 45,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(IMAGES_LINK + provider.users[0].userImage),
                          backgroundColor: Colors.white,
                        ),
                      ),

                      Text(
                        provider.users[0].userName,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(125, 0, 0, 255),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        child: Material(
                          color: Colors.white,
                          elevation: 8,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Email : ${provider.users[0].userEmail}',
                                  style: USER_INFO_STYLE,
                                ),
                                Text(
                                  'Gender : ${provider.users[0].userGender == 'M' ? 'Male' : 'Female'}',
                                  style: USER_INFO_STYLE,
                                ),
                                Text(
                                  'Age : ${provider.users[0].userAge} Years',
                                  style: USER_INFO_STYLE,
                                ),
                                Text(
                                  'Height : ${provider.users[0].userHeight} CM',
                                  style: USER_INFO_STYLE,
                                ),
                                Text(
                                  'Weight : ${provider.users[0].userWeight} KG',
                                  style: USER_INFO_STYLE,
                                ),
                                Text(
                                  'Doctor Notes : ${provider.users[0].userDoctorNotes}',
                                  style: USER_INFO_STYLE,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      CreatePostWidget(
                        userImage: IMAGES_LINK + provider.users[0].userImage,
                      ),
                    ],
                  ),
                );
              }
              else
              {
                return PostWidget(
                  icon: GestureDetector(
                    onTap: (){
                      showCupertinoModalPopup(context: context, builder: (context){
                        return CupertinoActionSheet(
                          title: Text(
                            "Remove Post",
                            style: TextStyle(fontSize: 30),
                          ),
                          message: Text(
                            "Are You Sure You Need To Remove This Post ? ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text("Yes"),
                              isDefaultAction: true,
                              onPressed: () {
                                NetworkHelper helper = NetworkHelper();
                                helper.getData(SERVER_LINK + '?delete_post=${provider.userPosts[index-1].postId}');
                                provider.removeFromAllPosts(provider.userPosts[index-1]);
                                provider.removeFromUserPosts(provider.userPosts[index-1]);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      });
                    },
                    child: Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  date: provider.userPosts[index-1].postDate,
                  postContent: provider.userPosts[index-1].postContent,
                  postImage: IMAGES_LINK + provider.userPosts[index-1].postImage,
                  userImage: IMAGES_LINK + provider.userPosts[index-1].userImage,
                  userName: provider.userPosts[index-1].userName,
                );
              }

            },
              itemCount: provider.userPosts.length + 1,)
        ),
      ),
    );
  }
}
