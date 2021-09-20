import 'dart:isolate';
import 'dart:ui';
import 'package:AddFile/constants/constants.dart';
import 'package:AddFile/main.dart';
import 'package:AddFile/models/my%20file/my_file.dart';
import 'package:AddFile/services/apiservice/apiservice.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AllFilesScreen extends StatefulWidget {
  const AllFilesScreen({Key? key}) : super(key: key);

  @override
  _AllFilesScreenState createState() => _AllFilesScreenState();
}

class _AllFilesScreenState extends State<AllFilesScreen> {
  String? progress;

  String? fileName;

  Future<Response<List<MyFile>>>? requestFiles;

  List<MyFile>? files = [];

  List<double> widthChips = [];
  double maxWidthChips = 240.0;

  void deleteFile(
    String nameFile,
    int index,
  ) async {
    var response = await Provider.of<ApiService>(context, listen: false)
        .deleteFile({'key': nameFile});
    if (response.bodyString == 'success') {
      showSnackBar(context, 'file cancellato');
    } else if (response.bodyString == 'error') {
      showSnackBar(context, 'file non cancellato', backgroundColor: Colors.red);
    }

    await refreshFiles();
  }

  // download file

  void downloadFile(String nameFile) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final baseStorage =
          await getExternalStorageDirectories(type: StorageDirectory.documents);
      await FlutterDownloader.enqueue(
        url: 'http://192.168.1.28:3000/file/' + nameFile,
        savedDir: baseStorage![0].path,
        fileName: nameFile,
      );
    } else {
      printWarning('no permission');
    }
  }

  static downloadCalllback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName('downloadfile');
    sendPort!.send(progress);
  }

  //end download file

  Future refreshFiles() async {
    setState(() {
      requestFiles = updateAndGetFiles();
    });
  }

  Future<Response<List<MyFile>>> updateAndGetFiles() async {
    return await Provider.of<ApiService>(context, listen: false).allFiles();
  }

  int fileprogress = 0;
  ReceivePort recievePort = new ReceivePort();

  @override
  void initState() {
    requestFiles = updateAndGetFiles();

    //download file

    IsolateNameServer.registerPortWithName(
        recievePort.sendPort, 'downloadfile');

    recievePort.listen(
      (message) => setState(() {
        progress = message;
      }),
    );

    FlutterDownloader.registerCallback(downloadCalllback);

    //end download file

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.primary,
        automaticallyImplyLeading: true,
        title: Text(
          'repository file',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              splashRadius: 25,
              splashColor: Colors.black.withOpacity(0.5),
              icon: Icon(
                FontAwesomeIcons.retweet,
                color: Colors.black,
              ),
              onPressed: () => refreshFiles(),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Response<List<MyFile>>>(
          future: requestFiles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: MyColors.secondary));
            } else if (snapshot.hasError) {
              return Center(child: Text('errore server + ${snapshot.error}'));
            }

            files = snapshot.data!.body;

            for (int i = 0; i < files!.length; i += 1) {
              widthChips..add(75.0);
            }

            if (files!.isNotEmpty) {
              return ListView(children: [
                Wrap(children: [
                  for (int i = 0; i < files!.length; i += 1) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            deleteIcon: Icon(
                              FontAwesomeIcons.trash,
                              size: 15,
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            label: Container(
                              constraints:
                                  BoxConstraints(maxWidth: widthChips[i]),
                              child: Text(
                                files![i].name,
                                maxLines: 1,
                              ),
                            ),
                            onDeleted: () => deleteFile(files![i].name, i),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              if (widthChips[i] == maxWidthChips) {
                                widthChips[i] = 75.0;
                              } else {
                                widthChips[i] = maxWidthChips;
                              }
                            }),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                widthChips[i] == maxWidthChips
                                    ? FontAwesomeIcons.minus
                                    : FontAwesomeIcons.plus,
                                size: 18,
                                color: widthChips[i] == maxWidthChips
                                    ? Colors.red.withOpacity(0.5)
                                    : Colors.green.withOpacity(0.5),
                              ),
                            ),
                          ),
                          widthChips[i] == maxWidthChips
                              ? GestureDetector(
                                  onTap: () => downloadFile(files![i].name),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Icon(
                                      FontAwesomeIcons.fileDownload,
                                      size: 18,
                                      color: Colors.green.withOpacity(0.5),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ]
                ]),
              ]);
            } else {
              return Center(
                child: Text('nessun file presente - aggiungilo'),
              );
            }
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
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
        ),
      ),
    );
  }
}
