import 'package:AddFile/constants/constants.dart';
import 'package:AddFile/widgets/shared/progress-indicator/progress_indicator.dart';
import 'package:flutter/material.dart';

class InitialLoad extends StatelessWidget {
  const InitialLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(
          const Duration(milliseconds: 1500),
          () => Navigator.of(context).pushNamed('/home'),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return WillPopScope(
              onWillPop: () async {
                Navigator.of(context).pushNamed('/');
                return false;
              },
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: MyColors.lightGrey.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20.0),
                            child: Text(
                              'Send Files',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              color: MyColors.lightGrey.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/icons/main.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 100),
                    CustomProgressIndicator(),
                  ],
                ),
              ),
            );
          else
            return Container();
        });
  }
}
