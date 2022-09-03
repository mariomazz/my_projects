import 'package:flutter/material.dart';
import 'drawer.dart';
import 'main_appbar.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    Key? key,
    required this.routeName,
    required this.homeRouteName,
    required this.notesRouteName,
    required this.home,
    required this.notes,
    required this.defaultRoute,
    required this.defaultIndex,
  }) : super(key: key);

  final String routeName;
  final String homeRouteName;
  final String notesRouteName;
  final String defaultRoute;
  final int defaultIndex;

  final Widget home;
  final Widget notes;

  dynamic current(dynamic route, {bool returnWidget = false}) {
    if (route is int) {
      if (route == 0) {
        if (returnWidget) {
          return home;
        }
        return homeRouteName;
      }
      if (route == 1) {
        if (returnWidget) {
          return notes;
        }
        return notesRouteName;
      }
      if (returnWidget) {
        return home;
      }
      return defaultRoute;
    }

    if (route is String) {
      if (route == homeRouteName) {
        if (returnWidget) {
          return home;
        }
        return 0;
      }
      if (route == notesRouteName) {
        if (returnWidget) {
          return notes;
        }
        return 1;
      }
      if (returnWidget) {
        return home;
      }
      return 0;
    }
    throw Exception("Input Type Error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Row(
          children: [
            const MainDrawer(),
            Expanded(
              child: Scaffold(
                appBar: (MediaQuery.of(context).size.width >= 640)
                    ? const MainAppBar()
                    : null,
                body: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: current(routeName, returnWidget: true)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/* bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: current(routeName),
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              onTap: (index) {
                final selectRouteName = current(index);
                context.goNamed(selectRouteName);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Profilo',
                )
              ],
            )
          : null, */
         /*  if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              selectedIndex: current(routeName),
              onDestinationSelected: (index) {
                final selectRouteName = current(index);
                context.goNamed(selectRouteName);
              },
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(
                color: Colors.amber,
              ),
              leading: Column(
                children: const [
                  SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
              unselectedLabelTextStyle: const TextStyle(),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Profilo'),
                ),
              ],
            ),
          Expanded(child: current(routeName, returnWidget: true)), */