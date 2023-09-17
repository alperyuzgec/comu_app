import 'package:comu_login/qr_page.dart';
import 'package:comu_login/login_page.dart';
import 'package:comu_login/shipments_page.dart';
import 'package:comu_login/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_code.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(title: Text("Hoş Geldiniz, ${user?['firtName']} ${user?['lastName']}")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: SingleChildScrollView(
            child: Column(
              children: [
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UsersModelScreen()));
                  },
                  child: Container(
                    height: 126.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: const Color(0xff283281).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        height: 46.w,
                        width: 46.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffC91C23),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          size: 32.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Kullanıcılar",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      )
                    ]),
                  ),
                ),
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ShipmentsScreen()));
                  },
                  child: Container(
                    height: 126.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: const Color(0xff283281).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 46.w,
                          width: 46.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffC91C23),
                          ),
                          child: Icon(
                            Icons.sticky_note_2,
                            size: 32.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Gönderiler",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QrCodeScreen()));
                  },
                  child: Container(
                    height: 126.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: const Color(0xff283281).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        height: 46.w,
                        width: 46.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffC91C23),
                        ),
                        child: Icon(
                          Icons.qr_code,
                          size: 32.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Qr Kod",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      )
                    ]),
                  ),
                ),
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateQrCodeScreen()));
                  },
                  child: Container(
                    height: 126.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: const Color(0xff283281).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        height: 46.w,
                        width: 46.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffC91C23),
                        ),
                        child: Icon(
                          Icons.qr_code,
                          size: 32.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Kendi Qr Kodunu Oluştur",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
