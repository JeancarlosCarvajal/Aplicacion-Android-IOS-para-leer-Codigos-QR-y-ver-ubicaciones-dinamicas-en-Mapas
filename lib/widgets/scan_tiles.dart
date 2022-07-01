import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/theme/app_theme.dart';

class ScanTiles extends StatelessWidget {

  final IconData icon;
  
  const ScanTiles({Key? key, 
    required this.icon
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // una pista cuando estemo dentro de un build se coloca el Listen y en lo metodos (funciones) no se coloca
    final scanListProvider = Provider.of<ScanListProvider>(context); // Aqui necesito volver a redibujar el canvas
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length, // scans es un array
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),// UniqueKey() crea un key unico funcion propia de flutter, permite moverlo por los lado como se se pegara al arrastre y se elimina de la lista visible
        background: Container(
          color: AppTheme.unactiveLight,
        ),
        onDismissed: (DismissDirection direction) => Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId(scans[i].id!), // evento que se utiliza cuando se hace eliminacion al arrastrar el elemento a los lados
        child: ListTile(
          leading: Icon(icon, color: AppTheme.activeLight),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right, color: AppTheme.unactiveLight),
          onTap: () => print('Valores de ID: ${scans[i].id}'), // evento al hacer click en la lista  
        ),
      ), 
    );
  }
}