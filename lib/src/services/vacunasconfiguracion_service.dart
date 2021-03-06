import 'dart:async';

import 'package:sistema_vacunacion/src/models/models.dart';

class _VacunasConfiguracion {
  ConfiVacuna? _vacunasConfiguracion;

  List<ConfiVacuna>? _listavacunasConfiguracion = [];

  List<ConfiVacuna>? _listavacunasConfiguracionBusqueda = [];

  final StreamController<ConfiVacuna?> _vacunasConfiguracionStreamController =
      StreamController<ConfiVacuna?>.broadcast();

  ConfiVacuna? get vacunasConfiguracion => _vacunasConfiguracion;

  bool get existeVacunasConfiguracion =>
      (_vacunasConfiguracion != null) ? true : false;

  Stream<ConfiVacuna?> get vacunasConfiguracionStream =>
      _vacunasConfiguracionStreamController.stream;

  void cargarVacunasConfiguracion(ConfiVacuna? configuraciones) {
    _vacunasConfiguracion = configuraciones;
    _vacunasConfiguracionStreamController.add(configuraciones);
  }

  //----------------------------Manejo de Listas-------------------------//

  final StreamController<List<ConfiVacuna?>>
      _listavacunasConfiguracionStreamController =
      StreamController<List<ConfiVacuna?>>.broadcast();

  List<ConfiVacuna>? get listavacunasConfiguracion =>
      _listavacunasConfiguracion;

  bool get existelistaVacunasConfiguraciones =>
      (_listavacunasConfiguracion!.isNotEmpty) ? true : false;

  Stream<List<ConfiVacuna?>> get listaVacunasConfiguracionesStream =>
      _listavacunasConfiguracionStreamController.stream;

  void cargarListaVacunasConfiguracion(
      List<ConfiVacuna> listavacunasConfiguracion) {
    _listavacunasConfiguracion = listavacunasConfiguracion;
    _listavacunasConfiguracionStreamController.add(listavacunasConfiguracion);
    _listavacunasConfiguracionBusquedaStreamController
        .add(listavacunasConfiguracion);
  }

  void eliminarListaVacunasConfiguracion() {
    List<ConfiVacuna> vacio = [];
    _listavacunasConfiguracion = vacio;
    _listavacunasConfiguracionStreamController.add(vacio);
  }

  //---------------------  Manejo de Busqueda --------------------------///

  final StreamController<List<ConfiVacuna?>>
      _listavacunasConfiguracionBusquedaStreamController =
      StreamController<List<ConfiVacuna?>>.broadcast();

  List<ConfiVacuna>? get listavacunasConfiguracionBusqueda =>
      _listavacunasConfiguracionBusqueda;

  bool get existeBusquedaxConfiguracion =>
      (_listavacunasConfiguracionBusqueda!.isNotEmpty) ? true : false;

  Stream<List<ConfiVacuna?>> get listaBusquedaConfiguracionStream =>
      _listavacunasConfiguracionBusquedaStreamController.stream;

  void buscarConfiguracion(String busqconfiguracion) {
    List<ConfiVacuna> busquedaConfiguracion = _listavacunasConfiguracion!
        .where((element) => element.sysvacu02_descripcion!
            .toUpperCase()
            .contains(busqconfiguracion))
        .toList();
    _listavacunasConfiguracionBusqueda = busquedaConfiguracion;
    _listavacunasConfiguracionBusquedaStreamController
        .add(_listavacunasConfiguracionBusqueda!);
  }

  void eliminarBusquedaConfiguracion() {
    List<ConfiVacuna> vacio = [];
    _listavacunasConfiguracionBusqueda = vacio;
    _listavacunasConfiguracionBusquedaStreamController.add(vacio);
  }

////------------------------------------------------------------------------------------///////

  dispose() {
    _listavacunasConfiguracionBusquedaStreamController.close();
    _vacunasConfiguracionStreamController.close();
    _listavacunasConfiguracionStreamController.close();
  }
}

final vacunasConfiguracionService = _VacunasConfiguracion();
