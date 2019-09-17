import 'package:provider/provider.dart';
import 'package:smart_home_final/core/model/user.dart';
import 'package:smart_home_final/core/services/api.dart';
import 'package:smart_home_final/core/services/authentication_service.dart';

List<SingleChildCloneableWidget> providers =
[
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api())
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
 StreamProvider<User>(
    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
  )
];