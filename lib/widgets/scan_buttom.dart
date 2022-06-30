import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_reader/theme/app_theme.dart';

class ScanButtom extends StatelessWidget {
   
  const ScanButtom({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(AppTheme.activeLightQR, 'Cancelar', false, ScanMode.QR);
        print('Respuesta del QR: $barcodeScanRes');

      }    
    );
  }
}