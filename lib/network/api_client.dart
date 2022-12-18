import 'dart:convert';

import 'package:http/http.dart';
import 'package:second_course_project/web/top_users.dart';
import 'package:second_course_project/web/user_web.dart';

class ApiClient {
  final server = '10.0.2.2:8000';

  Future<dynamic> get({required String ulr, required String token}) async {
    var client = Client();
    Map<String, dynamic> decodedResponse;
    try {
      var response = await client.get(Uri.http(server, ulr), headers: {'Authorization': 'Token $token'});
      final errors = checkErrors(response);
      if (errors != '') {
        client.close();
        return errors;
      }
      decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    } finally {
      client.close();
    }

    return UserWeb.fromJson(decodedResponse);
  }

  Future<dynamic> getTop5() async {
    var client = Client();
    List<TopUsers> users;
    try {
      var response = await client.get(Uri.http(server, 'api/top_five_ranking/'));
      final errors = checkErrors(response);
      if (errors != '') {
        client.close();
        return errors;
      }
      Iterable list = json.decode(response.body);
      users = list.map((model) => TopUsers.fromJson(model)).toList();
    } finally {
      client.close();
    }

    return users;
  }

  Future<dynamic> createUser({required String email, required String password}) async {
    var client = Client();
    Map<String, dynamic> decodedResponse;
    try {
      var response = await client.post(
        Uri.http(server, 'api/auth/users/'),
        body: {
          'email': email,
          'password': password,
        },
      );
      final errors = checkErrors(response);
      if (errors != '') {
        client.close();
        return errors;
      }
      decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    } finally {
      client.close();
    }
    return UserWeb.fromJson(decodedResponse);
  }

  String checkErrors(Response response) {
    if (response.statusCode >= 400 && response.statusCode < 500) {
      final tmp = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (tmp.isNotEmpty) {
        if (tmp['email'] != null) {
          return tmp['email'][0];
        } else if (tmp['non_field_errors'] != null) {
          return tmp['non_field_errors'][0];
        }
      }
      return response.body;
    } else if (response.statusCode >= 500) {
      return ('При отправке запроса произошла ошибка сервера. Попробуйте позже');
    }
    return '';
  }

  Future<dynamic> authUser({required String email, required String password}) async {
    var client = Client();
    Map<String, dynamic> decodedResponse;
    try {
      var response = await client.post(
        Uri.http(server, 'api/auth/token/login/'),
        body: {
          'email': email,
          'password': password,
        },
      );
      final errors = checkErrors(response);
      if (errors != '') {
        client.close();
        return errors;
      }
      decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    } finally {
      client.close();
    }

    return get(
      ulr: 'api/auth/profile/',
      token: decodedResponse['auth_token'],
    );
  }

  Future<void> updateUser(UserWeb user) async {
    var client = Client();
    await client.post(
      Uri.http(server, 'api/auth/profile/'),
      body: {
        'auth_token': user.token,
        'level': user.level.toString(),
        'exp': user.exp.toString(),
        'needExpToNextLevel': user.needExpToNextLevel.toString(),
      },
      headers: {'Authorization': 'Token ${user.token}'},
    );
    client.close();
  }

  Future<dynamic> updateUser2(String token, String name, String email, String password) async {
    var client = Client();
    var response = await client.post(
      Uri.http(server, 'api/auth/profile/'),
      body: {
        'auth_token': token,
        'name': name,
        'email': email,
        'password': password,
      },
      headers: {'Authorization': 'Token $token'},
    );
    final errors = checkErrors(response);
    if (errors != '') {
      client.close();
      return errors;
    }
    client.close();
    Map<String, dynamic> decodedResponse;
    decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return UserWeb.fromJson(decodedResponse);
  }
}
