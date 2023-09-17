import 'dart:developer';

import 'package:comu_login/profile_page.dart';
import 'package:comu_login/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:comu_login/model/post_model.dart';

class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({super.key});

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(title: const Text("Gönderiler")),
      body: SafeArea(
        child: FutureBuilder(
            future: fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text('Bağlantı hatası');
              } else if (snapshot.hasData) {
                var data = snapshot.data;
                if (data == null) {
                  return const Text('Hiçbir veri ulaşmadı');
                } else if (data.isEmpty) {
                  return const Text('İçerik Bulunamadı');
                } else {
                  return ListView.separated(
                    itemCount: data.length,
                    padding: const EdgeInsets.only(top: 10, bottom: 10).r,
                    itemBuilder: (context, index) {
                      return PostWidget(
                        postData: data[index],
                      );
                    },
                    separatorBuilder: (context, index) => 20.verticalSpace,
                  );
                }
              } else {
                return const Text('Bilinmeyen Hata');
              }
            }),
      ),
    );
  }

  Future<List<Post>> fetchPosts() async {
    List<Post> postList = [];
    Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15), sendTimeout: const Duration(seconds: 15)));

    /// POSLAR LİNKİ https://dummyjson.com/users/{user_id}/posts
    Uri uri = Uri.parse('https://dummyjson.com/posts');
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

class PostWidget extends StatelessWidget {
  final Post postData;
  const PostWidget({
    super.key,
    required this.postData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).r,
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10).r,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12).r,
          child: Column(
            children: [
              FutureBuilder(
                future: ApiService.fetchUser(postData.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(userId: snapshot.data!.id, username: snapshot.data!.username),
                        ));
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data!.image),
                              ),
                            ),
                          ),
                          12.horizontalSpace,
                          Text(snapshot.data!.username)
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox(height: 40);
                  }
                },
              ),
              const Divider(),
              Text(
                postData.body,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PostWidget2 extends StatelessWidget {
  final int userId;
  final String body;
  const PostWidget2({
    super.key,
    required this.userId,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).r,
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10).r,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12).r,
          child: Column(
            children: [
              FutureBuilder(
                future: ApiService.fetchUser(userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(userId: snapshot.data!.id, username: snapshot.data!.username),
                        ));
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data!.image),
                              ),
                            ),
                          ),
                          12.horizontalSpace,
                          Text(snapshot.data!.username)
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox(height: 40);
                  }
                },
              ),
              const Divider(),
              Text(
                body,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
