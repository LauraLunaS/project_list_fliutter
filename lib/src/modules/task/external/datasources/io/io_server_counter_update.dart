import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/socket/socket_cliente.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/io_counter_datasource.dart';

class IoCounterDatasourceExternal implements ICounterDatasource {
  final SocketClient io;

  IoCounterDatasourceExternal(this.io);

  @override
  Future<void> responseCounterUpdate(Function function) async {
    try {

      io.receiveAdapterMessage('update_response', function);
    } catch (e) {
      throw ExternalError('Erro ao solicitar contagem: $e');
    }
  }
  
  @override
  void requestCounterUpdate(String userId) {
     try {
      io.sendMessage('update_request', userId);
    } catch (e) {
      throw ExternalError('Erro ao solicitar atualização de contagem: $e');
    }
  }
}
