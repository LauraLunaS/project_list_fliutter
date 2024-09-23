import 'dart:typed_data';

import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';

abstract class ISaveTaskDatasource {
  Future<(bool?, CreateTaskError?)> saveTask(Uint8List task);
}
