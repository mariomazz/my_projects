import 'package:AddFile/constants/constants.dart';
import 'package:AddFile/models/my%20file/my_file.dart';
import 'package:AddFile/services/apiservice/apiservice.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AllFilesScreen extends StatefulWidget {
  const AllFilesScreen({Key? key}) : super(key: key);

  @override
  _AllFilesScreenState createState() => _AllFilesScreenState();
}

class _AllFilesScreenState extends State<AllFilesScreen> {
  Future<Response>? requestFiles;

  List<MyFile>? files = [];

  List<double> widthChips = [];

  Future refreshFiles() async {
    setState(() {
      requestFiles = updateAndGetFiles();
    });
  }

  Future<Response> updateAndGetFiles() async {
    return await Provider.of<ApiService>(context, listen: false).allFiles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    requestFiles = updateAndGetFiles();

    super.initState();
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
          future: Provider.of<ApiService>(context).allFiles(),
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
              return Wrap(children: [
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
                          onDeleted: () {},
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            if (widthChips[i] == 300.0) {
                              widthChips[i] = 75.0;
                            } else {
                              widthChips[i] = 300.0;
                            }
                          }),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              widthChips[i] == 300.0
                                  ? FontAwesomeIcons.minus
                                  : FontAwesomeIcons.plus,
                              size: 18,
                              color: widthChips[i] == 300.0
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.green.withOpacity(0.5),
                            ),
                          ),
                        ),
                        widthChips[i] == 300.0
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(
                                  FontAwesomeIcons.fileDownload,
                                  size: 18,
                                  color: Colors.green.withOpacity(0.5),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ]
              ]);
            } else {
              return Center(
                child: Text('files.toString()'),
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
