class Usuario{
  String id_usuario;
  String nombre;
  String usuario;
  String contrasenna;
  int saldo_total;
  int total_ahorrado;

  Usuario(
      this.id_usuario,
      this.nombre,
      this.usuario,
      this.contrasenna,
      this.saldo_total,
      this.total_ahorrado
      );

  Usuario.sinDatos():
      id_usuario = 'null', nombre = 'null', usuario = 'null', contrasenna = 'null', saldo_total = 0, total_ahorrado = 0;
}