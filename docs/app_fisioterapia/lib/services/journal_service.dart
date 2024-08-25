import 'dart:convert';
import 'package:clinica_fisioterapia/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:flutter/material.dart'; // Para mostrar mensagens de erro

import '../models/journal.dart';

class JournalService {
  // Seu IP e porta do json-server
  static const String url = "http://192.168.0.17:3000/";
  static const String resource = "journals/";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  String getURL() {
    return "$url$resource";
  }

  Uri getUri() {
    return Uri.parse(getURL());
  }

  Future<bool> register(Journal journal, BuildContext context) async {
    String journalJSON = json.encode(journal.toMap());

    try {
      http.Response response = await client.post(
        getUri(),
        headers: {'Content-type': 'application/json'},
        body: journalJSON,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        // Log error or handle it as needed
        _showError(
            "Não foi possível registrar o diário. Verifique sua conexão.",
            context);
        return false;
      }
    } catch (e) {
      // Handle connection errors or other exceptions
      _showError("Não foi possível registrar o diário. Verifique sua conexão.",
          context);
      return false;
    }
  }

  Future<List<Journal>> getAll(BuildContext context) async {
    try {
      http.Response response = await client.get(getUri());

      if (response.statusCode != 200) {
        _showError(
            "Não foi possível carregar os diários. Verifique sua conexão.",
            context);
        return []; // Retorna uma lista vazia em caso de erro
      }

      List<Journal> result = [];
      List<dynamic> jsonList = json.decode(response.body);
      for (var jsonMap in jsonList) {
        result.add(Journal.fromMap(jsonMap));
      }

      return result;
    } catch (e) {
      _showError(
          "Não foi possível conectar ao servidor. Verifique sua conexão.",
          context);
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  Future<bool> remove(String id) async {
    // Cria a URI para o item específico com base no ID
    Uri uri = Uri.parse('$url$resource$id');

    try {
      // Envia a solicitação DELETE para o servidor
      http.Response response = await client.delete(uri);

      if (response.statusCode == 200) {
        return true; // Retorna true se a remoção for bem-sucedida
      } else {
        return false; // Retorna false se a remoção falhar
      }
    } catch (e) {
      return false; // Retorna false em caso de erro
    }
  }

  void _showError(String message, BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
  }
}
