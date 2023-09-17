import 'dart:developer';

import 'package:comu_login/model/user_response.dart';
import 'package:dio/dio.dart';

import '../model/post_model.dart';

class ApiService {
  ApiService._();

  static Future<List<User>> getUsers() async {
    List<User> list = [];
    Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15), sendTimeout: const Duration(seconds: 15)));
    Uri uri = Uri.parse('https://dummyjson.com/users');
    Response response = await dio.getUri(uri);
    if (response.data != null) {
      log('response data: ${response.data}');
      var users = response.data['users'] as List;
      for (var u in users) {
        list.add(User.fromMap(u));
      }
    }
    return list;
  }

  static Future<User?> fetchUser(int id) async {
    User user;
    Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    Uri uri = Uri.parse('https://dummyjson.com/users/$id');

    Response response = await dio.getUri(uri);
    if (response.data != null) {
      user = User.fromMap(response.data);
      return user;
    } else {
      return null;
    }
  }

  static Future<List<User>> searchUser(String search) async {
    List<User> userList = [];
    Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    Uri uri = Uri.parse('https://dummyjson.com/users/search?q=$search');

    Response response = await dio.getUri(uri);
    if (response.data != null) {
      log('response data: ${response.data}');
      var users = response.data['users'] as List;
      for (var u in users) {
        userList.add(User.fromMap(u));
      }
    }
    return userList;
  }

  static Future<List<Post>> userPosts(int userId) async {
    List<Post> postList = [];
    Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15), sendTimeout: const Duration(seconds: 15)));
    Uri uri = Uri.parse('https://dummyjson.com/users/$userId/posts');
    Response response = await dio.getUri(uri);
    if (response.data != null) {
      log('response data: ${response.data}');
      var post = response.data['posts'] as List;
      for (var p in post) {
        postList.add(Post.fromMap(p));
      }
    }
    return postList;
  }
}
