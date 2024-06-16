import 'package:desktop/dal/grpc.dart';
import 'package:get_it/get_it.dart';

class DiManager {
  static GetIt getIt = GetIt.instance;

  static void initDi() {
    getIt.registerSingleton<GrpcClient>(GrpcClient());
  }

  static GrpcClient getgRpc() => getIt.get<GrpcClient>();
}
