/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:widgets/progress.dart';
import 'package:widgets/resolve_snapshot.dart';
import 'package:widgets/show_loading.dart';
import '../../core/models/notes.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/padding.dart';
import '../widgets/scaffold.dart';
import '../widgets/text.dart';
import '../widgets/vertical_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final buttonLoadingController = PopUpController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCS(
      backgroundColor: ThemeCS.backgroundPrimary,
      appBar: AppBarCS(
        title: TextCS(title: "Tutte le Note", size: TextSize.large),
        actions: [
          IconButton(
            onPressed: () async {
              // await AuthenticationService().logout();
            },
            icon: const Icon(
              Icons.logout,
              color: ThemeCS.primaryText,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('notes')
                  // .where("uid", isEqualTo: AuthenticationService().user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                return ResolveSnapshot<QuerySnapshot<Map<String, dynamic>>>(
                  snapshot: snapshot,
                  onData: (data) {
                    final List<Note> notes = data.docs.map((e) {
                      return Note(
                        id: e.id,
                        uid: e["uid"],
                        title: e["title"],
                        body: e["body"],
                        updateAt: DateTime.parse(e["updateAt"]),
                      );
                    }).toList()
                      ..sort((a, b) {
                        if (a.updateAt != null && b.updateAt != null) {
                          return b.updateAt!.compareTo(a.updateAt!);
                        }

                        return 0;
                      });

                    return VerticalList(
                      elements: notes
                          .map(
                            (e) => CardCS(
                                onTap: () {
                                  /*  Routing()
                                      .push(Pages.noteDetail.path, extra: e); */
                                },
                                title: e.title ?? '',
                                subtitle: e.body ?? '',
                                externalPadding: true),
                          )
                          .toList(),
                    );
                  },
                  loading: const ProgressCS(color: ThemeCS.white),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            /*   top: 0,
            left: 0, */
            child: PaddingCS(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ThemeCS.color5),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // Routing().push(Pages.noteDetail.path, extra: "");
                },
                child: Icon(
                  size: double.parse("35.0"),
                  Icons.add,
                  color: ThemeCS.primaryText,
                ),
              ),
            ),
          ),
          PaddingCS(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ThemeCS.color5),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () async {
                buttonLoadingController.show();
                await Future.delayed(const Duration(seconds: 3), () {
                  buttonLoadingController.close();
                });
              },
              child: PopUp(
                expandContent: false,
                controller: buttonLoadingController,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Icon(
                    size: double.parse("35.0"),
                    Icons.add,
                    color: ThemeCS.primaryText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import '../widgets/scaffold.dart';
import '../widgets/text.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldI(
      body: Center(child: TextI(title: "Eventi")),
    );
  }
}
