import 'package:project_list_fliutter/src/modules/task/external/datasources/server_routes.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  final Socket socket = io('$serverAdrees/counter', {
    'transports': ['websocket'],
    'autoConnect': false,
    
  });

  SocketClient() {
    socket.connect();
  }

  bool socketConnect() {
    return socket.connected;
  }

  void sendMessage(String event, dynamic message) {
    try {
      socket.emit(event, message);
      print("Mensagem enviada: $event -> $message");
    } catch (e) {
      print("Erro ao enviar mensagem: $e");
    }
  }

  void receiveAdapterMessage(
      String event, Function functionAdapter, Function function) {
    socket.on(event, (data) {
      final dataAdapter = functionAdapter(data);
      function(dataAdapter);
    });
  }

  void onSocketDisconnect(Function(dynamic) function) {
    socket.onDisconnect((data) => function(data));
  }

  void onSocketConnect(Function(dynamic)function) {
    socket.onConnect((data) => function(data));
  }

  void onSocketError(Function(dynamic) function) {
    socket.onError((data) => function(data));
  }

  void onSocketReconnect(Function(dynamic) function) {
    socket.onReconnect((data) => function(data));
  }

  void disconnect() {
    socket.disconnect();
  }

  void dispose() {
    socket.dispose();
  }
}
