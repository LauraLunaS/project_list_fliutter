import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/io_counter_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/io_counter_datasource.dart';

class GetCounterTaskUseCase implements ICounterServerRepository {
  final ICounterDatasource _counterTaskDatasource;

  GetCounterTaskUseCase(this._counterTaskDatasource);

  @override
  void requestCounterUpdate(String userId, Function functionFromUseCase, Function functionAdapter) {
    try {
      _counterTaskDatasource.requestCounterUpdate(
        userId, 
        functionFromUseCase, 
        functionAdapter,
      );
    } catch (e) {
      throw InfraError('Não foi possível solicitar a atualização da contagem: $e');
    }
  }

  @override
  void responseCounterUpdate(Function function, Function functionAdapter) {
    try {
      _counterTaskDatasource.responseCounterUpdate(
        function, 
        functionAdapter,
      );
    } catch (e) {
      throw InfraError('Não foi possível obter a contagem de tasks: $e');
    }
  }
}

