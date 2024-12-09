class Usuarios {
  int id;
  String nomeUsuario;
  String email;

  Usuarios({
    required this.id,
    required this.nomeUsuario,
    required this.email,
  });
  factory Usuarios.fromMap(Map<String, dynamic> map) {
    return Usuarios(
      id: map['id'],
      nomeUsuario: map['nomeUsuario'],
      email: map['email'],
    );
  }
}
