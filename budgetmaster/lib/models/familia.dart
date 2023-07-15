import 'package:budgetmaster/models/usuario.dart';

class Familia {
  String id_familia;
  String nombre;
  int total_ahorrado;
  int saldo_total;
  int gasto_total;
  List<Usuario> miembros;

  Familia(
      this.id_familia,
      this.nombre,
      this.total_ahorrado,
      this.saldo_total,
      this.gasto_total,
      this.miembros
      );
}