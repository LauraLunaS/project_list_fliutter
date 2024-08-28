import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/get_task_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

class GetTaskUseCase {
  final IGetTaskRepository repository;

  GetTaskUseCase(this.repository);

  Future<List<Task>> getTasks(String userId) async {
    try {
      return await repository.getTasks(userId);
    } on ExternalError catch (e) {
      throw GetTaskError('Failed to get tasks: ${e.message}', e.stackTrace);
    } catch (e, stackTrace) {
      throw TasksError('Unexpected error', stackTrace);
    }
  }
}