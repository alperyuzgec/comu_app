// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';

class Post {
  String body;
  int userId;
  Post({
    required this.body,
    required this.userId,
  });

  Post copyWith({
    String? body,
    int? userId,
  }) {
    return Post(
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'userId': userId,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      body: map['body'] as String,
      userId: map['userId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Post(body: $body, userId: $userId)';

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.body == body && other.userId == userId;
  }

  @override
  int get hashCode => body.hashCode ^ userId.hashCode;
}

Future<List<Post>> getAllPost() async {
  List<Post> postList = [];
  Dio dio = Dio(BaseOptions());
  Uri uri = Uri.parse('https://dummyjson.com/posts');
  Response response = await dio.getUri(uri);
  if (response.data != null) {
    List tempList = response.data['posts'];
    for (var p in tempList) {
      postList.add(Post.fromMap(p));
    }
  } else {}
  return postList;
}
