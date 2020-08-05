import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_plate/screens/more_screen.dart';
import 'package:smart_plate/screens/personal_screen.dart';
import 'package:smart_plate/screens/statistics_screen.dart';
import 'package:smart_plate/utilities/shared_data.dart';

import 'home_screen.dart';

class MainAppScreen extends StatefulWidget {
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {

  final GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> searchKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> favKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> cartKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> moreKey = GlobalKey<NavigatorState>();

  final CupertinoTabController _tabController = CupertinoTabController();

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<SharedData>(context);
    context.locale = provider.locale;

    return WillPopScope(
      onWillPop: () async{
        return !await currentNavigatorKey().currentState.maybePop();
      },
      child: CupertinoTabScaffold(
        controller: _tabController,
        tabBar: CupertinoTabBar(
          backgroundColor: CupertinoColors.activeGreen,
          items: <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home, size: 35, color: Colors.black,),
//            title: Text('vehicle'.tr()),
              activeIcon: Icon(CupertinoIcons.home, color: CupertinoColors.white, size: 40,),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart, size: 40, color: Colors.black,),
//            title: Text('container'.tr()),
              activeIcon: Icon(Icons.show_chart, color: CupertinoColors.white, size: 40,),
            ),

            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person, size: 40, color: Colors.black,),
//            title: Text('users'.tr()),
              activeIcon: Icon(CupertinoIcons.person, color: CupertinoColors.white, size: 40,),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz, size: 40, color: Colors.black,),
//            title: Text('profile'.tr()),
              activeIcon: Icon(Icons.more_horiz, color: CupertinoColors.white, size: 40,),
            ),

          ],
        ),

        tabBuilder: (context, index) {
          CupertinoTabView returnValue;
          switch (index) {

            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return HomeScreen();
              },
                navigatorKey: homeKey,
              );
              break;

            case 1:
              returnValue = CupertinoTabView(builder: (context) {
                return StatisticsScreen();
              },
                navigatorKey: searchKey,
              );
              break;

            case 2:
              returnValue = CupertinoTabView(builder: (context) {
                return PersonalScreen();
              },
                navigatorKey: favKey,
              );
              break;

            case 3:
              returnValue = CupertinoTabView(builder: (context) {
                return MoreScreen();
              },
                navigatorKey: moreKey,
              );
              break;
          }
          return returnValue;
        },
      ),
    );
  }

  GlobalKey<NavigatorState> currentNavigatorKey() {
    switch (_tabController.index) {
      case 0:
        return homeKey;
        break;
      case 1:
        return searchKey;
        break;
      case 2:
        return favKey;
        break;
      case 3:
        return moreKey;
        break;
    }

    return null;
  }

}
