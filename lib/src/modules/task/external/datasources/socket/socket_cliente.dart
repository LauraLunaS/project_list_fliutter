import 'package:project_list_fliutter/src/modules/task/external/datasources/server_routes.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  final Socket socket = io(serverAdrees, {
    'transports': ['websocket'],
    'autoConnect': false,
    'namespace': '/counter',
  });

  SocketClient() {
    socket.connect();
  }

  bool socketConnect() {
    return socket.connected;
  }

  void sendMessage(String event, dynamic message) {
    socket.emit(event, message);
  }

  void receiveSimpleMessage(
    String event, Function function
  ) {
    socket.on(event, (data) => function (data));
  }

  void receiveAdapterMessage(
    String event, Function funcionAdapter, Function function
  ) {
    socket.on(event, (data) {
      final dataAdapter = funcionAdapter(data);
      function(dataAdapter);
    });
  }

  void onSocketDisconnect(Function function) {
    socket.onDisconnect((data) => function(data));
  }

  void onSocketConnect(Function function) {
    socket.onConnect((data) => function(data));
  }

  void onSocketConnectError(Function function) {
    socket.onConnectError((data) => function(data));
  }

  void onSocketError(Function function) {
    socket.onError((data) => function(data));
  }

  void onSocketReconnect(Function function) {
    socket.onReconnect((data) => function(data));
  }

  void disconnect() {
    socket.disconnect();
  }

  void dispose() {
    socket.dispose();
  }


}