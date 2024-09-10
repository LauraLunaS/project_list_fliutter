import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/io_counter_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/io_counter_datasource.dart';

abstract class IIoCounterUsecase{
  void requestCounterUpdate2(String userId);
  void responseCounterUpdate(Function function);
}

class IoCounterUsecase implements IIoCounterUsecase{
  final ICounterServerRepository _repository;

  IoCounterUsecase(this._repository);

  @override
  void requestCounterUpdate2(String userId) {
    _repository.requestCounterUpdate2(userId);
  }
  
  @override
  void responseCounterUpdate(Function function) {
    try {
      _repository.responseCounterUpdate(
        function
      );
    } catch (e) {
      throw InfraError('Não foi possível obter a contagem de tasks: $e');
    }
  }
  }


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
  void requestCounterUpdate2(String userId) {
    // TODO: implement requestCounterUpdate2
  }
 
}

