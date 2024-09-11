import 'dart:typed_data';

abstract class ISaveTaskDatasource {
  Future<bool?> saveTask(Uint8List task);
}
