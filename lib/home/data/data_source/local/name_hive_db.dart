
import 'package:hive/hive.dart';

import '../../models/name_model_db/name_model.dart';




class NameHiveDB {
  HiveInterface hive;
 NameHiveDB(this.hive) {
    hive.registerAdapter(NameModelAdapter());
  }

  /// get all name
  Future<List<NameModel>> get() async {
    final Box box = await _openBox("nameBox");
    /// TODO : Print(box.values.runtimeType.toString());
    return box.values.cast<NameModel>().toList();
  }

  /// add a name
  Future<int> add(final NameModel value) async {
    final Box box = await _openBox("nameBox");

    return await box.add(value);
  }

  /// delete a name
  Future<void> delete(int index) async {
    final Box box = await _openBox("nameBox");

    box.deleteAt(index);
  }




  Future<Box> _openBox(String type) async {
    final box = await hive.openBox(type);
    return box;
  }
}
