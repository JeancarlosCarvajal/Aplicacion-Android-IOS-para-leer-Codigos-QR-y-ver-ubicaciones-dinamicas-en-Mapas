import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_buttom.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Historial')),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: (){}
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Page new'),
      ),
      bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton: ScanButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}