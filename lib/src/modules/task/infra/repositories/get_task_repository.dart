import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/get_task_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/get_all_tasks_datasource.dart';

class GetTaskRepositoryImpl implements IGetTaskRepository {
  final IGetAllTasksDatasource datasource;

  GetTaskRepositoryImpl(this.datasource);

  @override
  Future<List<Task>> getTasks(String userId) async {
    try {
      final tasks = await datasource.getAllTasks(userId);
      return tasks.isNotEmpty ? tasks : <Task>[];
    } catch (e) {
      throw GetTaskError('Failed to fetch tasks: ${e.toString()}');
    }
  }
}
