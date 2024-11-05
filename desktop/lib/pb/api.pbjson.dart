//
//  Generated code. Do not modify.
//  source: api.proto
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

@$core.Deprecated('Use appDescriptor instead')
const App$json = {
  '1': 'App',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'scripts', '3': 4, '4': 3, '5': 9, '10': 'scripts'},
    {'1': 'nodeVersion', '3': 5, '4': 1, '5': 9, '10': 'nodeVersion'},
    {'1': 'defaultScript', '3': 6, '4': 1, '5': 9, '10': 'defaultScript'},
    {'1': 'isAppValid', '3': 7, '4': 1, '5': 8, '10': 'isAppValid'},
  ],
};

/// Descriptor for `App`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appDescriptor = $convert.base64Decode(
    'CgNBcHASDgoCaWQYASABKAVSAmlkEhIKBHBhdGgYAiABKAlSBHBhdGgSEgoEbmFtZRgDIAEoCV'
    'IEbmFtZRIYCgdzY3JpcHRzGAQgAygJUgdzY3JpcHRzEiAKC25vZGVWZXJzaW9uGAUgASgJUgtu'
    'b2RlVmVyc2lvbhIkCg1kZWZhdWx0U2NyaXB0GAYgASgJUg1kZWZhdWx0U2NyaXB0Eh4KCmlzQX'
    'BwVmFsaWQYByABKAhSCmlzQXBwVmFsaWQ=');

@$core.Deprecated('Use requestVersionDescriptor instead')
const RequestVersion$json = {
  '1': 'RequestVersion',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
  ],
};

/// Descriptor for `RequestVersion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestVersionDescriptor = $convert.base64Decode(
    'Cg5SZXF1ZXN0VmVyc2lvbhIYCgd2ZXJzaW9uGAEgASgJUgd2ZXJzaW9u');

@$core.Deprecated('Use updateDefaultNodejsVersionParamsDescriptor instead')
const UpdateDefaultNodejsVersionParams$json = {
  '1': 'UpdateDefaultNodejsVersionParams',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
    {'1': 'updateNvmrc', '3': 3, '4': 1, '5': 8, '10': 'updateNvmrc'},
  ],
};

/// Descriptor for `UpdateDefaultNodejsVersionParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDefaultNodejsVersionParamsDescriptor = $convert.base64Decode(
    'CiBVcGRhdGVEZWZhdWx0Tm9kZWpzVmVyc2lvblBhcmFtcxIOCgJpZBgBIAEoBVICaWQSGAoHdm'
    'Vyc2lvbhgCIAEoCVIHdmVyc2lvbhIgCgt1cGRhdGVOdm1yYxgDIAEoCFILdXBkYXRlTnZtcmM=');

@$core.Deprecated('Use appListDescriptor instead')
const AppList$json = {
  '1': 'AppList',
  '2': [
    {'1': 'apps', '3': 1, '4': 3, '5': 11, '6': '.api.App', '10': 'apps'},
  ],
};

/// Descriptor for `AppList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appListDescriptor = $convert.base64Decode(
    'CgdBcHBMaXN0EhwKBGFwcHMYASADKAsyCC5hcGkuQXBwUgRhcHBz');

@$core.Deprecated('Use createAppPayloadDescriptor instead')
const CreateAppPayload$json = {
  '1': 'CreateAppPayload',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CreateAppPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAppPayloadDescriptor = $convert.base64Decode(
    'ChBDcmVhdGVBcHBQYXlsb2FkEhIKBHBhdGgYASABKAlSBHBhdGgSEgoEbmFtZRgCIAEoCVIEbm'
    'FtZQ==');

@$core.Deprecated('Use appIdPayloadDescriptor instead')
const AppIdPayload$json = {
  '1': 'AppIdPayload',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `AppIdPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appIdPayloadDescriptor = $convert.base64Decode(
    'CgxBcHBJZFBheWxvYWQSDgoCaWQYASABKAVSAmlk');

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

@$core.Deprecated('Use stopAppRequestDescriptor instead')
const StopAppRequest$json = {
  '1': 'StopAppRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `StopAppRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopAppRequestDescriptor = $convert.base64Decode(
    'Cg5TdG9wQXBwUmVxdWVzdBIOCgJpZBgBIAEoBVICaWQ=');

@$core.Deprecated('Use runAppRequestDescriptor instead')
const RunAppRequest$json = {
  '1': 'RunAppRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'command', '3': 2, '4': 1, '5': 9, '10': 'command'},
    {'1': 'nodeVersion', '3': 3, '4': 1, '5': 9, '10': 'nodeVersion'},
  ],
};

/// Descriptor for `RunAppRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runAppRequestDescriptor = $convert.base64Decode(
    'Cg1SdW5BcHBSZXF1ZXN0Eg4KAmlkGAEgASgFUgJpZBIYCgdjb21tYW5kGAIgASgJUgdjb21tYW'
    '5kEiAKC25vZGVWZXJzaW9uGAMgASgJUgtub2RlVmVyc2lvbg==');

@$core.Deprecated('Use appRunTimeDescriptor instead')
const AppRunTime$json = {
  '1': 'AppRunTime',
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

/// Descriptor for `AppRunTime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appRunTimeDescriptor = $convert.base64Decode(
    'CgpBcHBSdW5UaW1lEg4KAmlkGAEgASgFUgJpZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIQCg'
    'NwaWQYAyABKAVSA3BpZBIQCgNjcHUYBCABKAVSA2NwdRIQCgNtZW0YBSABKAVSA21lbRIQCgNz'
    'aWQYBiABKAVSA3NpZBIUCgVwb3J0cxgHIAMoBVIFcG9ydHMSFgoGYnJhbmNoGAggASgJUgZicm'
    'FuY2g=');

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
    {'1': 'apps', '3': 2, '4': 3, '5': 11, '6': '.api.AppRunTime', '10': 'apps'},
  ],
};

/// Descriptor for `ProcessInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processInfoDescriptor = $convert.base64Decode(
    'CgtQcm9jZXNzSW5mbxI7CgtlbnZpcm9ubWVudBgBIAEoCzIZLmFwaS5Ub3RhbEVudmlyb21lbn'
    'RVc2FnZVILZW52aXJvbm1lbnQSIwoEYXBwcxgCIAMoCzIPLmFwaS5BcHBSdW5UaW1lUgRhcHBz');

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

@$core.Deprecated('Use updateDefaultRunScriptParamsDescriptor instead')
const UpdateDefaultRunScriptParams$json = {
  '1': 'UpdateDefaultRunScriptParams',
  '2': [
    {'1': 'script', '3': 1, '4': 1, '5': 9, '10': 'script'},
    {'1': 'id', '3': 2, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `UpdateDefaultRunScriptParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDefaultRunScriptParamsDescriptor = $convert.base64Decode(
    'ChxVcGRhdGVEZWZhdWx0UnVuU2NyaXB0UGFyYW1zEhYKBnNjcmlwdBgBIAEoCVIGc2NyaXB0Eg'
    '4KAmlkGAIgASgFUgJpZA==');

@$core.Deprecated('Use downloadStatusResponseDescriptor instead')
const DownloadStatusResponse$json = {
  '1': 'DownloadStatusResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `DownloadStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadStatusResponseDescriptor = $convert.base64Decode(
    'ChZEb3dubG9hZFN0YXR1c1Jlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');

