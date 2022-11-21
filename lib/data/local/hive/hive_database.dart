import 'package:hive/hive.dart';

/// SingleTon Data Class.
class HiveHelper {
  HiveHelper._privateConstructor();

  static final HiveHelper _hiveHelper = HiveHelper._privateConstructor();

  factory HiveHelper() => _hiveHelper;

  Future<Box<E>> openBox<E>({required String boxName}) async =>
      await Hive.openBox<E>(boxName);

  Box<T> getBox<T>({required String boxName}) => Hive.box<T>(boxName);

  List<Box> getBoxList({required Box boxName}) =>
      boxName.values.toList().cast();

  Future<int> addBox<T>({required Box boxName}) async {
    _requireInitialized(boxName);
    return await boxName.add('$boxName');
  }

  Future<void> save<T>(
      {required Box boxName, required dynamic dataModel}) async {
    _requireInitialized(boxName);
    await boxName.put(dataModel.id, dataModel);
  }

  Future<void> deleteBox(
      {required Box boxName, required dynamic dataModel}) async {
    _requireInitialized(boxName);
    await boxName.delete(dataModel.id);
  }

  Future<void> clearBoxes({required Box boxName}) async =>
      await boxName.clear();

  void _requireInitialized(Box boxName) {
    if (boxName.isEmpty) {
      throw HiveError('This object is currently not in a box.');
    }
  }
}
