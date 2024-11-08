//
//  Generated code. Do not modify.
//  source: api.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EmptyParams extends $pb.GeneratedMessage {
  factory EmptyParams() => create();
  EmptyParams._() : super();
  factory EmptyParams.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmptyParams.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmptyParams', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmptyParams clone() => EmptyParams()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmptyParams copyWith(void Function(EmptyParams) updates) => super.copyWith((message) => updates(message as EmptyParams)) as EmptyParams;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmptyParams create() => EmptyParams._();
  EmptyParams createEmptyInstance() => create();
  static $pb.PbList<EmptyParams> createRepeated() => $pb.PbList<EmptyParams>();
  @$core.pragma('dart2js:noInline')
  static EmptyParams getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmptyParams>(create);
  static EmptyParams? _defaultInstance;
}

class App extends $pb.GeneratedMessage {
  factory App({
    $core.int? id,
    $core.String? path,
    $core.String? name,
    $core.Iterable<$core.String>? scripts,
    $core.String? nodeVersion,
    $core.String? defaultScript,
    $core.bool? isAppValid,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (path != null) {
      $result.path = path;
    }
    if (name != null) {
      $result.name = name;
    }
    if (scripts != null) {
      $result.scripts.addAll(scripts);
    }
    if (nodeVersion != null) {
      $result.nodeVersion = nodeVersion;
    }
    if (defaultScript != null) {
      $result.defaultScript = defaultScript;
    }
    if (isAppValid != null) {
      $result.isAppValid = isAppValid;
    }
    return $result;
  }
  App._() : super();
  factory App.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory App.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'App', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..pPS(4, _omitFieldNames ? '' : 'scripts')
    ..aOS(5, _omitFieldNames ? '' : 'nodeVersion', protoName: 'nodeVersion')
    ..aOS(6, _omitFieldNames ? '' : 'defaultScript', protoName: 'defaultScript')
    ..aOB(7, _omitFieldNames ? '' : 'isAppValid', protoName: 'isAppValid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  App clone() => App()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  App copyWith(void Function(App) updates) => super.copyWith((message) => updates(message as App)) as App;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static App create() => App._();
  App createEmptyInstance() => create();
  static $pb.PbList<App> createRepeated() => $pb.PbList<App>();
  @$core.pragma('dart2js:noInline')
  static App getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<App>(create);
  static App? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get scripts => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get nodeVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set nodeVersion($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNodeVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearNodeVersion() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get defaultScript => $_getSZ(5);
  @$pb.TagNumber(6)
  set defaultScript($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDefaultScript() => $_has(5);
  @$pb.TagNumber(6)
  void clearDefaultScript() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isAppValid => $_getBF(6);
  @$pb.TagNumber(7)
  set isAppValid($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsAppValid() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsAppValid() => clearField(7);
}

class RequestVersion extends $pb.GeneratedMessage {
  factory RequestVersion({
    $core.String? version,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  RequestVersion._() : super();
  factory RequestVersion.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestVersion.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestVersion', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestVersion clone() => RequestVersion()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestVersion copyWith(void Function(RequestVersion) updates) => super.copyWith((message) => updates(message as RequestVersion)) as RequestVersion;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestVersion create() => RequestVersion._();
  RequestVersion createEmptyInstance() => create();
  static $pb.PbList<RequestVersion> createRepeated() => $pb.PbList<RequestVersion>();
  @$core.pragma('dart2js:noInline')
  static RequestVersion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestVersion>(create);
  static RequestVersion? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
}

class UpdateDefaultNodejsVersionParams extends $pb.GeneratedMessage {
  factory UpdateDefaultNodejsVersionParams({
    $core.int? id,
    $core.String? version,
    $core.bool? updateNvmrc,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (version != null) {
      $result.version = version;
    }
    if (updateNvmrc != null) {
      $result.updateNvmrc = updateNvmrc;
    }
    return $result;
  }
  UpdateDefaultNodejsVersionParams._() : super();
  factory UpdateDefaultNodejsVersionParams.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateDefaultNodejsVersionParams.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateDefaultNodejsVersionParams', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'version')
    ..aOB(3, _omitFieldNames ? '' : 'updateNvmrc', protoName: 'updateNvmrc')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateDefaultNodejsVersionParams clone() => UpdateDefaultNodejsVersionParams()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateDefaultNodejsVersionParams copyWith(void Function(UpdateDefaultNodejsVersionParams) updates) => super.copyWith((message) => updates(message as UpdateDefaultNodejsVersionParams)) as UpdateDefaultNodejsVersionParams;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDefaultNodejsVersionParams create() => UpdateDefaultNodejsVersionParams._();
  UpdateDefaultNodejsVersionParams createEmptyInstance() => create();
  static $pb.PbList<UpdateDefaultNodejsVersionParams> createRepeated() => $pb.PbList<UpdateDefaultNodejsVersionParams>();
  @$core.pragma('dart2js:noInline')
  static UpdateDefaultNodejsVersionParams getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateDefaultNodejsVersionParams>(create);
  static UpdateDefaultNodejsVersionParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get updateNvmrc => $_getBF(2);
  @$pb.TagNumber(3)
  set updateNvmrc($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdateNvmrc() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateNvmrc() => clearField(3);
}

class AppList extends $pb.GeneratedMessage {
  factory AppList({
    $core.Iterable<App>? apps,
  }) {
    final $result = create();
    if (apps != null) {
      $result.apps.addAll(apps);
    }
    return $result;
  }
  AppList._() : super();
  factory AppList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AppList', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pc<App>(1, _omitFieldNames ? '' : 'apps', $pb.PbFieldType.PM, subBuilder: App.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AppList clone() => AppList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AppList copyWith(void Function(AppList) updates) => super.copyWith((message) => updates(message as AppList)) as AppList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppList create() => AppList._();
  AppList createEmptyInstance() => create();
  static $pb.PbList<AppList> createRepeated() => $pb.PbList<AppList>();
  @$core.pragma('dart2js:noInline')
  static AppList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppList>(create);
  static AppList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<App> get apps => $_getList(0);
}

class CreateAppPayload extends $pb.GeneratedMessage {
  factory CreateAppPayload({
    $core.String? path,
    $core.String? name,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  CreateAppPayload._() : super();
  factory CreateAppPayload.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAppPayload.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAppPayload', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAppPayload clone() => CreateAppPayload()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAppPayload copyWith(void Function(CreateAppPayload) updates) => super.copyWith((message) => updates(message as CreateAppPayload)) as CreateAppPayload;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAppPayload create() => CreateAppPayload._();
  CreateAppPayload createEmptyInstance() => create();
  static $pb.PbList<CreateAppPayload> createRepeated() => $pb.PbList<CreateAppPayload>();
  @$core.pragma('dart2js:noInline')
  static CreateAppPayload getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAppPayload>(create);
  static CreateAppPayload? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class AppIdPayload extends $pb.GeneratedMessage {
  factory AppIdPayload({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  AppIdPayload._() : super();
  factory AppIdPayload.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppIdPayload.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AppIdPayload', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AppIdPayload clone() => AppIdPayload()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AppIdPayload copyWith(void Function(AppIdPayload) updates) => super.copyWith((message) => updates(message as AppIdPayload)) as AppIdPayload;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppIdPayload create() => AppIdPayload._();
  AppIdPayload createEmptyInstance() => create();
  static $pb.PbList<AppIdPayload> createRepeated() => $pb.PbList<AppIdPayload>();
  @$core.pragma('dart2js:noInline')
  static AppIdPayload getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppIdPayload>(create);
  static AppIdPayload? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class Remove extends $pb.GeneratedMessage {
  factory Remove({
    $core.String? path,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  Remove._() : super();
  factory Remove.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Remove.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Remove', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Remove clone() => Remove()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Remove copyWith(void Function(Remove) updates) => super.copyWith((message) => updates(message as Remove)) as Remove;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Remove create() => Remove._();
  Remove createEmptyInstance() => create();
  static $pb.PbList<Remove> createRepeated() => $pb.PbList<Remove>();
  @$core.pragma('dart2js:noInline')
  static Remove getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Remove>(create);
  static Remove? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class StatusResponse extends $pb.GeneratedMessage {
  factory StatusResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  StatusResponse._() : super();
  factory StatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StatusResponse clone() => StatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StatusResponse copyWith(void Function(StatusResponse) updates) => super.copyWith((message) => updates(message as StatusResponse)) as StatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatusResponse create() => StatusResponse._();
  StatusResponse createEmptyInstance() => create();
  static $pb.PbList<StatusResponse> createRepeated() => $pb.PbList<StatusResponse>();
  @$core.pragma('dart2js:noInline')
  static StatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatusResponse>(create);
  static StatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class StopAppRequest extends $pb.GeneratedMessage {
  factory StopAppRequest({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  StopAppRequest._() : super();
  factory StopAppRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StopAppRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StopAppRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StopAppRequest clone() => StopAppRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StopAppRequest copyWith(void Function(StopAppRequest) updates) => super.copyWith((message) => updates(message as StopAppRequest)) as StopAppRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopAppRequest create() => StopAppRequest._();
  StopAppRequest createEmptyInstance() => create();
  static $pb.PbList<StopAppRequest> createRepeated() => $pb.PbList<StopAppRequest>();
  @$core.pragma('dart2js:noInline')
  static StopAppRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StopAppRequest>(create);
  static StopAppRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class RunAppRequest extends $pb.GeneratedMessage {
  factory RunAppRequest({
    $core.int? id,
    $core.String? command,
    $core.String? nodeVersion,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (command != null) {
      $result.command = command;
    }
    if (nodeVersion != null) {
      $result.nodeVersion = nodeVersion;
    }
    return $result;
  }
  RunAppRequest._() : super();
  factory RunAppRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RunAppRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RunAppRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'command')
    ..aOS(3, _omitFieldNames ? '' : 'nodeVersion', protoName: 'nodeVersion')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RunAppRequest clone() => RunAppRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RunAppRequest copyWith(void Function(RunAppRequest) updates) => super.copyWith((message) => updates(message as RunAppRequest)) as RunAppRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunAppRequest create() => RunAppRequest._();
  RunAppRequest createEmptyInstance() => create();
  static $pb.PbList<RunAppRequest> createRepeated() => $pb.PbList<RunAppRequest>();
  @$core.pragma('dart2js:noInline')
  static RunAppRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunAppRequest>(create);
  static RunAppRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get command => $_getSZ(1);
  @$pb.TagNumber(2)
  set command($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCommand() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommand() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get nodeVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set nodeVersion($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNodeVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearNodeVersion() => clearField(3);
}

class AppRunTime extends $pb.GeneratedMessage {
  factory AppRunTime({
    $core.int? id,
    $core.String? status,
    $core.int? pid,
    $core.int? cpu,
    $core.int? mem,
    $core.int? sid,
    $core.Iterable<$core.int>? ports,
    $core.String? branch,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (status != null) {
      $result.status = status;
    }
    if (pid != null) {
      $result.pid = pid;
    }
    if (cpu != null) {
      $result.cpu = cpu;
    }
    if (mem != null) {
      $result.mem = mem;
    }
    if (sid != null) {
      $result.sid = sid;
    }
    if (ports != null) {
      $result.ports.addAll(ports);
    }
    if (branch != null) {
      $result.branch = branch;
    }
    return $result;
  }
  AppRunTime._() : super();
  factory AppRunTime.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppRunTime.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AppRunTime', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pid', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'cpu', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'mem', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'sid', $pb.PbFieldType.O3)
    ..p<$core.int>(7, _omitFieldNames ? '' : 'ports', $pb.PbFieldType.K3)
    ..aOS(8, _omitFieldNames ? '' : 'branch')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AppRunTime clone() => AppRunTime()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AppRunTime copyWith(void Function(AppRunTime) updates) => super.copyWith((message) => updates(message as AppRunTime)) as AppRunTime;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppRunTime create() => AppRunTime._();
  AppRunTime createEmptyInstance() => create();
  static $pb.PbList<AppRunTime> createRepeated() => $pb.PbList<AppRunTime>();
  @$core.pragma('dart2js:noInline')
  static AppRunTime getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppRunTime>(create);
  static AppRunTime? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pid => $_getIZ(2);
  @$pb.TagNumber(3)
  set pid($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPid() => $_has(2);
  @$pb.TagNumber(3)
  void clearPid() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get cpu => $_getIZ(3);
  @$pb.TagNumber(4)
  set cpu($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCpu() => $_has(3);
  @$pb.TagNumber(4)
  void clearCpu() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get mem => $_getIZ(4);
  @$pb.TagNumber(5)
  set mem($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMem() => $_has(4);
  @$pb.TagNumber(5)
  void clearMem() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get sid => $_getIZ(5);
  @$pb.TagNumber(6)
  set sid($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSid() => $_has(5);
  @$pb.TagNumber(6)
  void clearSid() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get ports => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get branch => $_getSZ(7);
  @$pb.TagNumber(8)
  set branch($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBranch() => $_has(7);
  @$pb.TagNumber(8)
  void clearBranch() => clearField(8);
}

class DataRequest extends $pb.GeneratedMessage {
  factory DataRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  DataRequest._() : super();
  factory DataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DataRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DataRequest clone() => DataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DataRequest copyWith(void Function(DataRequest) updates) => super.copyWith((message) => updates(message as DataRequest)) as DataRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataRequest create() => DataRequest._();
  DataRequest createEmptyInstance() => create();
  static $pb.PbList<DataRequest> createRepeated() => $pb.PbList<DataRequest>();
  @$core.pragma('dart2js:noInline')
  static DataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DataRequest>(create);
  static DataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class TotalEnviromentUsage extends $pb.GeneratedMessage {
  factory TotalEnviromentUsage({
    $core.String? cpu,
    $core.String? mem,
    $core.int? quantity,
  }) {
    final $result = create();
    if (cpu != null) {
      $result.cpu = cpu;
    }
    if (mem != null) {
      $result.mem = mem;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    return $result;
  }
  TotalEnviromentUsage._() : super();
  factory TotalEnviromentUsage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TotalEnviromentUsage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TotalEnviromentUsage', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cpu')
    ..aOS(2, _omitFieldNames ? '' : 'mem')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TotalEnviromentUsage clone() => TotalEnviromentUsage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TotalEnviromentUsage copyWith(void Function(TotalEnviromentUsage) updates) => super.copyWith((message) => updates(message as TotalEnviromentUsage)) as TotalEnviromentUsage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TotalEnviromentUsage create() => TotalEnviromentUsage._();
  TotalEnviromentUsage createEmptyInstance() => create();
  static $pb.PbList<TotalEnviromentUsage> createRepeated() => $pb.PbList<TotalEnviromentUsage>();
  @$core.pragma('dart2js:noInline')
  static TotalEnviromentUsage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TotalEnviromentUsage>(create);
  static TotalEnviromentUsage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cpu => $_getSZ(0);
  @$pb.TagNumber(1)
  set cpu($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCpu() => $_has(0);
  @$pb.TagNumber(1)
  void clearCpu() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get mem => $_getSZ(1);
  @$pb.TagNumber(2)
  set mem($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMem() => $_has(1);
  @$pb.TagNumber(2)
  void clearMem() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get quantity => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantity($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => clearField(3);
}

class ProcessInfo extends $pb.GeneratedMessage {
  factory ProcessInfo({
    TotalEnviromentUsage? environment,
    $core.Iterable<AppRunTime>? apps,
  }) {
    final $result = create();
    if (environment != null) {
      $result.environment = environment;
    }
    if (apps != null) {
      $result.apps.addAll(apps);
    }
    return $result;
  }
  ProcessInfo._() : super();
  factory ProcessInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOM<TotalEnviromentUsage>(1, _omitFieldNames ? '' : 'environment', subBuilder: TotalEnviromentUsage.create)
    ..pc<AppRunTime>(2, _omitFieldNames ? '' : 'apps', $pb.PbFieldType.PM, subBuilder: AppRunTime.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessInfo clone() => ProcessInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessInfo copyWith(void Function(ProcessInfo) updates) => super.copyWith((message) => updates(message as ProcessInfo)) as ProcessInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessInfo create() => ProcessInfo._();
  ProcessInfo createEmptyInstance() => create();
  static $pb.PbList<ProcessInfo> createRepeated() => $pb.PbList<ProcessInfo>();
  @$core.pragma('dart2js:noInline')
  static ProcessInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessInfo>(create);
  static ProcessInfo? _defaultInstance;

  @$pb.TagNumber(1)
  TotalEnviromentUsage get environment => $_getN(0);
  @$pb.TagNumber(1)
  set environment(TotalEnviromentUsage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnvironment() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnvironment() => clearField(1);
  @$pb.TagNumber(1)
  TotalEnviromentUsage ensureEnvironment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<AppRunTime> get apps => $_getList(1);
}

class NodejsVersionsInfo extends $pb.GeneratedMessage {
  factory NodejsVersionsInfo({
    $core.Iterable<$core.String>? installed,
    $core.Iterable<$core.String>? remoteLts,
  }) {
    final $result = create();
    if (installed != null) {
      $result.installed.addAll(installed);
    }
    if (remoteLts != null) {
      $result.remoteLts.addAll(remoteLts);
    }
    return $result;
  }
  NodejsVersionsInfo._() : super();
  factory NodejsVersionsInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodejsVersionsInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodejsVersionsInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'installed')
    ..pPS(2, _omitFieldNames ? '' : 'remoteLts', protoName: 'remoteLts')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodejsVersionsInfo clone() => NodejsVersionsInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodejsVersionsInfo copyWith(void Function(NodejsVersionsInfo) updates) => super.copyWith((message) => updates(message as NodejsVersionsInfo)) as NodejsVersionsInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodejsVersionsInfo create() => NodejsVersionsInfo._();
  NodejsVersionsInfo createEmptyInstance() => create();
  static $pb.PbList<NodejsVersionsInfo> createRepeated() => $pb.PbList<NodejsVersionsInfo>();
  @$core.pragma('dart2js:noInline')
  static NodejsVersionsInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodejsVersionsInfo>(create);
  static NodejsVersionsInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get installed => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get remoteLts => $_getList(1);
}

class UpdateDefaultRunScriptParams extends $pb.GeneratedMessage {
  factory UpdateDefaultRunScriptParams({
    $core.String? script,
    $core.int? id,
  }) {
    final $result = create();
    if (script != null) {
      $result.script = script;
    }
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  UpdateDefaultRunScriptParams._() : super();
  factory UpdateDefaultRunScriptParams.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateDefaultRunScriptParams.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateDefaultRunScriptParams', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'script')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateDefaultRunScriptParams clone() => UpdateDefaultRunScriptParams()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateDefaultRunScriptParams copyWith(void Function(UpdateDefaultRunScriptParams) updates) => super.copyWith((message) => updates(message as UpdateDefaultRunScriptParams)) as UpdateDefaultRunScriptParams;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDefaultRunScriptParams create() => UpdateDefaultRunScriptParams._();
  UpdateDefaultRunScriptParams createEmptyInstance() => create();
  static $pb.PbList<UpdateDefaultRunScriptParams> createRepeated() => $pb.PbList<UpdateDefaultRunScriptParams>();
  @$core.pragma('dart2js:noInline')
  static UpdateDefaultRunScriptParams getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateDefaultRunScriptParams>(create);
  static UpdateDefaultRunScriptParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get script => $_getSZ(0);
  @$pb.TagNumber(1)
  set script($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScript() => $_has(0);
  @$pb.TagNumber(1)
  void clearScript() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get id => $_getIZ(1);
  @$pb.TagNumber(2)
  set id($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);
}

class DownloadStatusResponse extends $pb.GeneratedMessage {
  factory DownloadStatusResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  DownloadStatusResponse._() : super();
  factory DownloadStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DownloadStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadStatusResponse clone() => DownloadStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadStatusResponse copyWith(void Function(DownloadStatusResponse) updates) => super.copyWith((message) => updates(message as DownloadStatusResponse)) as DownloadStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadStatusResponse create() => DownloadStatusResponse._();
  DownloadStatusResponse createEmptyInstance() => create();
  static $pb.PbList<DownloadStatusResponse> createRepeated() => $pb.PbList<DownloadStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static DownloadStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadStatusResponse>(create);
  static DownloadStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
