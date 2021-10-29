import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

import '../service/config.dart';

class MockHttpClient implements http.Client {
  final Config config;

  MockHttpClient(this.config);

  var urlPathToMockYamlPath = {
    '/auth-server/users/userId/change_password':
        'lib/mock/scenario/authentication_service/change_password',
    '/auth-server/oauth2/token':
        'lib/mock/scenario/authentication_service/grant_verified_user',
    '/auth-server/user/reset_password':
        'lib/mock/scenario/authentication_service/reset_password',
    '/auth-server/users/userId/logout':
        'lib/mock/scenario/authentication_service/logout',
    '/albums/1': 'lib/mock/scenario/sample_service'
  };

  var urlPathToServiceMethod = {
    '/auth-server/users/userId/change_password':
        'authentication_service.change_password',
    '/auth-server/oauth2/token': 'authentication_service.grant_verified_user',
    '/auth-server/user/reset_password': 'authentication_service.reset_password',
    '/auth-server/users/userId/logout': 'authentication_service.logout'
  };

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return _mapUrlPathToResponse(url.path);
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _mapUrlPathToResponse(url.path);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _mapUrlPathToResponse(url.path);
  }

  Future<http.Response> _mapUrlPathToResponse(String urlPath) {
    var yamlDir = urlPathToMockYamlPath[urlPath];
    var code = config.scenarios[urlPathToServiceMethod[urlPath]] ?? 'default';
    var yamlPath = '';
    if (code.startsWith('common.')) {
      yamlPath = 'lib/mock/scenario/common/${code.split('.').last}.yaml';
    } else {
      yamlPath = '$yamlDir/$code.yaml';
    }
    return _yamlToHttpResponse(yamlPath);
  }

  Future<http.Response> _yamlToHttpResponse(String yamlPath) {
    return File(yamlPath).readAsString().then((content) {
      var doc = loadYaml(content);
      return http.Response(doc['response'], doc['code']);
    });
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}