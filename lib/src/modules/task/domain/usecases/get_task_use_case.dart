import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/get_task_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

abstract class IGetTaskUseCase {
  Future<List<Task?>> getTasks(String userId);
}

class GetTaskUseCase implements IGetTaskUseCase {
  final IGetTaskRepository repository;

  GetTaskUseCase(this.repository);

  @override
  Future<List<Task?>> getTasks(String userId) async {
    try {
      return await repository.getTasks(userId);
    } on DomainError catch (e) {
      throw DomainError('Failed to get tasks: ${e.message}', e.stackTrace);
    } catch (e, stackTrace) {
      throw TasksError('Unexpected error', stackTrace);
    }
  }
}