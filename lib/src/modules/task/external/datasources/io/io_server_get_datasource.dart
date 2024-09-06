import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/socket/socket_cliente.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/io_server_datasource.dart';

class IoServerDatasource implements IIoServerDatasource {
  final SocketClient io;

  IoServerDatasource(this.io);

  @override
  void listeningIdentifyServerOutEvent(Function function) async {
    try {
      io.onSocketDisconnect(function);
    } catch (_) {
      throw const ExternalError('Não foi possível escutar os eventos do servidor!');
    }
  }

  @override
  void listeningProblemEvent(Function function, Function functionAdapter) async {
    try {
      io.receiveAdapterMessage('problem-event', functionAdapter, function);
    } catch (e) {
      throw const ExternalError('Não foi possível escutar os eventos de problema!');
    }
  }

  @override
  void listeningServiceState(Function function, Function functionAdapter) async {
    try {
      io.receiveAdapterMessage('update-services-state', functionAdapter, function);
    } catch (e) {
      throw const ExternalError('Não foi possível escutar os serviços do servidor!');
    }
  }
}