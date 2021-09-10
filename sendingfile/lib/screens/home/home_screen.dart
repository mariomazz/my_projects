import 'dart:io';
import 'package:AddFile/constants/constants.dart';
import 'package:AddFile/main.dart';
import 'package:AddFile/services/apiservice/apiservice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? file;

  List<File>? files;
  bool loadingFile = false;

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
  //--------------------------------------------------

  void sendMultipleFile(context, List<File> files) async {
    setState(() {
      loadingFile = true;
    });

    files.forEach((file) {
      sendSingleFile(context, file);
    });

    setState(() {
      loadingFile = false;
    });
  }
  //--------------------------------------------------

  void sendSingleFile(context, File file) async {
    setState(() {
      loadingFile = true;
    });

    var response = await Provider.of<ApiService>(context, listen: false)
        .uploadFile(
      http.MultipartFile.fromBytes(
        'file',
        file.readAsBytesSync(),
        filename: basename(file.path),
      ),
    )
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        printWarning('file inviato');
        showSnackBar(context, 'file inviato');

        setState(() {
          // file = null;
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
        // file = null;
        loadingFile = false;
      });
    });
  }

  //--------------------------------------------------
  void sendFileChopper(context) async {
    setState(() {
      loadingFile = true;
    });

    var response = await Provider.of<ApiService>(context, listen: false)
        .uploadFile(
      http.MultipartFile.fromBytes(
        'file',
        file!.readAsBytesSync(),
        filename: basename(file!.path),
      ),
    )
        .then((response) {
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
    });
  }
  //--------------------------------------------------

  void sendFileHttp(BuildContext context) async {
    setState(() {
      loadingFile = true;
    });

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.0.113:3000/receive-file'));
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        file!.readAsBytesSync(),
        filename: basename(file!.path),
      ),
    );
    var res = await request.send().then((response) {
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
      showSnackBar(context, 'errore file non inviato');
      setState(() {
        file = null;
        loadingFile = false;
      });
    });
  }
  //--------------------------------------------------

  void selectionFile(context) async {
    setState(() {
      loadingFile = true;
    });

    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true).then((result) {
      if (result != null) {
        setState(() {
          files = result.files.map((file) => File(file.path)).toList();
          file = File(files!.first.path);
          // var file_ = ;
          loadingFile = false;
        });
        printWarning(file);
      } else {
        printWarning('no file uploaded');
      }
    }).onError((error, stackTrace) {
      showSnackBar(context, 'errore file non caricato',
          backgroundColor: Colors.red);
      setState(() {
        file = null;
        loadingFile = false;
      });
    });
  }
  //--------------------------------------------------

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
    Widget? _labelNameFileWidget;

    bool sendFileState = false;

    //set name file

    if (file == null) {
      _labelNameFileWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('nessun file selezionato'),
      );
    } else {
      //String _nameFile = basename(file!.path);

      _labelNameFileWidget = Wrap(children: [
        for (int i = 0; i < files!.length; i += 1) ...[
          Chip(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            deleteIconColor: loadingFile ? Colors.red : Colors.black,
            label: Container(
              constraints: new BoxConstraints(maxWidth: 150.0),
              child: Text(
                basename(files![i].path),
                maxLines: 1,
              ),
            ),
            onDeleted: () => setState(() {
              if (loadingFile == false) {
                files!.removeAt(i);
                //file = null;
              }
            }),
          ),
        ]
      ]);

      sendFileState = true;
    }

    //end set name file

    return WillPopScope(
      onWillPop: () async {
        if (file != null) {
          if (loadingFile == false) {
            setState(() {
              file = null;
            });
          }

          return false;
        }

        Navigator.of(context).pushNamed('/');

        return false;
      },
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
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _labelNameFileWidget,
                  ),
                  file == null
                      ? Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              selectionFile(context);
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: MyColors.secondary,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              sendFileState
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: !loadingFile
                            ? MyColors.secondary
                            : MyColors.secondary.withOpacity(0.5),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        if (!loadingFile) {
                          sendFileChopper(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: !loadingFile
                            ? Text(
                                'Send file',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Send file',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.black),
                                  ),
                                  Center(
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
