class Usuario{
  String id_usuario;
  String nombre;
  String usuario;
  String contrasenna;
  int saldo_total;
  int total_ahorrado;
  int total_gastos;
  int total_ingresos;

  Usuario(
      this.id_usuario,
      this.nombre,
      this.usuario,
      this.contrasenna,
      this.saldo_total,
      this.total_ahorrado,
      this.total_gastos,
      this.total_ingresos
      );

  Usuario.sinDatos():
      id_usuario = 'null', nombre = 'null', usuario = 'null', contrasenna = 'null', saldo_total = 0, total_ahorrado = 0, total_gastos = 0, total_ingresos = 0;
}