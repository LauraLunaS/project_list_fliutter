import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/io_counter_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/io_counter_datasource.dart';

class GetCounterTaskRepositoryImpl implements ICounterServerRepository {
  final ICounterDatasource _counterTaskDatasource;
  
  GetCounterTaskRepositoryImpl(this._counterTaskDatasource);

  @override
  void responseCounterUpdate(Function function) {
    try {
      _counterTaskDatasource.responseCounterUpdate(
        function
      );
    } catch (e) {
      throw InfraError('Não foi possível obter a contagem de tasks: $e');
    }
  }
  
  @override
  void requestCounterUpdate(String userId) {
    _counterTaskDatasource.requestCounterUpdate2(userId);
  }
}
