
import 'package:get_it/get_it.dart';
import 'package:nic_demo/services/global_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  GetIt.I.registerSingleton(GlobalService());
}
