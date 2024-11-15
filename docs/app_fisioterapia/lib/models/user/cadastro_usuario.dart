class CadastroUsuario {
  String nomeUsuario;
  String password;
  String email;
  String telefone;
  int tipo;
  int perfil;
  CadastroUsuario(
      {required this.nomeUsuario,
      required this.password,
      required this.email,
      required this.telefone,
      required this.tipo,
      required this.perfil});
}
