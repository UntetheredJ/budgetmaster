import 'package:flutter/material.dart';

class InicioWidget extends StatelessWidget {
  final ScrollController controller;

  const InicioWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: <Widget>[
          const SizedBox(height: 12),
          buildDragHandle(),
          const SizedBox(height: 4),
          buildPagos(),
          const SizedBox(height: 24),
        ],
      );

  Widget buildPagos() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Text("Próximos Pagos",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
            SizedBox(height: 12),
            Text("¡Este es un pago próximo!"),
            SizedBox(height: 12),
            Text("¡Este es otro pago próximo!"),
            SizedBox(height: 12),
            Text("¡Este es otro pago próximo!"),
          ],
        ),
      );

  Widget buildDragHandle() => Center(
          child: Container(
        width: 30,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12)
        ),
      ));
}
