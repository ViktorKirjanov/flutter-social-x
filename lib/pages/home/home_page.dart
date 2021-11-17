import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'activity_feed/activity_feed_page.dart';
import 'create/create_page.dart';
import 'profile/profile_page.dart';
import 'search/search_page.dart';
import 'timeline/timeline_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: HomePage());

  final GlobalKey<NavigatorState> _firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _secondTabNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _fourthTabNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _fivthTabNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        inactiveColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.home,
              key: Key('timelineBottomItem'),
              size: 25.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.bell,
              key: Key('activityFeedBottomItem'),
              size: 25.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.cameraRetro,
              key: Key('createBottomItem'),
              size: 25.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.search,
              key: Key('searchBottomItem'),
              size: 25.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userCircle,
              key: Key('profileBottomItem'),
              size: 25.0,
            ),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              navigatorKey: _firstTabNavKey,
              builder: (BuildContext context) => const TimelinePage(),
            );
          case 1:
            return CupertinoTabView(
              navigatorKey: _secondTabNavKey,
              builder: (BuildContext context) => const ActivityFeedPage(),
            );
          case 2:
            return CupertinoTabView(
              navigatorKey: _thirdTabNavKey,
              builder: (BuildContext context) => const CreatePage(),
            );
          case 3:
            return CupertinoTabView(
              navigatorKey: _fourthTabNavKey,
              builder: (BuildContext context) => const SearchPage(),
            );
          case 4:
            return CupertinoTabView(
              navigatorKey: _fivthTabNavKey,
              builder: (BuildContext context) => const ProfilePage(),
            );
          default:
            return Container();
        }
      },
    );
  }
}
