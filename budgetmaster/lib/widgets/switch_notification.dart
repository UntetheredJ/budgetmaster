import 'package:flutter/material.dart';
import 'package:budgetmaster/screens/service.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(light ? 'Desactivar todas las notificaciones' : 'Activar todas las notificaciones'),
    Switch(
    // This bool value toggles the switch.
    value: light,
    activeColor: Colors.blue,
    onChanged: (bool value) {
    // This is called when the user toggles the switch.
    setState(() {
    light = value;
    });

    if (value == false) {
      cancelAllNotifications();
    }




    },
    )
      ],
    );
  }
}