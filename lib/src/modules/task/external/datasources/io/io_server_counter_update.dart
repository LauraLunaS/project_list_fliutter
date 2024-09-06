import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/socket/socket_cliente.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/io_counter_datasource.dart';

class IoCounterDatasource implements ICounterDatasource {
  final SocketClient io;

  IoCounterDatasource(this.io);

  @override
  Future<void> requestCounterUpdate(String userId, Function function, Function functionAdapter) async {
    try {
      io.sendMessage('update_request', userId);

      io.receiveAdapterMessage('update_response', functionAdapter, function);
    } catch (e) {
      throw ExternalError('Erro ao solicitar atualização de contagem: $e');
    }
  }
}
