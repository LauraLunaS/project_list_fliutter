import 'dart:async';
import 'dart:typed_data';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/socket/socket_cliente.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/save_task_datasource.dart';

class PostAddTasksDatasource implements ISaveTaskDatasource {
  final SocketClient io;

  PostAddTasksDatasource(this.io);

  @override
  Future<bool?> saveTask(Uint8List taskEncoded) async {
    try {
      io.sendMessage('add_task', taskEncoded);

      final completer = Completer<bool>();

      io.receiveSimpleMessage('task_added_response', (data) {
        if (data == 'success') {
          completer.complete(true);
        } else {
          completer.complete(false);
        }
      });

      return completer.future;
    } catch (e) {
      throw ExternalError('Falha ao adicionar tarefa via WebSocket: $e');
    }
  }
}
