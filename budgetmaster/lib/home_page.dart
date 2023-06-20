import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:budgetmaster/inicio.dart';
import 'package:budgetmaster/configuracion.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends  State<HomePage>{
  int index=1;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        color: Colors.deepPurple.shade200,
        animationDuration: const Duration(milliseconds:300),
        items: const [
          Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 40,),
          Icon(Icons.home,color: Colors.white,  size: 40),
          Icon(Icons.settings,color: Colors.white,  size: 40),
        ],
        index: index,
        onTap: (selectedIndex){
          setState(() {
            index = selectedIndex;
          });
        },

      ),
      body: Container(
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index)
      ),
    );

  }

Widget getSelectedWidget({required int index}){
  Widget widget;
  switch(index){
    case 0:
      widget = const Ini();
      break;
    case 1:
      widget = const Ini();
      break;
    case 2:
      widget = const Conf();
      break;

      default:
    widget = const Ini();
    break;
  }
  return widget;
}
}