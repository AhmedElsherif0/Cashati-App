import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// SingleTon Data Class.
class HiveHelper {
  HiveHelper._privateConstructor();

  static final HiveHelper _hiveHelper = HiveHelper._privateConstructor();

  factory HiveHelper() => _hiveHelper;

  Future<Box<E>> openBox<E>({required String boxName}) async =>
      await Hive.openBox<E>(boxName);

  Box<T> getBoxName<T>({required String boxName}) => Hive.box<T>(boxName);

  List<T> getBoxData<T>({required Box<T> boxName}) => boxName.values.toList();

  Future<int> addToBox<T>({required Box boxName, required T dataModel}) async {
    _requireInitialized(boxName);
    return await boxName.add(dataModel);
  }

  Future<void> putByIndexKey<E>(
      {required Box<E> boxName,
      required int indexKey,
      required E dataModel}) async {
    return await boxName.put(indexKey, dataModel);
  }

  /// for updates the value.
  Future<void> update<T>(
      {required Box boxName,
      required int indexKey,
      required T dataModel}) async {
    _requireInitialized(boxName);
    await boxName.putAt(indexKey, dataModel);
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
