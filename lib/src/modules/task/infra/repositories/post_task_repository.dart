import 'package:project_list_fliutter/src/modules/task/domain/repositories/post_task_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/adapters/task_adapter.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/save_task_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

class PostTaskRepositoryImpl implements IPostTaskRepository {
  final ISaveTaskDatasource datasource;

  PostTaskRepositoryImpl(this.datasource);

  @override
  Future<(bool?, CreateTaskError?)> addTask(Task task, String userId) async {
    try {
      final taskEncoded = TaskAdapter.encodeProto(task, userId);
      final (res, erro) = await datasource.saveTask(taskEncoded);
      print('$res, $erro');
      if (res == true) {
        return (true, null);
      } else {
        return (null, const CreateTaskError('Error saving task'));
      }
    } catch (e) {
      
      return (null, CreateTaskError('Failed to add task: ${e.toString()}'));
    }
  }
}
