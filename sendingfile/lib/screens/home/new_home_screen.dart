import 'dart:io';
import 'package:AddFile/services/apiservice/apiservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:AddFile/constants/constants.dart';
import 'package:AddFile/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  List<File> files = [];

  // --------- show snackbar ---------

  void showSnackBar(BuildContext context, String message,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 1),
        content: Text('$message'),
      ),
    );
  }

  // --------- end show snackbar ---------

  // --------- send files ---------

  void sendFilesChopper(context, List<File> files_) async {
    var response = await Provider.of<ApiService>(context, listen: false)
        .uploadFile(
      http.MultipartFile.fromBytes(
        'file',
        files_[0].readAsBytesSync(),
        filename: basename(files_[0].path),
      ),
    )
        .then(
      (response) {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          printWarning('file inviato');

          setState(() {
            files.clear();
          });
        }
      },
      onError: () => setState(() => files.clear()),
    );
    /*  .then((response) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        printWarning('file inviato');
        showSnackBar(context, 'file inviato');

        setState(() {
          file = null;
          loadingFile = false;
        });
      }
    }).onError((error, stackTrace) {
      printWarning('error');
      showSnackBar(
        context,
        'errore file non inviato',
        backgroundColor: Colors.red,
      );
      setState(() {
        file = null;
        loadingFile = false;
      });
    }); */
  }

  // --------- end send files ---------

  // --------- select files ---------

  void selectionFile(context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true).then(
      (result) {
        if (result != null) {
          setState(() {
            files = result.files.map((file) => File(file.path)).toList();
          });
          printWarning(files);
        } else {
          printWarning('no file uploaded');
        }
      },
      onError: () => setState(() => files.clear()),
    );
  }

  // --------- ^ select files ---------

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.primary,
          automaticallyImplyLeading: false,
          title: Text(
            'sending file',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: body(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: files.isEmpty
              ? ElevatedButton(
                  onPressed: () {
                    selectionFile(context);
                  },
                  child: Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.black,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: MyColors.secondary,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15),
                  ),
                )
              : ElevatedButton(
                  onPressed: () => sendFilesChopper(context, files),
                  child: Icon(
                    FontAwesomeIcons.share,
                    color: Colors.black,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: MyColors.secondary,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15),
                  ),
                ),
        ),
      ),
    );
  }

  Widget body() {
    if (files.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('nessun file selezionato'),
        ),
      );
    }

    return Center(
      child: Wrap(children: [
        for (int i = 0; i < files.length; i += 1) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              materialTapTargetSize: MaterialTapTargetSize.padded,
              label: Container(
                constraints: files.length > 4
                    ? BoxConstraints(maxWidth: 70.0)
                    : BoxConstraints(maxWidth: 150.0),
                child: Text(
                  basename(files[i].path),
                  maxLines: 1,
                ),
              ),
              onDeleted: () => setState(() {
                files.removeAt(i);
              }),
            ),
          ),
        ]
      ]),
    );
  }
}
