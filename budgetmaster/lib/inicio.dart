import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7B1FA2),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Inicio",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Center(
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Hola ",
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                                const Text(
                                  "Juan David",
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.purple,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                    )
                )
            ),
        ),
    );
  }
}