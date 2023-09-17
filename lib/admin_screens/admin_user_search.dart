import 'package:comu_login/service/api_service.dart';
import 'package:comu_login/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminUserSearchScreen extends StatefulWidget {
  final String searchText;
  const AdminUserSearchScreen({super.key, required this.searchText});

  @override
  State<AdminUserSearchScreen> createState() => _AdminUserSearchScreenState();
}

class _AdminUserSearchScreenState extends State<AdminUserSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.searchText)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: FutureBuilder(
          future: ApiService.searchUser(widget.searchText),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Hatalı Arama Yaptınız. Lütfen tekrar deneyiniz'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != null) {
              var data = snapshot.data!;
              if (data.isNotEmpty) {
                return ListView.separated(
                  itemCount: data.length,
                  padding: const EdgeInsets.only(top: 10, bottom: 10).r,
                  itemBuilder: (context, index) {
                    return UsersModelContainer(userData: data[index]);
                  },
                  separatorBuilder: (context, index) => 10.verticalSpace,
                );
              } else {
                return const Center(child: Text('Aradığınız kriterlere göre Kullanıcı bulunamadı'));
              }
            } else {
              return const Center(child: Text('Unknown Error'));
            }
          },
        ),
      ),
    );
  }
}
