import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile2/home/data/data_source/local/name_hive_db.dart';
import 'package:mobile2/home/repository/name_repository.dart';

final locator = GetIt.instance;

void startLocator() {
  locator.registerSingleton<HiveInterface>(Hive);
  locator<HiveInterface>().initFlutter();

  locator.registerSingleton(NameHiveDB(locator<HiveInterface>()));

  locator.registerSingleton(NameRepository(locator<NameHiveDB>()));
}
