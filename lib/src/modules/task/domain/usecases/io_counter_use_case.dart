import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/io_counter_repository.dart';

abstract class IIoCounterUsecase{
  void requestCounterUpdate(String userId);
  void responseCounterUpdate(Function function);
}

class IoCounterUsecase implements IIoCounterUsecase{
  final ICounterServerRepository _repository;

  IoCounterUsecase(this._repository);

  @override
  void requestCounterUpdate(String userId) {
    _repository.requestCounterUpdate(userId);
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


