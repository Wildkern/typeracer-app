import 'package:socket_io_client/socket_io_client.dart' as po;

class SocketClient {
  po.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket =
        po.io('https://typeracer-server-w1q1.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
