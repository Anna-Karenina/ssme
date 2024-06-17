//
//  Generated code. Do not modify.
//  source: nodes.proto
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

class Node extends $pb.GeneratedMessage {
  factory Node({
    $core.int? id,
    $core.String? path,
    $core.String? name,
    $core.Iterable<$core.String>? scripts,
    $core.String? nodeVersion,
    $core.String? defaultScript,
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
    return $result;
  }
  Node._() : super();
  factory Node.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Node.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Node', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..pPS(4, _omitFieldNames ? '' : 'scripts')
    ..aOS(5, _omitFieldNames ? '' : 'nodeVersion')
    ..aOS(6, _omitFieldNames ? '' : 'defaultScript')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Node clone() => Node()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Node copyWith(void Function(Node) updates) => super.copyWith((message) => updates(message as Node)) as Node;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Node create() => Node._();
  Node createEmptyInstance() => create();
  static $pb.PbList<Node> createRepeated() => $pb.PbList<Node>();
  @$core.pragma('dart2js:noInline')
  static Node getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Node>(create);
  static Node? _defaultInstance;

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

class NodeList extends $pb.GeneratedMessage {
  factory NodeList({
    $core.Iterable<Node>? nodes,
  }) {
    final $result = create();
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    return $result;
  }
  NodeList._() : super();
  factory NodeList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeList', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pc<Node>(1, _omitFieldNames ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeList clone() => NodeList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeList copyWith(void Function(NodeList) updates) => super.copyWith((message) => updates(message as NodeList)) as NodeList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeList create() => NodeList._();
  NodeList createEmptyInstance() => create();
  static $pb.PbList<NodeList> createRepeated() => $pb.PbList<NodeList>();
  @$core.pragma('dart2js:noInline')
  static NodeList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeList>(create);
  static NodeList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Node> get nodes => $_getList(0);
}

class CreateRequest extends $pb.GeneratedMessage {
  factory CreateRequest({
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
  CreateRequest._() : super();
  factory CreateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateRequest clone() => CreateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateRequest copyWith(void Function(CreateRequest) updates) => super.copyWith((message) => updates(message as CreateRequest)) as CreateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRequest create() => CreateRequest._();
  CreateRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRequest> createRepeated() => $pb.PbList<CreateRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRequest>(create);
  static CreateRequest? _defaultInstance;

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

class ReadRequest extends $pb.GeneratedMessage {
  factory ReadRequest({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  ReadRequest._() : super();
  factory ReadRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReadRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadRequest clone() => ReadRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadRequest copyWith(void Function(ReadRequest) updates) => super.copyWith((message) => updates(message as ReadRequest)) as ReadRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadRequest create() => ReadRequest._();
  ReadRequest createEmptyInstance() => create();
  static $pb.PbList<ReadRequest> createRepeated() => $pb.PbList<ReadRequest>();
  @$core.pragma('dart2js:noInline')
  static ReadRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadRequest>(create);
  static ReadRequest? _defaultInstance;

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

class StopNodeRequest extends $pb.GeneratedMessage {
  factory StopNodeRequest({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  StopNodeRequest._() : super();
  factory StopNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StopNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StopNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StopNodeRequest clone() => StopNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StopNodeRequest copyWith(void Function(StopNodeRequest) updates) => super.copyWith((message) => updates(message as StopNodeRequest)) as StopNodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopNodeRequest create() => StopNodeRequest._();
  StopNodeRequest createEmptyInstance() => create();
  static $pb.PbList<StopNodeRequest> createRepeated() => $pb.PbList<StopNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static StopNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StopNodeRequest>(create);
  static StopNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class RunNodeRequest extends $pb.GeneratedMessage {
  factory RunNodeRequest({
    $core.int? id,
    $core.String? command,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (command != null) {
      $result.command = command;
    }
    return $result;
  }
  RunNodeRequest._() : super();
  factory RunNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RunNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RunNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'command')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RunNodeRequest clone() => RunNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RunNodeRequest copyWith(void Function(RunNodeRequest) updates) => super.copyWith((message) => updates(message as RunNodeRequest)) as RunNodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunNodeRequest create() => RunNodeRequest._();
  RunNodeRequest createEmptyInstance() => create();
  static $pb.PbList<RunNodeRequest> createRepeated() => $pb.PbList<RunNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static RunNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunNodeRequest>(create);
  static RunNodeRequest? _defaultInstance;

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
}

class NodeRunTime extends $pb.GeneratedMessage {
  factory NodeRunTime({
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
  NodeRunTime._() : super();
  factory NodeRunTime.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeRunTime.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeRunTime', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
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
  NodeRunTime clone() => NodeRunTime()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeRunTime copyWith(void Function(NodeRunTime) updates) => super.copyWith((message) => updates(message as NodeRunTime)) as NodeRunTime;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeRunTime create() => NodeRunTime._();
  NodeRunTime createEmptyInstance() => create();
  static $pb.PbList<NodeRunTime> createRepeated() => $pb.PbList<NodeRunTime>();
  @$core.pragma('dart2js:noInline')
  static NodeRunTime getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeRunTime>(create);
  static NodeRunTime? _defaultInstance;

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
    $core.Iterable<NodeRunTime>? nodes,
  }) {
    final $result = create();
    if (environment != null) {
      $result.environment = environment;
    }
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    return $result;
  }
  ProcessInfo._() : super();
  factory ProcessInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOM<TotalEnviromentUsage>(1, _omitFieldNames ? '' : 'environment', subBuilder: TotalEnviromentUsage.create)
    ..pc<NodeRunTime>(2, _omitFieldNames ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: NodeRunTime.create)
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
  $core.List<NodeRunTime> get nodes => $_getList(1);
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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
