import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

abstract class IGetAllTasksDatasource {
  Future<List<Task>> getAllTasks(String userId);
}
