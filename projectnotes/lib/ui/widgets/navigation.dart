import 'package:flutter/material.dart';

import 'drawer.dart';
import 'main_appbar.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    Key? key,
    required this.routeName,
    required this.todosRouteName,
    required this.notesRouteName,
    required this.rapidNotesRouteName,
    required this.defaultRoute,
    required this.defaultIndex,
    required this.todos,
    required this.notes,
    required this.rapidNotes,
  }) : super(key: key);

  final String routeName;

  final String todosRouteName;
  final String notesRouteName;
  final String rapidNotesRouteName;

  final String defaultRoute;

  final int defaultIndex;

  final Widget todos;
  final Widget notes;
  final Widget rapidNotes;

  dynamic current(dynamic route, {bool returnWidget = false}) {
    if (route is int) {
      if (route == 0) {
        if (returnWidget) {
          return todos;
        }
        return todosRouteName;
      }
      if (route == 1) {
        if (returnWidget) {
          return notes;
        }
        return notesRouteName;
      }
      if (route == 2) {
        if (returnWidget) {
          return rapidNotes;
        }
        return rapidNotesRouteName;
      }
      if (returnWidget) {
        return todos;
      }
      return defaultRoute;
    }

    if (route is String) {
      if (route == todosRouteName) {
        if (returnWidget) {
          return todos;
        }
        return 0;
      }
      if (route == notesRouteName) {
        if (returnWidget) {
          return notes;
        }
        return 1;
      }
      if (route == rapidNotesRouteName) {
        if (returnWidget) {
          return rapidNotes;
        }
        return 2;
      }
      if (returnWidget) {
        return todos;
      }
      return 0;
    }
    throw Exception("Input Type Error");
  }

  Widget _current(String routeName) {
    if (routeName == todosRouteName) {
      return todos;
    }
    if (routeName == notesRouteName) {
      return notes;
    }
    if (routeName == rapidNotesRouteName) {
      return rapidNotes;
    }
    throw Exception("No Match Route Name");
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
                appBar: const MainAppBar(),
                /* appBar: (MediaQuery.of(context).size.width >= 640)
                    ? const MainAppBar()
                    : null, */
                body: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: _current(routeName)),
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