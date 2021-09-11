import 'dart:convert';

import 'package:AddFile/constants/constants.dart';
import 'package:AddFile/main.dart';
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
  Future<Response<List<String>>>? requestFiles;

  List<double> widthChips = [];

  Future refreshFiles() async {
    setState(() {
      requestFiles = updateAndGetFiles();
    });
  }

  Future<Response<List<String>>> updateAndGetFiles() async {
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
      ),
      body: FutureBuilder<Response<List<String>>>(
          future: Provider.of<ApiService>(context).allFiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: MyColors.secondary));
            } else if (snapshot.hasError) {
              return Center(child: Text('errore server'));
            }
            final List<String> files =
                List.from(json.decode(snapshot.data!.bodyString));
            for (int i = 0; i < files.length; i += 1) {
              widthChips..add(75.0);
            }

            return Wrap(children: [
              for (int i = 0; i < files.length; i += 1) ...[
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
                          constraints: BoxConstraints(maxWidth: widthChips[i]),
                          child: Text(
                            files[i],
                            maxLines: 1,
                          ),
                        ),
                        onDeleted: () {},
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          if (widthChips[i] == 320.0) {
                            widthChips[i] = 75.0;
                          } else {
                            widthChips[i] = 320.0;
                          }
                        }),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            widthChips[i] == 320.0
                                ? FontAwesomeIcons.minus
                                : FontAwesomeIcons.plus,
                            size: 18,
                            color: widthChips[i] == 320.0
                                ? Colors.red.withOpacity(0.5)
                                : Colors.green.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ]);
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
          onPressed: () => refreshFiles(),
          child: Icon(
            FontAwesomeIcons.retweet,
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
