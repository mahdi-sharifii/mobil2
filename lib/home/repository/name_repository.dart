import 'package:mobile2/home/data/models/name_model_db/name_model.dart';
import '../../resources/data_state.dart';
import '../data/data_source/local/name_hive_db.dart';

class NameRepository {
  final NameHiveDB nameHiveDB;

  NameRepository(this.nameHiveDB);

  /// Get all Name
  Future<DataState<List<NameModel>>> getAllNameDB() async {
    try {
      final List<NameModel> items = await nameHiveDB.get();

      return DataSuccess<List<NameModel>>(items);
    } catch (e) {
      return DataFailed<List<NameModel>>(e.toString());
    }
  }

  /// add Name
  Future<DataState<int>> addName(NameModel value) async {
    try {
      return DataSuccess<int>(await nameHiveDB.add(value));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  /// delete name
  Future<DataState<int>> delete(int index) async {
    try {
      await nameHiveDB.delete(index);
      return DataSuccess(index);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
