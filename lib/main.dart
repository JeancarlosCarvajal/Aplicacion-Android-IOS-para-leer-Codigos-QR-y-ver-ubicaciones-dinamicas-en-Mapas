import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapa_page.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ // el multiprovider necesita varios proveedores de informmacion
        // En nuestro arbol de Widget ahora vamos a tener una instancia llamada UiProvider que usaremos a requerimiento
        ChangeNotifierProvider(create: ( _ ) => new UiProvider()),// Agrega el notify provider que creamos para que sea escuchado
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': ( _ ) => HomePage(),
          'mapa': ( _ ) => MapaPage(),
        },
        theme: AppTheme.lightTheme,
      ),
    );
  }
}