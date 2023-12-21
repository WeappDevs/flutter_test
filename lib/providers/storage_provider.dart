import 'package:get_storage/get_storage.dart';

class StorageProvider {
  StorageProvider._();

  static StorageProvider instance = StorageProvider._();

  final GetStorage _getStorage = GetStorage();

  Future<void> writeStorage({required String key, dynamic value}) async {
    await _getStorage.write(key, value);
  }

  dynamic readStorage({required String key}) {
    return _getStorage.read(key);
  }

  Future<void> removeStorage({required String key}) async {
    await _getStorage.remove(key);
  }

  eraseStorage() async {
    await _getStorage.erase();
  }
}
