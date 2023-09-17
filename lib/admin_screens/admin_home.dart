import 'package:comu_login/admin_screens/admin_user_search.dart';
import 'package:comu_login/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Ekranı')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: Column(
          children: [
            20.verticalSpace,
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Kullanıcı Ara',
                helperText: 'Aramak İstediğiniz İsmi Giriniz',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            FilledButton(
              onPressed: () {
                if (controller.text.length > 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AdminUserSearchScreen(searchText: controller.text),
                  ));
                } else {}
              },
              child: const  Text('Kullanıcı Ara'),
            ),
            SizedBox(height: 60),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UsersModelScreen(),
                ));
              },
              child: const Text('Tüm Kullanıcılar'),
            ),
          ],
        ),
      ),
    );
  }
}
