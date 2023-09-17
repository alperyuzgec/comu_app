import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  String qrValue = 'Alper';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Qr Kod Ekranı")),
      body: Column(
        children: [
          SizedBox(width: 1.sw, height: 40.h),
          QrImageView(
            data: qrValue,
            size: 200.w,
          ),
          Text('QR Value: $qrValue'),
          21.verticalSpace,
          const Divider(),
          const Text("Qr Kod İçin Tıklayınız"),
          ElevatedButton(
            onPressed: () async {
              await FlutterBarcodeScanner.scanBarcode(
                '#ff6666',
                'İptal',
                true,
                ScanMode.QR,
              ).then(
                (value) {
                  if (value != '-1') {
                    qrValue = value;
                  }
                },
              );
              setState(() {});
            },
            child: const Text("Qr CODE"),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
