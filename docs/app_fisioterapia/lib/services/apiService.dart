import 'dart:convert';
import 'package:clinica_fisioterapia/models/user/dataUser.dart';
import 'package:clinica_fisioterapia/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:flutter/material.dart';
import '../models/journal.dart';

class ApiService {
  static const String urlApi = "http://192.168.0.17:5005/";
  static const String resource = "journals/";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  String getURL() {
    return "$urlApi$resource";
  }

  Uri getUri() {
    return Uri.parse(getURL());
  }

  Future<bool> remove(String id) async {
    Uri uri = Uri.parse('$urlApi$resource$id');

    try {
      http.Response response = await client.delete(uri);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<Journal>> buscaAgendamentos() async {
    DataUser dataUser = DataUser();
    String? userId = await dataUser.getUserId();
    final url = Uri.parse("${urlApi}Agendamentos");

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Journal> agendamentos = jsonResponse.map((agendamentoJson) {
          return Journal.fromMap(agendamentoJson);
        }).toList();
        return agendamentos;
      } else if (response.statusCode == 204 || response.body.isEmpty) {
        return [];
      } else {
        throw Exception(
            'Falha ao carregar agendamentos. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse("${urlApi}Usuario/authenticate");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      DataUser authService = DataUser();
      await authService.saveUserData(data);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registrarAgendamento(
      Journal journal, String formattedDateTime, BuildContext context) async {
    final url = Uri.parse("${urlApi}Agendamentos");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomePaciente": journal.nomePaciente,
        "dataAtendimento": formattedDateTime,
        "email": journal.emailPaciente,
        "emailMedicoResponsavel": journal.emailMedico,
      }),
    );

    return response.statusCode == 201;
  }

  Future<bool> apagarAgendamento(
      Journal journal, String formattedDateTime, BuildContext context) async {
    final url = Uri.parse("${urlApi}Agendamentos/${journal.id}");

    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomePaciente": journal.nomePaciente,
        "dataAtendimento": formattedDateTime,
        "email": journal.emailPaciente,
        "emailMedicoResponsavel": journal.emailMedico,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
