import 'package:flutter/material.dart';
import 'package:budgetmaster/screens/login_screen.dart';
import 'package:budgetmaster/db/supabaseConnection.dart';

void main() async {
  await SupabaseService().initialize();
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7B1FA2),
          centerTitle: true,
          title: const Text(
            'Inicio de Sesión',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
         body: LoginScreen(),
      ),
    );
  }
}
