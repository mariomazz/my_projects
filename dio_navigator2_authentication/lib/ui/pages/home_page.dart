import 'package:dio_navigator2_authentication/core/networking_service/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const ValueKey keyPage = ValueKey('home_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME PAGE'),
        elevation: 0,
      ),
      body: FutureBuilder<dynamic>(
        future: Provider.of<ApiService>(context).apiPortici.getTransaction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Text(snapshot.data ?? ''),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Errore'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
