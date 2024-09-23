import 'dart:typed_data';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';

class TaskAdapter {
  static Task? decodeProto(Uint8List? encodedUserProto) {
    try {
      if (encodedUserProto != null) {
        return Task.fromBuffer(encodedUserProto);
      }
      return null;
    } catch (e) {
      throw const InfraError('Failed to decode Task proto');
    }
  }

  static Uint8List encodeProto(Task taskModel, String userId) {
    try {
      return taskModel.writeToBuffer();
    } catch (e) {
      throw const InfraError('Failed to encode Task proto');
    }
  }
}
