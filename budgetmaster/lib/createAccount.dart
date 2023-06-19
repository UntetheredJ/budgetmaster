import 'package:flutter/material.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
   _CreateAccountState createState() => _CreateAccountState();

}

class _CreateAccountState extends State<CreateAccount>{
   @override
   Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(
         backgroundColor: const Color(0xFF7B1FA2),
         centerTitle: true,
         title: const Text(
           'Creación de cuenta',
           style: TextStyle(
             fontSize: 25,
             color: Colors.white,
           ),
         ),
       ),
       body: SafeArea(

         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 250),

         child:Center(
           child: SingleChildScrollView(
             child: Column(
             children: [
                const Icon(Icons.auto_graph_rounded , size: 70, color: Colors.deepPurpleAccent,),
                const Text(
                 "Budget Master",
                 style: TextStyle(
                   fontSize: 50,
                   fontWeight: FontWeight.w900,
                   color: Colors.deepPurple,
                 ),
               ),
               const SizedBox(
                 height: 25,
               ),
               TextFormField(keyboardType: TextInputType.emailAddress,
                 decoration: const InputDecoration(
                   labelText: "Nombre",
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.account_box ),
                 ),
               ),
                const SizedBox(
                 height: 25,
               ),
               TextFormField(keyboardType: TextInputType.emailAddress,
                 decoration: const InputDecoration(
                   labelText: "Usuario",
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.account_box ),
                 ),
               ),
               const SizedBox(
                 height: 25,
               ),

               TextFormField(keyboardType: TextInputType.emailAddress,
                 decoration: const InputDecoration(
                   labelText: "Correo electrónico",
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.email),
                 ),
               ),
               const SizedBox(
                 height: 25,
               ),
               TextFormField(
                 keyboardType: TextInputType.visiblePassword,
                 obscureText: true,
                 decoration: const InputDecoration(
                   labelText: "Contraseña",
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.lock),
                   suffixIcon: Icon(Icons.remove_red_eye),
                 ),
               ),
               const SizedBox(
                 height: 25,
               ),
               TextFormField(
                 keyboardType: TextInputType.visiblePassword,
                 obscureText: true,
                 decoration: const InputDecoration(
                   labelText: "Confirmar contraseña",
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.lock),
                   suffixIcon: Icon(Icons.remove_red_eye),
                 ),
               ),
               const SizedBox(
                 height: 25,
               ),
               Container(
                 height: 60,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100),
                   gradient: const LinearGradient(colors: [Colors.blue, Colors.purple],  begin: Alignment.topRight,
                       end: Alignment.bottomLeft),

                 ),
                 child: MaterialButton(
                   onPressed: (){},
                   child: const Text(
                     "Crear Cuenta",
                     style: TextStyle(
                       fontSize: 25,
                       color: Colors.white,
                     ),
                   ),
                 ),
               ),
             ],
             ),

     ),
         ),
         ),
         ),

     );
   }
}