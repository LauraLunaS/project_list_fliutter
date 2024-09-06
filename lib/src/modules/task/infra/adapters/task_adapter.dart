import 'dart:typed_data';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';

class TaskAdapter {
  static Task decodeProto(Uint8List encodedUserProto) {
    try {
      final taskProto = Task.fromBuffer(encodedUserProto); 
      return Task(
        id: taskProto.id,
        task: taskProto.task,
        userId: taskProto.userId,
      );
    } catch (e) {
      throw InfraError('Failed to decode Task proto: $e');
    }
  }

  static Uint8List encodeProto(Task taskModel, String userId) {
    try {
      final taskProto = Task()
        ..id = taskModel.id
        ..task = taskModel.task
        ..userId = userId;
      return taskProto.writeToBuffer();
    } catch (e) {
      throw InfraError('Failed to encode Task proto: $e');
    }
  }
}
