import 'package:flutter/material.dart';
import 'package:project_model/core/networking_service/api/portici_api/provider/api_service.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentiation/portici_authentication_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const ValueKey keyPage = ValueKey('home_page');

  @override
  Widget build(BuildContext context) {
    return Selector<PorticiAutenticationProvider, bool>(
      selector: (context, provider) => provider.getIsLogged,
      builder: (context, isLogged, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'HOME PAGE',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: isLogged ? Colors.yellow : Colors.red,
            actions: [
              IconButton(
                onPressed: () => Provider.of<PorticiAutenticationProvider>(
                        context,
                        listen: false)
                    .authenticationStatusChange(),
                icon: Icon(
                  isLogged ? Icons.logout : Icons.login,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: FutureBuilder<dynamic>(
            future: Provider.of<ApiServiceProvider>(context, listen: false)
                .getApiPortici
                .getTransaction(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Text(snapshot.data.toString()),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Errore'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
