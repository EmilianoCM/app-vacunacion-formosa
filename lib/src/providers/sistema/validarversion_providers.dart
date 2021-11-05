import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sistema_vacunacion/src/config/config.dart';
import 'package:sistema_vacunacion/src/models/models.dart';

class _ValidacionVersion {
  Future<List<Version>> procesarRespuesta(Uri url) async {
    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final decodedData = json.decode(resp.body);
        final version = Version.fromJsonList(decodedData['versiones']);

        return version.items;
      }
    } catch (e) {
      throw 'Hubo un error $e';
    }

    throw 'Hubo un error mas jodido';
  }

  Future validarVersion() async {
    final url = Uri(
      scheme: scheme,
      host: host,
      path: urlValVersion,
    );

    final List<Version> resp = await procesarRespuesta(url);
    if (resp.isNotEmpty) {
      return resp[0].sysappl01_version;
    } else {
      return 0;
    }
  }

  Future validarVersionNuevaVersion(String nombreapp, String versionApp) async {
    final url = Uri(
        scheme: 'https',
        host: 'dh.formosa.gob.ar',
        path: '/modulos/webservice/php/version_2_0/wserv_versiones_app.php',
        queryParameters: {
          'sysappl01_nombre': nombreapp,
          'sysappl01_version': versionApp,
        });

    final List<Version> resp = await procesarRespuesta(url);
    if (resp.isNotEmpty) {
      return resp[0].sysappl01_version;
    } else {
      return 0;
    }
  }
}

final validacionVersionProvider = _ValidacionVersion();
