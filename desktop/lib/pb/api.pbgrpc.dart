//
//  Generated code. Do not modify.
//  source: api.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'api.pb.dart' as $0;

export 'api.pb.dart';

@$pb.GrpcServiceName('api.Apps')
class AppsClient extends $grpc.Client {
  static final _$createApp = $grpc.ClientMethod<$0.CreateAppPayload, $0.App>(
      '/api.Apps/CreateApp',
      ($0.CreateAppPayload value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.App.fromBuffer(value));
  static final _$readApp = $grpc.ClientMethod<$0.AppIdPayload, $0.App>(
      '/api.Apps/ReadApp',
      ($0.AppIdPayload value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.App.fromBuffer(value));
  static final _$updateApp = $grpc.ClientMethod<$0.CreateAppPayload, $0.App>(
      '/api.Apps/UpdateApp',
      ($0.CreateAppPayload value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.App.fromBuffer(value));
  static final _$removeApp = $grpc.ClientMethod<$0.AppIdPayload, $0.AppIdPayload>(
      '/api.Apps/RemoveApp',
      ($0.AppIdPayload value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AppIdPayload.fromBuffer(value));
  static final _$readAllApps = $grpc.ClientMethod<$0.EmptyParams, $0.AppList>(
      '/api.Apps/ReadAllApps',
      ($0.EmptyParams value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AppList.fromBuffer(value));
  static final _$runApp = $grpc.ClientMethod<$0.RunAppRequest, $0.AppRunTime>(
      '/api.Apps/RunApp',
      ($0.RunAppRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AppRunTime.fromBuffer(value));
  static final _$stopApp = $grpc.ClientMethod<$0.StopAppRequest, $0.AppRunTime>(
      '/api.Apps/StopApp',
      ($0.StopAppRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AppRunTime.fromBuffer(value));
  static final _$syncAppScripts = $grpc.ClientMethod<$0.AppIdPayload, $0.App>(
      '/api.Apps/SyncAppScripts',
      ($0.AppIdPayload value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.App.fromBuffer(value));
  static final _$updateDefaultRunScript = $grpc.ClientMethod<$0.UpdateDefaultRunScriptParams, $0.App>(
      '/api.Apps/UpdateDefaultRunScript',
      ($0.UpdateDefaultRunScriptParams value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.App.fromBuffer(value));

  AppsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.App> createApp($0.CreateAppPayload request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createApp, request, options: options);
  }

  $grpc.ResponseFuture<$0.App> readApp($0.AppIdPayload request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readApp, request, options: options);
  }

  $grpc.ResponseFuture<$0.App> updateApp($0.CreateAppPayload request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateApp, request, options: options);
  }

  $grpc.ResponseFuture<$0.AppIdPayload> removeApp($0.AppIdPayload request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeApp, request, options: options);
  }

  $grpc.ResponseFuture<$0.AppList> readAllApps($0.EmptyParams request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readAllApps, request, options: options);
  }

  $grpc.ResponseFuture<$0.AppRunTime> runApp($0.RunAppRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$runApp, request, options: options);
  }

  $grpc.ResponseFuture<$0.AppRunTime> stopApp($0.StopAppRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stopApp, request, options: options);
  }

  $grpc.ResponseFuture<$0.App> syncAppScripts($0.AppIdPayload request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncAppScripts, request, options: options);
  }

  $grpc.ResponseFuture<$0.App> updateDefaultRunScript($0.UpdateDefaultRunScriptParams request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDefaultRunScript, request, options: options);
  }
}

@$pb.GrpcServiceName('api.Apps')
abstract class AppsServiceBase extends $grpc.Service {
  $core.String get $name => 'api.Apps';

  AppsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateAppPayload, $0.App>(
        'CreateApp',
        createApp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateAppPayload.fromBuffer(value),
        ($0.App value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AppIdPayload, $0.App>(
        'ReadApp',
        readApp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AppIdPayload.fromBuffer(value),
        ($0.App value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateAppPayload, $0.App>(
        'UpdateApp',
        updateApp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateAppPayload.fromBuffer(value),
        ($0.App value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AppIdPayload, $0.AppIdPayload>(
        'RemoveApp',
        removeApp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AppIdPayload.fromBuffer(value),
        ($0.AppIdPayload value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EmptyParams, $0.AppList>(
        'ReadAllApps',
        readAllApps_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EmptyParams.fromBuffer(value),
        ($0.AppList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RunAppRequest, $0.AppRunTime>(
        'RunApp',
        runApp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RunAppRequest.fromBuffer(value),
        ($0.AppRunTime value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StopAppRequest, $0.AppRunTime>(
        'StopApp',
        stopApp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StopAppRequest.fromBuffer(value),
        ($0.AppRunTime value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AppIdPayload, $0.App>(
        'SyncAppScripts',
        syncAppScripts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AppIdPayload.fromBuffer(value),
        ($0.App value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateDefaultRunScriptParams, $0.App>(
        'UpdateDefaultRunScript',
        updateDefaultRunScript_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateDefaultRunScriptParams.fromBuffer(value),
        ($0.App value) => value.writeToBuffer()));
  }

  $async.Future<$0.App> createApp_Pre($grpc.ServiceCall call, $async.Future<$0.CreateAppPayload> request) async {
    return createApp(call, await request);
  }

  $async.Future<$0.App> readApp_Pre($grpc.ServiceCall call, $async.Future<$0.AppIdPayload> request) async {
    return readApp(call, await request);
  }

  $async.Future<$0.App> updateApp_Pre($grpc.ServiceCall call, $async.Future<$0.CreateAppPayload> request) async {
    return updateApp(call, await request);
  }

  $async.Future<$0.AppIdPayload> removeApp_Pre($grpc.ServiceCall call, $async.Future<$0.AppIdPayload> request) async {
    return removeApp(call, await request);
  }

  $async.Future<$0.AppList> readAllApps_Pre($grpc.ServiceCall call, $async.Future<$0.EmptyParams> request) async {
    return readAllApps(call, await request);
  }

  $async.Future<$0.AppRunTime> runApp_Pre($grpc.ServiceCall call, $async.Future<$0.RunAppRequest> request) async {
    return runApp(call, await request);
  }

  $async.Future<$0.AppRunTime> stopApp_Pre($grpc.ServiceCall call, $async.Future<$0.StopAppRequest> request) async {
    return stopApp(call, await request);
  }

  $async.Future<$0.App> syncAppScripts_Pre($grpc.ServiceCall call, $async.Future<$0.AppIdPayload> request) async {
    return syncAppScripts(call, await request);
  }

  $async.Future<$0.App> updateDefaultRunScript_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateDefaultRunScriptParams> request) async {
    return updateDefaultRunScript(call, await request);
  }

  $async.Future<$0.App> createApp($grpc.ServiceCall call, $0.CreateAppPayload request);
  $async.Future<$0.App> readApp($grpc.ServiceCall call, $0.AppIdPayload request);
  $async.Future<$0.App> updateApp($grpc.ServiceCall call, $0.CreateAppPayload request);
  $async.Future<$0.AppIdPayload> removeApp($grpc.ServiceCall call, $0.AppIdPayload request);
  $async.Future<$0.AppList> readAllApps($grpc.ServiceCall call, $0.EmptyParams request);
  $async.Future<$0.AppRunTime> runApp($grpc.ServiceCall call, $0.RunAppRequest request);
  $async.Future<$0.AppRunTime> stopApp($grpc.ServiceCall call, $0.StopAppRequest request);
  $async.Future<$0.App> syncAppScripts($grpc.ServiceCall call, $0.AppIdPayload request);
  $async.Future<$0.App> updateDefaultRunScript($grpc.ServiceCall call, $0.UpdateDefaultRunScriptParams request);
}
@$pb.GrpcServiceName('api.Environment')
class EnvironmentClient extends $grpc.Client {
  static final _$processStream = $grpc.ClientMethod<$0.DataRequest, $0.ProcessInfo>(
      '/api.Environment/ProcessStream',
      ($0.DataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ProcessInfo.fromBuffer(value));
  static final _$getNodejsInfo = $grpc.ClientMethod<$0.EmptyParams, $0.NodejsVersionsInfo>(
      '/api.Environment/GetNodejsInfo',
      ($0.EmptyParams value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.NodejsVersionsInfo.fromBuffer(value));
  static final _$updateDefaultNodejsVersion = $grpc.ClientMethod<$0.UpdateDefaultNodejsVersionParams, $0.StatusResponse>(
      '/api.Environment/UpdateDefaultNodejsVersion',
      ($0.UpdateDefaultNodejsVersionParams value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.StatusResponse.fromBuffer(value));
  static final _$downloadNodeJsVersion = $grpc.ClientMethod<$0.RequestVersion, $0.DownloadStatusResponse>(
      '/api.Environment/DownloadNodeJsVersion',
      ($0.RequestVersion value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DownloadStatusResponse.fromBuffer(value));

  EnvironmentClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.ProcessInfo> processStream($0.DataRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$processStream, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.NodejsVersionsInfo> getNodejsInfo($0.EmptyParams request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNodejsInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> updateDefaultNodejsVersion($0.UpdateDefaultNodejsVersionParams request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDefaultNodejsVersion, request, options: options);
  }

  $grpc.ResponseStream<$0.DownloadStatusResponse> downloadNodeJsVersion($0.RequestVersion request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$downloadNodeJsVersion, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('api.Environment')
abstract class EnvironmentServiceBase extends $grpc.Service {
  $core.String get $name => 'api.Environment';

  EnvironmentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DataRequest, $0.ProcessInfo>(
        'ProcessStream',
        processStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.DataRequest.fromBuffer(value),
        ($0.ProcessInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EmptyParams, $0.NodejsVersionsInfo>(
        'GetNodejsInfo',
        getNodejsInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EmptyParams.fromBuffer(value),
        ($0.NodejsVersionsInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateDefaultNodejsVersionParams, $0.StatusResponse>(
        'UpdateDefaultNodejsVersion',
        updateDefaultNodejsVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateDefaultNodejsVersionParams.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestVersion, $0.DownloadStatusResponse>(
        'DownloadNodeJsVersion',
        downloadNodeJsVersion_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.RequestVersion.fromBuffer(value),
        ($0.DownloadStatusResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.ProcessInfo> processStream_Pre($grpc.ServiceCall call, $async.Future<$0.DataRequest> request) async* {
    yield* processStream(call, await request);
  }

  $async.Future<$0.NodejsVersionsInfo> getNodejsInfo_Pre($grpc.ServiceCall call, $async.Future<$0.EmptyParams> request) async {
    return getNodejsInfo(call, await request);
  }

  $async.Future<$0.StatusResponse> updateDefaultNodejsVersion_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateDefaultNodejsVersionParams> request) async {
    return updateDefaultNodejsVersion(call, await request);
  }

  $async.Stream<$0.DownloadStatusResponse> downloadNodeJsVersion_Pre($grpc.ServiceCall call, $async.Future<$0.RequestVersion> request) async* {
    yield* downloadNodeJsVersion(call, await request);
  }

  $async.Stream<$0.ProcessInfo> processStream($grpc.ServiceCall call, $0.DataRequest request);
  $async.Future<$0.NodejsVersionsInfo> getNodejsInfo($grpc.ServiceCall call, $0.EmptyParams request);
  $async.Future<$0.StatusResponse> updateDefaultNodejsVersion($grpc.ServiceCall call, $0.UpdateDefaultNodejsVersionParams request);
  $async.Stream<$0.DownloadStatusResponse> downloadNodeJsVersion($grpc.ServiceCall call, $0.RequestVersion request);
}
