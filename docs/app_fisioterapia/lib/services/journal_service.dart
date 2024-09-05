import 'dart:convert';
import 'package:clinica_fisioterapia/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:flutter/material.dart';
import '../models/journal.dart';

class JournalService {
  static const String url =
      "http://192.168.0.21:3000/"; 
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

  Future<List<Journal>> tentarConexao() async {
    final uri = Uri.parse('$url$resource');
    print('Attempting to connect to: $uri');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Journal.fromMap(json)).toList();
      } else {
        throw Exception('Falha ao carregar journals: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao conectar ao servidor: $e');
    }
  }

  Future<bool> registro(Journal journal, BuildContext context) async {
    journal.status = "pendente";
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
        _showError(
            "Não foi possível registrar o diário. Verifique sua conexão.",
            context);
        return false;
      }
    } catch (e) {
      _showError("Não foi possível registrar o diário. Verifique sua conexão.",
          context);
      return false;
    }
  }

  Future<bool> aceitaHorario(Journal journal) async {
    journal.status = "aceito";
    String journalJSON = json.encode(journal.toMap());

    try {
      Uri uri = Uri.parse('$url$resource${journal.id}');
      http.Response response = await client.put(
        uri,
        headers: {'Content-type': 'application/json'},
        body: journalJSON,
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejeitaHorario(Journal journal) async {
    Uri uri = Uri.parse('$url$resource${journal.id}');

    journal.status = "rejeitado";
    String journalJSON = json.encode(journal.toMap());

    try {
      http.Response response = await client.delete(uri);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<Journal>> buscaHorarioPendente() async {
    try {
      Uri uri = Uri.parse('${getURL()}?status=pendente');
      http.Response response = await client.get(uri);

      if (response.statusCode != 200) {
        throw Exception("Erro ao carregar os horários pendentes.");
      }

      List<Journal> result = [];
      List<dynamic> jsonList = json.decode(response.body);
      for (var jsonMap in jsonList) {
        result.add(Journal.fromMap(jsonMap));
      }

      return result;
    } catch (e) {
      // Handle errors as needed, here simply returning an empty list
      return [];
    }
  }

  Future<List<Journal>> carregaCalendario(BuildContext context) async {
    try {
      http.Response response = await client.get(getUri());

      if (response.statusCode != 200) {
        _showError(
            "Não foi possível carregar os diários. Verifique sua conexão.",
            context);
        return [];
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
      return [];
    }
  }

  Future<bool> remove(String id) async {
    Uri uri = Uri.parse('$url$resource$id');

    try {
      http.Response response = await client.delete(uri);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void _showError(String message, BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
  }
}
