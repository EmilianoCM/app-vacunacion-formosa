import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sistema_vacunacion/src/config/appconst_config.dart';
import 'dart:convert';

import 'package:sistema_vacunacion/src/models/models.dart';

class _LotesVacunaProviders {
  // ignore: missing_return
  Future<List<Lotes>> procesarRespuestaDos(Uri url) async {
    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final decodedData = json.decode(resp.body);
        final lotes = Lotes.fromJsonList(decodedData['lotes_vacunas']);
        return lotes.items;
      }
    } catch (e) {
      throw 'Ocurrio un error $e';
    }

    throw 'Ocurrio un error';
  }

  Future validarLotes(String? idVacu) async {
    final url =
        Uri(scheme: scheme, host: host, path: urlLoteVacu, queryParameters: {
      'id_sysvacu04': idVacu,
    });

    final List<Lotes> resp = await procesarRespuestaDos(url);
    return resp;
  }
}

final lotesVacunaProvider = _LotesVacunaProviders();
