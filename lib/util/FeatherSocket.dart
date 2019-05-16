import 'package:socket_io_client/socket_io_client.dart';

typedef FeathersResponse(Map error, [ Map data ]);
class FeatherSocket {

    Socket _socket;

    void connect(String host, Function cb) {
        _socket = io(host, {
            'forceNew': true,
            'transports': [ 'websocket' ]
        });

        _socket.on('connect', (_) {
            cb();
        });
    }

    bool isConnected() {
        return _socket.connected;
    }

    void emit(String action, List params, FeathersResponse ackResponse) {
        _socket.emitWithAck(action, params, ack: ackResponse);
    }

    void auth(String strategy, Map body, FeathersResponse ackResponse) {
        _socket.emitWithAck('authenticate', {
            'strategy': strategy, 

            ...body
        }, ack: ackResponse);
    }
}
