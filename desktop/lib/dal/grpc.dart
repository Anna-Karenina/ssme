import 'dart:async';

import 'package:desktop/pb/api.pbgrpc.dart';
import 'package:grpc/grpc.dart';

const host = 'localhost';
const port = 44044;

class GrpcClient {
  late ClientChannel _channel;
  EnvironmentClient? envClient;
  AppsClient? appsClient;
  late Stream<ConnectionState> stream;

  connectgRpc() {
    _channel = ClientChannel(host,
        port: port,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));

    envClient = EnvironmentClient(_channel);
    appsClient = AppsClient(_channel);

    stream = _channel.onConnectionStateChanged;
  }
}
