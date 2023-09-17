import 'dart:developer';

import 'package:comu_login/admin_screens/admin_home.dart';
import 'package:comu_login/menu_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Map? user;
bool isAdmin = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  var titleTextStyle = TextStyle(color: const Color(0xff283181), fontSize: 14.sp);
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;
  bool checkBox = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: SingleChildScrollView(
            child: Column(
              children: [
                10.verticalSpace,
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      "images/18martuni.jpg",
                      width: 120.w,
                      height: 120.w,
                    ),
                  ),
                ),
                65.verticalSpace,
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8).r,
                    border: Border.all(
                      color: const Color(0xffC6C6C6),
                    ),
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(color: const Color(0xffC91C23), borderRadius: BorderRadius.circular(12)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(fontSize: 14.sp),
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
                    onTap: (value) {
                      setState(() {});
                    },
                    tabs: const [Tab(text: "Kullanıcı"), Tab(text: "Admin")],
                  ),
                ),
                32.verticalSpace,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Kullanıcı Adı",
                    style: titleTextStyle,
                  ),
                ),
                7.verticalSpace,
                TextFormField(
                  controller: usernameController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "Kullancı Adı",
                    filled: true,
                    fillColor: Colors.white,
                    helperText: tabController.index == 0 ? 'atuny0' : 'ggude7',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12).r,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffc6c6c6), width: 1),
                    ),
                  ),
                ),
                15.verticalSpace,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Şifre",
                    style: titleTextStyle,
                  ),
                ),
                7.verticalSpace,
                TextFormField(
                  controller: passwordController,
                  obscureText: isObscure,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: "******",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    helperText: tabController.index == 0 ? '9uQFF1Lh' : 'MWwlaeWcOoF6',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12).r,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffc6c6c6), width: 1),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () {
                    setState(() {
                      checkBox = !checkBox;
                    });
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: checkBox,
                        onChanged: (value) {
                          setState(() {
                            checkBox = !checkBox;
                          });
                        },
                      ),
                      const Text('Beni Hatırla'),
                    ],
                  ),
                ),
                20.verticalSpace,
                ElevatedButton(
                  onPressed: () async {
                    if (isLoading == false) {
                      await login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC91C23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8).r,
                    ),
                  ),
                  child: const Center(child: Text("Giriş Yap")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 15)));
    Uri uri = Uri.parse('https://dummyjson.com/auth/login');

    Response response = await dio.postUri(uri, data: {'username': usernameController.text, 'password': passwordController.text});
    log('Giriş Başarılı: ${response.data}');
    user = response.data as Map;
    isLoading = false;
    setState(() {});
    if (tabController.index == 1) {
      // ADMIN TAB SEÇİLİYSE
      if (user!['id'] == 8) {
        // eğer 8. kullanıcı ise DOĞRU GİRİLME DURUMU
        isAdmin = true;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AdminHomePage()),
        );
      } else {
        // yetkisiz kullanıcı durumu
      }
    } else {
      if (user!['id'] != 8) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MenuScreen()),
        );
      } else {
        //admin kullanıcı girişi
        tabController.animateTo(1);
        // admin girişi uyarısı
      }
    }

    // catch (error) {
    //   log('ERROR', error: error);
    //   rethrow;
    //   setState(() {
    //     isLoading = false;
    //   });
    //   // showDialog(
    //   //   context: context,
    //   //   builder: (context) => Center(
    //   //     child: AlertDialog(
    //   //       title: const Text('Hatalı Giriş'),
    //   //       content: const Text('Kullanıcı Adı Veya Şifre Hatalı'),
    //   //       scrollable: true,
    //   //       actions: [
    //   //         TextButton(
    //   //           onPressed: () {
    //   //             Navigator.pop(context);
    //   //           },
    //   //           child: const Text('Kapat'),
    //   //         ),
    //   //       ],
    //   //     ),
    //   //   ),
    //   // );
    // }
  }
}
