import 'dart:convert';

import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/network/authservice.dart';
import 'package:http/http.dart' as http;

class AuthClient {
  final AuthService authService;
  AuthClient(this.authService);

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    try {
      if (authService.accessToken == null) {
        throw UnauthenticatedException();
      }
      final newHeaders = {...?headers};
      newHeaders['Authorization'] = 'Bearer ${authService.accessToken}';

      var res = await http.get(url, headers: newHeaders);
      if (res.statusCode == 401) {
        final jsonRes = jsonDecode(res.body);
        if (jsonRes['message'] == "access-token-expired") {
          bool refreshed = await authService.refreshTokenRequest();
          if (refreshed) {
            newHeaders['Authorization'] = 'Bearer ${authService.accessToken}';
            return await http.get(url, headers: newHeaders);
          } else {
            throw UnauthenticatedException();
          }
        }
        if (jsonRes['message'] == "access-token-invalid") {
          throw UnauthenticatedException();
        }
      }
      if (res.statusCode >= 400) {
        throw Exception('Request failed: ${res.statusCode}');
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> delete(Uri url, {Map<String, String>? headers}) async {
    try {
      if (authService.accessToken == null) {
        throw UnauthenticatedException();
      }
      final newHeaders = {...?headers};
      newHeaders['Authorization'] = 'Bearer ${authService.accessToken}';

      var res = await http
          .delete(url, headers: newHeaders)
          .timeout(const Duration(seconds: 10));
      if (res.statusCode == 401) {
        final jsonRes = jsonDecode(res.body);
        if (jsonRes['message'] == "access-token-expired") {
          bool refreshed = await authService.refreshTokenRequest();
          if (refreshed) {
            newHeaders['Authorization'] = 'Bearer ${authService.accessToken}';
            return await http
                .delete(url, headers: newHeaders)
                .timeout(const Duration(seconds: 10));
          } else {
            throw UnauthenticatedException();
          }
        }
        if (jsonRes['message'] == "access-token-invalid") {
          throw UnauthenticatedException();
        }
      }
      if (res.statusCode >= 400) {
        throw Exception('Request failed: ${res.statusCode}');
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      if (authService.accessToken == null) {
        throw UnauthenticatedException();
      }
      final newHeaders = {...?headers};
      newHeaders['Authorization'] = 'Bearer ${authService.accessToken}';
      newHeaders['Content-Type'] = 'application/json';

      var res = await http.post(url, headers: newHeaders, body: body);

      if (res.statusCode == 401) {
        final jsonRes = jsonDecode(res.body);
        if (jsonRes['message'] == "access-token-expired") {
          bool refreshed = await authService.refreshTokenRequest();
          if (refreshed) {
            newHeaders['Authorization'] = 'Bearer ${authService.accessToken}';
            return await http.post(url, headers: newHeaders, body: body);
          } else {
            throw UnauthenticatedException();
          }
        }
        if (jsonRes['message'] == "access-token-invalid") {
          throw UnauthenticatedException();
        }
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.StreamedResponse> multipartrRequest(
    http.MultipartRequest request,
  ) async {
    final newHeaders = {...request.headers};
    newHeaders['Authorization'] = 'Bearer ${authService.accessToken}';
    request.headers.addAll(newHeaders);

    if (authService.accessToken == null) {
      throw UnauthenticatedException();
    }

    var res = await request.send();
    if (res.statusCode == 401) {
      final normalRes = await http.Response.fromStream(res);
      final jsonRes = jsonDecode(normalRes.body);

      if (jsonRes['message'] == "access-token-expired") {
        try {
          bool refreshed = await authService.refreshTokenRequest();
          if (!refreshed) {
            throw MulterReqException;
          }
        } catch (e) {
          rethrow;
        }
      }

      if (jsonRes['message'] == "access-token-invalid") {
        throw UnauthenticatedException();
      }

      throw MulterReqException();
    }
    return res;
  }
}
