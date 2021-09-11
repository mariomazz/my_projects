import 'package:AddFile/constants/constants.dart';
import 'package:AddFile/services/apiservice/apiservice.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllFilesScreen extends StatelessWidget {
  const AllFilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.primary,
        automaticallyImplyLeading: false,
        title: Text(
          'repository file',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<Response>(
          future: Provider.of<ApiService>(context).allFiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('errore server'));
            }
            final String dataRequest = snapshot.data!.bodyString;
            return Center(
              child: Text('$dataRequest'),
            );
          }),
    );
  }
}
