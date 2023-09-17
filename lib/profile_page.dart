import 'package:comu_login/login_page.dart';
import 'package:comu_login/model/post_model.dart';
import 'package:comu_login/model/user_response.dart';
import 'package:comu_login/service/api_service.dart';
import 'package:comu_login/shipments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;
  final String username;
  const ProfileScreen(
      {super.key, required this.userId, required this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(title: Text(widget.username)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: ApiService.fetchUser(widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Bağlantı Hatası');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    User u = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          10.verticalSpace,
                          ProfileSection(
                            title: 'Kişisel Bilgiler',
                            children: [
                              ProfileInfoWidget(
                                  title: 'Yaş', value: u.age.toString()),
                              ProfileInfoWidget(
                                title: 'Doğum Tarihi',
                                value:
                                    '${u.birthDate.day.toString().padLeft(2, "0")}/${u.birthDate.month.toString().padLeft(2, "0")}/${u.birthDate.year}',
                              ),
                              ProfileInfoWidget(
                                  title: 'Cinsiyet', value: u.gender),
                              ProfileInfoWidget(
                                  title: 'Kan Grubu', value: u.bloodGroup),
                            ],
                          ),
                          21.verticalSpace,
                          ProfileSection(
                            title: 'İletişim Bilgileri',
                            children: [
                              ProfileInfoWidget(title: 'Email', value: u.email),
                              ProfileInfoWidget(
                                  title: 'Telefon', value: u.phone),
                            ],
                          ),
                          21.verticalSpace,
                          ProfileSection(
                            title: 'Adres Bilgileri',
                            children: [
                              ProfileInfoWidget(
                                  title: 'Eyalet', value: u.address.state),
                              ProfileInfoWidget(
                                  title: 'Şehir', value: u.address.city),
                              ProfileInfoWidget(
                                  title: 'Adres', value: u.address.address),
                              ProfileInfoWidget(
                                  title: 'Posta Kodu',
                                  value: u.address.postalCode),
                              FilledButton(
                                onPressed: () async {
                                  await MapsLauncher.launchCoordinates(
                                      u.address.coordinates.lat,
                                      u.address.coordinates.lng);
                                },
                                style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8).r,
                                  ),
                                ),
                                child: const Center(
                                    child: Text('Haritada Göster')),
                              )
                            ],
                          ),
                          20.verticalSpace,
                        ],
                      ),
                    );
                  } else {
                    return const Text('Bilinmeyen Hata');
                  }
                },
              ),
              isAdmin
                  ? Column(
                      children: [
                        Text(
                          'Kullanıcı Gönderileri',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        12.verticalSpace,
                        FutureBuilder(
                          future: ApiService.userPosts(widget.userId),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Bağlantı Hatası');
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              List<Post> posts = snapshot.data!;
                              return ListView.separated(
                                itemCount: posts.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    PostWidget(postData: posts[index]),
                                separatorBuilder: (context, index) =>
                                    12.verticalSpace,
                              );
                            } else {
                              return const Text('Bilinmeyen Hata');
                            }
                          },
                        ),
                      ],
                    )
                  : const SizedBox(),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final List<Widget> children;
  final String title;
  const ProfileSection({
    super.key,
    required this.children,
    required this.title,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).r,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              const Divider(),
              ...children
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  const ProfileInfoWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: TextStyle(fontSize: 16.sp),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
