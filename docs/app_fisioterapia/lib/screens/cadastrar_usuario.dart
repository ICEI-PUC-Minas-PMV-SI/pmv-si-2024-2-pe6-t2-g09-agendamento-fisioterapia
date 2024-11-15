import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/services/api_service.dart';
import 'package:clinica_fisioterapia/models/user/cadastro_usuario.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  const CadastroUsuarioScreen({Key? key}) : super(key: key);

  @override
  _CadastroUsuarioScreenState createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();

  String nomeUsuario = '';
  String password = '';
  String email = '';
  String telefone = '';
  int tipo = 1;
  int perfil = 1;

  ApiService apiService = ApiService();

  Future<void> _cadastrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var novoUsuario = CadastroUsuario(
        nomeUsuario: nomeUsuario,
        password: password,
        email: email,
        telefone: telefone,
        tipo: tipo,
        perfil: perfil,
      );

      bool sucesso = await apiService.cadastrarUsuario(novoUsuario);

      if (sucesso) {
        Navigator.pushNamed(context, "cadastrarUsuario");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha ao cadastrar o usuário')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Usuário',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        // Envolva o conteúdo com SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome de Usuário',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do usuário';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nomeUsuario = value!;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a senha';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o e-mail';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Por favor, insira um e-mail válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o telefone';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    telefone = value!;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: tipo,
                  decoration:
                      const InputDecoration(labelText: 'Tipo de Usuário'),
                  onChanged: (newValue) {
                    setState(() {
                      tipo = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Admin'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Usuário'),
                    ),
                  ],
                ),
                DropdownButtonFormField<int>(
                  value: perfil,
                  decoration:
                      const InputDecoration(labelText: 'Perfil de Usuário'),
                  onChanged: (newValue) {
                    setState(() {
                      perfil = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Perfil 1'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Perfil 2'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _cadastrarUsuario,
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
