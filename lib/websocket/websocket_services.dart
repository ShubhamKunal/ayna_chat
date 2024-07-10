import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('wss://websocket.org/tools/websocket-echo-server'),
  );

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  Stream<String> get messages =>
      channel.stream.map((event) => event.toString());
}
