import 'package:flutter/material.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text('Configuración', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          CircleAvatar(
            radius: 70,
            child: Icon(Icons.settings, size: 120,),
          ),
          SizedBox(height: 100,),
          Text('Contenido', style: TextStyle(fontSize: 30, color: Colors.white),),
        ],
      ),
    );
  }
}