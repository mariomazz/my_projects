import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:extension_methods/extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/progress.dart';
import 'package:widgets/show_loading.dart';
import '../../core/authentication/authentication.dart';
import '../../core/models/notes.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';
import '../widgets/padding.dart';
import '../widgets/scaffold.dart';
import '../widgets/text.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({Key? key}) : super(key: key);

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  Note? note;

  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  final _dialogController = PopUpController();

  Future<void> _updateNote(Note note) async {
    try {
      _dialogController.show();
      await FirebaseFirestore.instance.collection("notes").doc(note.id).set({
        "title": note.title,
        "body": note.body,
        "uid": note.uid,
        "updateAt": DateTime.now().toIso8601String(),
      }).then((_) {
        _dialogController.close();
      });
    } catch (e) {
      _dialogController.close();
      return;
    }
  }

  Future<void> _createNote(
      {required String title,
      required String body,
      required String uid}) async {
    try {
      _dialogController.show();
      await FirebaseFirestore.instance.collection("notes").doc().set({
        "title": title,
        "body": body,
        "uid": uid,
        "updateAt": DateTime.now().toIso8601String(),
      }).then((_) {
        _dialogController.close();
      });
    } catch (e) {
      _dialogController.close();
      return;
    }
  }

  Future<void> _deleteNote(String id) async {
    try {
      final query = await FirebaseFirestore.instance
          .collection("notes")
          .where(
            "id",
            isEqualTo: "232",
          )
          .get();

      /* query.docs.forEach((element) async {
        await 
      }); */

      _dialogController.show();
      await FirebaseFirestore.instance
          .collection("notes")
          .doc(id)
          .delete()
          .then((_) {
        _dialogController.close();
      });
    } catch (e) {
      _dialogController.close();
      return;
    }
  }

  Future<void> _checkSaving() async {
    _dialogController.show();
    if (note != null) {
      final save = (note?.title?.notEquals(_titleController.text) ?? true) ||
          (note?.body?.notEquals(_bodyController.text) ?? true);
      if (save) {
        return await _updateNote(
          Note(
            title: _titleController.text,
            body: _bodyController.text,
            id: note!.id,
            uid: note!.uid,
          ),
        );
      }
    } else {
      final creationNote = (_titleController.text.isNotEmpty ||
              _bodyController.text.isNotEmpty) &&
          (AuthenticationService().user?.uid != null);
      if (creationNote) {
        return await _createNote(
          body: _bodyController.text,
          title: _titleController.text,
          uid: AuthenticationService().user?.uid ?? "",
        );
      }
    }
    _dialogController.close();
  }

  @override
  void initState() {
    //_setNote(Routing().getExtra(Pages.noteDetail.path));
    if (note != null) {
      _titleController = TextEditingController(text: note!.title);
      _bodyController = TextEditingController(text: note!.body);
    } else {
      _titleController = TextEditingController();
      _bodyController = TextEditingController();
    }

    super.initState();
  }

  void _pop() async {
    // Routing().pop();
  }

  /*  Future<void> _setNote(dynamic data) async {
    if (data is Note) {
      note = data;
    } else {
      note = null;
    }
  } */

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _dialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopUp(
      builder: const ProgressCS(color: ThemeCS.white),
      background: Colors.transparent,
      controller: _dialogController,
      child: ScaffoldCS(
        appBar: AppBarCS(
          backgroundColor: ThemeCS.primary,
          title:
              note != null ? const Text("Modifica") : const Text("Crea nota"),
          leading: IconButton(
            onPressed: () async {
              await _checkSaving().then((_) {
                _pop();
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeCS.primaryText,
            ),
          ),
          actions: [
            note != null
                ? IconButton(
                    onPressed: () async {
                      if (note != null) {
                        await _deleteNote(note!.id);
                      }
                      _pop();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: ThemeCS.primaryText,
                    ),
                  )
                : const SizedBox()
          ],
        ),
        body: SizedBox.expand(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const PaddingCS(),
                    PaddingCS(
                      child: TextField(
                        onChanged: (value) {},
                        maxLines: null,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: ThemeCS.primaryText,
                          fontSize: TextSize.large.value,
                        ),
                        cursorColor: ThemeCS.primaryText,
                        decoration: InputDecoration(
                          hintText: "Titolo..",
                          labelText: "Titolo..",
                          hintStyle: TextStyle(
                            fontSize: TextSize.large.value,
                            color: ThemeCS.primaryText,
                          ),
                          labelStyle: TextStyle(
                            fontSize: TextSize.large.value,
                            color: ThemeCS.primaryText,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeCS.primary),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ThemeCS.primary),
                          ),
                        ),
                        controller: _titleController,
                      ),
                    ),
                    const PaddingCS(),
                    Expanded(
                      child: PaddingCS(
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (event) {
                            if (event.logicalKey == LogicalKeyboardKey.enter) {}
                          },
                          child: TextField(
                            onChanged: (value) {},
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                              color: ThemeCS.primaryText,
                              fontSize: TextSize.large.value,
                            ),
                            cursorColor: ThemeCS.primaryText,
                            decoration: InputDecoration(
                              hintText: "Nota..",
                              labelText: "Nota..",
                              hintStyle: TextStyle(
                                fontSize: TextSize.large.value,
                                color: ThemeCS.primaryText,
                              ),
                              labelStyle: TextStyle(
                                fontSize: TextSize.large.value,
                                color: ThemeCS.primaryText,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: ThemeCS.primary),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: ThemeCS.primary),
                              ),
                            ),
                            controller: _bodyController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              note != null && note?.updateAt != null
                  ? PaddingCS(
                      padding: 15,
                      child: TextCS(
                        title: "Modificato il ${formatDate(
                          note!.updateAt!,
                          [dd, " ", M],
                          locale: const ItalianDateLocale(),
                        )}",
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
