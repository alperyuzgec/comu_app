import 'dart:developer';

import 'package:comu_login/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:comu_login/model/user_response.dart';
import 'package:comu_login/profile_page.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List users = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kullanıcılar")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: ListView.separated(
            itemCount: users.length,
            padding: const EdgeInsets.only(top: 10, bottom: 10).r,
            itemBuilder: (context, index) {
              return UsersContainer(userData: users[index]);
            },
            separatorBuilder: (context, index) => 10.verticalSpace,
          ),
        ),
      ),
    );
  }

  Future<void> getUsers() async {
    Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15), sendTimeout: const Duration(seconds: 15)));
    Uri uri = Uri.parse('https://dummyjson.com/users');
    Response response = await dio.getUri(uri);
    if (response.data != null) {
      log('response data: ${response.data}');
      users = response.data['users'] as List;
      setState(() {});
    }
  }
}

class UsersContainer extends StatelessWidget {
  final Map userData;
  const UsersContainer({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20).r,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: ClipOval(
              child: ColoredBox(
                color: const Color(0xffF4CBCC),
                child: Image.network(
                  userData['image'],
                  height: 40.h,
                  width: 40.h,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData['username']),
                8.verticalSpace,
                Text("${userData['firstName']} ${userData['lastName']}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//!---------------------------------------------------------------
//!                         İKİNCİ VERSİYON
//!---------------------------------------------------------------

class UsersModelScreen extends StatefulWidget {
  const UsersModelScreen({super.key});

  @override
  State<UsersModelScreen> createState() => _UsersModelScreenState();
}

class _UsersModelScreenState extends State<UsersModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kullanıcılar")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: FutureBuilder(
            future: ApiService.getUsers(),
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
                      return UsersModelContainer(userData: data[index]);
                    },
                    separatorBuilder: (context, index) => 10.verticalSpace,
                  );
                }
              } else {
                return const Text('Bilinmeyen Hata');
              }
            },
          ),
        ),
      ),
    );
  }
}

class UsersModelContainer extends StatelessWidget {
  final User userData;
  const UsersModelContainer({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileScreen(userId: userData.id, username: userData.username,),
        ));
      },
      child: Container(
        height: 140.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20).r,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: ClipOval(
                child: ColoredBox(
                  color: const Color(0xffF4CBCC),
                  child: Image.network(
                    userData.image,
                    height: 40.h,
                    width: 40.h,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userData.username),
                    8.verticalSpace,
                    Text("${userData.firstName} ${userData.lastName}"),
                    8.verticalSpace,
                    Text(userData.university)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
