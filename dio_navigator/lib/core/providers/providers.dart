import 'package:project_model/core/connectivity/provider/connectivity_status_provider.dart';
import 'package:project_model/core/networking_service/api/portici_api/provider/api_service.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentiation/portici_authentication_provider.dart';
import 'package:project_model/core/routing/provider/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

PorticiAutenticationProvider porticiAuthProvider =
    PorticiAutenticationProvider();
ApiServiceProvider apiServiceProvider = ApiServiceProvider();

class MyProviders {
  final List<SingleChildWidget> _providers = [
    ListenableProvider<NavigatorProvider>(
      create: (context) => NavigatorProvider(),
      dispose: (context, provider) => provider.dispose(),
    ),
    ListenableProvider<ConnectivityStatusProvider>(
      create: (context) => ConnectivityStatusProvider(),
      dispose: (context, provider) => provider.dispose(),
    ),
    ListenableProvider<PorticiAutenticationProvider>(
      create: (context) => porticiAuthProvider,
      dispose: (context, provider) => provider.dispose(),
    ),
    Provider<ApiServiceProvider>(
      create: (context) => apiServiceProvider,
      dispose: (context, apiService) {},
    ),
  ];

  List<SingleChildWidget> get getProviders => _providers;
}
