import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:routing_gr/routing_gr.dart';
import 'package:widgets/progress.dart';
import 'package:widgets/resolve_snapshot.dart';
import '../../core/authentication/authentication.dart';
import '../../core/models/notes.dart';
import '../../core/routing/routing.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/padding.dart';
import '../widgets/scaffold.dart';
import '../widgets/text.dart';
import '../widgets/vertical_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCS(
      backgroundColor: ThemeCS.backgroundPrimary,
      appBar: AppBarCS(
        title: TextCS(title: "Tutte le Note", size: TextSize.large),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthenticationService().logout();
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
                  .where("uid", isEqualTo: AuthenticationService().user?.uid)
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
                    }).toList();

                    return VerticalList(
                      elements: notes
                          .map((e) => CardCS(
                              onTap: () {
                                Routing().push(Pages.noteDetail.path, extra: e);
                              },
                              title: e.title ?? '',
                              subtitle: e.body ?? '',
                              externalPadding: true))
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
                  Routing().push(Pages.noteDetail.path, extra: "");
                },
                child: Icon(
                  size: double.parse("35.0"),
                  Icons.add,
                  color: ThemeCS.primaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
