//
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use emptyParamsDescriptor instead')
const EmptyParams$json = {
  '1': 'EmptyParams',
};

/// Descriptor for `EmptyParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyParamsDescriptor = $convert.base64Decode(
    'CgtFbXB0eVBhcmFtcw==');

@$core.Deprecated('Use nodeDescriptor instead')
const Node$json = {
  '1': 'Node',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'scripts', '3': 4, '4': 3, '5': 9, '10': 'scripts'},
    {'1': 'node_version', '3': 5, '4': 1, '5': 9, '10': 'nodeVersion'},
  ],
};

/// Descriptor for `Node`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDescriptor = $convert.base64Decode(
    'CgROb2RlEg4KAmlkGAEgASgFUgJpZBISCgRwYXRoGAIgASgJUgRwYXRoEhIKBG5hbWUYAyABKA'
    'lSBG5hbWUSGAoHc2NyaXB0cxgEIAMoCVIHc2NyaXB0cxIhCgxub2RlX3ZlcnNpb24YBSABKAlS'
    'C25vZGVWZXJzaW9u');

@$core.Deprecated('Use nodeListDescriptor instead')
const NodeList$json = {
  '1': 'NodeList',
  '2': [
    {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.api.Node', '10': 'nodes'},
  ],
};

/// Descriptor for `NodeList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeListDescriptor = $convert.base64Decode(
    'CghOb2RlTGlzdBIfCgVub2RlcxgBIAMoCzIJLmFwaS5Ob2RlUgVub2Rlcw==');

@$core.Deprecated('Use createRequestDescriptor instead')
const CreateRequest$json = {
  '1': 'CreateRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CreateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRequestDescriptor = $convert.base64Decode(
    'Cg1DcmVhdGVSZXF1ZXN0EhIKBHBhdGgYASABKAlSBHBhdGgSEgoEbmFtZRgCIAEoCVIEbmFtZQ'
    '==');

@$core.Deprecated('Use readRequestDescriptor instead')
const ReadRequest$json = {
  '1': 'ReadRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `ReadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readRequestDescriptor = $convert.base64Decode(
    'CgtSZWFkUmVxdWVzdBIOCgJpZBgBIAEoBVICaWQ=');

@$core.Deprecated('Use removeDescriptor instead')
const Remove$json = {
  '1': 'Remove',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `Remove`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeDescriptor = $convert.base64Decode(
    'CgZSZW1vdmUSEgoEcGF0aBgBIAEoCVIEcGF0aA==');

@$core.Deprecated('Use statusResponseDescriptor instead')
const StatusResponse$json = {
  '1': 'StatusResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `StatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusResponseDescriptor = $convert.base64Decode(
    'Cg5TdGF0dXNSZXNwb25zZRIWCgZzdGF0dXMYASABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use stopNodeRequestDescriptor instead')
const StopNodeRequest$json = {
  '1': 'StopNodeRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `StopNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopNodeRequestDescriptor = $convert.base64Decode(
    'Cg9TdG9wTm9kZVJlcXVlc3QSDgoCaWQYASABKAVSAmlk');

@$core.Deprecated('Use runNodeRequestDescriptor instead')
const RunNodeRequest$json = {
  '1': 'RunNodeRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'command', '3': 2, '4': 1, '5': 9, '10': 'command'},
  ],
};

/// Descriptor for `RunNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runNodeRequestDescriptor = $convert.base64Decode(
    'Cg5SdW5Ob2RlUmVxdWVzdBIOCgJpZBgBIAEoBVICaWQSGAoHY29tbWFuZBgCIAEoCVIHY29tbW'
    'FuZA==');

@$core.Deprecated('Use nodeRunTimeDescriptor instead')
const NodeRunTime$json = {
  '1': 'NodeRunTime',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'pid', '3': 3, '4': 1, '5': 5, '10': 'pid'},
    {'1': 'cpu', '3': 4, '4': 1, '5': 5, '10': 'cpu'},
    {'1': 'mem', '3': 5, '4': 1, '5': 5, '10': 'mem'},
    {'1': 'sid', '3': 6, '4': 1, '5': 5, '10': 'sid'},
    {'1': 'ports', '3': 7, '4': 3, '5': 5, '10': 'ports'},
    {'1': 'branch', '3': 8, '4': 1, '5': 9, '10': 'branch'},
  ],
};

/// Descriptor for `NodeRunTime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeRunTimeDescriptor = $convert.base64Decode(
    'CgtOb2RlUnVuVGltZRIOCgJpZBgBIAEoBVICaWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSEA'
    'oDcGlkGAMgASgFUgNwaWQSEAoDY3B1GAQgASgFUgNjcHUSEAoDbWVtGAUgASgFUgNtZW0SEAoD'
    'c2lkGAYgASgFUgNzaWQSFAoFcG9ydHMYByADKAVSBXBvcnRzEhYKBmJyYW5jaBgIIAEoCVIGYn'
    'JhbmNo');

@$core.Deprecated('Use dataRequestDescriptor instead')
const DataRequest$json = {
  '1': 'DataRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataRequestDescriptor = $convert.base64Decode(
    'CgtEYXRhUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use totalEnviromentUsageDescriptor instead')
const TotalEnviromentUsage$json = {
  '1': 'TotalEnviromentUsage',
  '2': [
    {'1': 'cpu', '3': 1, '4': 1, '5': 9, '10': 'cpu'},
    {'1': 'mem', '3': 2, '4': 1, '5': 9, '10': 'mem'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 5, '10': 'quantity'},
  ],
};

/// Descriptor for `TotalEnviromentUsage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List totalEnviromentUsageDescriptor = $convert.base64Decode(
    'ChRUb3RhbEVudmlyb21lbnRVc2FnZRIQCgNjcHUYASABKAlSA2NwdRIQCgNtZW0YAiABKAlSA2'
    '1lbRIaCghxdWFudGl0eRgDIAEoBVIIcXVhbnRpdHk=');

@$core.Deprecated('Use processInfoDescriptor instead')
const ProcessInfo$json = {
  '1': 'ProcessInfo',
  '2': [
    {'1': 'environment', '3': 1, '4': 1, '5': 11, '6': '.api.TotalEnviromentUsage', '10': 'environment'},
    {'1': 'nodes', '3': 2, '4': 3, '5': 11, '6': '.api.NodeRunTime', '10': 'nodes'},
  ],
};

/// Descriptor for `ProcessInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processInfoDescriptor = $convert.base64Decode(
    'CgtQcm9jZXNzSW5mbxI7CgtlbnZpcm9ubWVudBgBIAEoCzIZLmFwaS5Ub3RhbEVudmlyb21lbn'
    'RVc2FnZVILZW52aXJvbm1lbnQSJgoFbm9kZXMYAiADKAsyEC5hcGkuTm9kZVJ1blRpbWVSBW5v'
    'ZGVz');

@$core.Deprecated('Use nodejsVersionsInfoDescriptor instead')
const NodejsVersionsInfo$json = {
  '1': 'NodejsVersionsInfo',
  '2': [
    {'1': 'installed', '3': 1, '4': 3, '5': 9, '10': 'installed'},
    {'1': 'remoteLts', '3': 2, '4': 3, '5': 9, '10': 'remoteLts'},
  ],
};

/// Descriptor for `NodejsVersionsInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodejsVersionsInfoDescriptor = $convert.base64Decode(
    'ChJOb2RlanNWZXJzaW9uc0luZm8SHAoJaW5zdGFsbGVkGAEgAygJUglpbnN0YWxsZWQSHAoJcm'
    'Vtb3RlTHRzGAIgAygJUglyZW1vdGVMdHM=');

