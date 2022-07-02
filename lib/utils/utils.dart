


import 'package:flutter/cupertino.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';


// ScanModel scan contiene la informacion del scan 
launcherUrl( BuildContext context, ScanModel scan ) async {

  if(scan.tipo == 'http'){
    final String url = scan.valor; // obtenermos el string de la url
    final Uri uri = Uri.parse(url); // tomamos el string y lo convertimos en formato Uri  
    // funcion propia del paquete
    if (!await launchUrl(uri) ) throw 'Could not launch $uri';
  }else{
    // print('Soy Geooo !!!!');
    // llamamos la funcion Navigator.pushName() para enviar los datos de donde quiero ir, el context y muy importante los datos de scan que contiene la informacion
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }


}