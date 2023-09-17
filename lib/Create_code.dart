import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQrCodeScreen extends StatefulWidget {
  const CreateQrCodeScreen({super.key});

  @override
  State<CreateQrCodeScreen> createState() => _CreateQrCodeScreenState();
}

class _CreateQrCodeScreenState extends State<CreateQrCodeScreen> {
  TextEditingController controller = TextEditingController();
  String qrDeger = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr Kod Oluşturucu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: Column(
            children: [
              SizedBox(width: 1.sw, height: 40.h),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    qrDeger = value;
                  });
                },
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Qr Oluştur',
                  helperText: 'Oluşturmak istediğiniz kelimeyi girin',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.qr_code_2),
                ),
              ),
              50.verticalSpace,
              QrImageView(
                data: qrDeger,
                size: 200.w,
              ),
              Text('QR Value: $qrDeger'),
            ],
          ),
        ),
      ),
    );
  }
}
