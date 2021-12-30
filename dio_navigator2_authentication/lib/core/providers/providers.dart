import 'package:dio_navigator2_authentication/core/networking_service/api/api_service.dart';
import 'package:dio_navigator2_authentication/core/routing/provider/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyProviders {
  final List<SingleChildWidget> providers = [
    ListenableProvider<NavigatorProvider>(
      create: (context) => NavigatorProvider(),
      dispose: (context, provider) => provider.dispose(),
    ),
    Provider<ApiService>(
      create: (context) => ApiService(),
      dispose: (context, apiService) {},
    ),
  ];

  List<SingleChildWidget> get getProviders => providers;
}
