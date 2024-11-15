import 'package:clinica_fisioterapia/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/user/usuarios.dart';

class ApagarUsuario extends StatefulWidget {
  const ApagarUsuario({Key? key}) : super(key: key);

  @override
  _ApagarUsuarioState createState() => _ApagarUsuarioState();
}

class _ApagarUsuarioState extends State<ApagarUsuario> {
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _apagarUsuario(Usuarios usuario) async {
    bool sucesso = await apiService.apagarUsuario(usuario, context);
    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário apagado com sucesso!')),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao apagar o usuário')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apagar Usuarios',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "home");
          },
        ),
      ),
      body: FutureBuilder<List<Usuarios>>(
        future: apiService.trazUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os usuários.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum usuário para apagar'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Usuarios usuario = snapshot.data![index];

                return ListTile(
                  title: Text(
                    usuario.nomeUsuario,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    usuario.email,
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => _apagarUsuario(usuario),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
