import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/theme/app_theme.dart';
import 'package:qr_reader/utils/utils.dart';
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

        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(AppTheme.activeLightQR, 'Cancelar', false, ScanMode.QR);
        // const barcodeScanRes = 'https://nftlatinoamerica.com/'; // 10.1920459,-64.6836107
        const barcodeScanRes = 'geo:10.1920459,-64.6836107'; // 10.1920459,-64.6836107

        if(barcodeScanRes == '-1') {
          return;
        } 
        // para obtener los datos en el arbol de widgets
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false); // listen false pa que no se redibuje no lo necesitamos
        // Accedemos a los metodos del scanListProvider para introducir el barcodeScanRes obtenido del lector dentro de la base de datos
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        // lanzamos de una vez la direccion url que leyo el lector QR
        launcherUrl(context, nuevoScan);
        
        print('Respuesta del QR: $barcodeScanRes');

      }    
    );
  }
}