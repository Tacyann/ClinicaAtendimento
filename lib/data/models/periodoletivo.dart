import 'package:magister_mobile/data/helpers/helperperiodo.dart';
import 'package:magister_mobile/data/models/turma.dart';
class PeriodoLetivo {
  int _ano;
  int _semestre;
  String _dataInicio;
  String _dataFinal;
  List<Turma> _turmas = new List();

  PeriodoLetivo({int ano, int semestre, String dInicio, String dFinal}){
    this._ano = ano;
    this._semestre = semestre;
    this._dataInicio = dInicio;
    this._dataFinal = dFinal;
  }

  int get ano => this._ano;
  set ano(int ano) => this._ano = ano;

  int get semestre => this._semestre;
  set semestre(int semestre) => this._semestre = semestre;

  String get dataInicio => this._dataInicio;
  set dataInicio(String dataInicio) => this._dataInicio = dataInicio;

  String get dataFinal => this._dataFinal;
  set dataFinal(String dataFinal) => this._dataFinal = dataFinal;

   List<Turma> get turmas => this._turmas;
  set turmas(List<Turma> turmas) => this._turmas = turmas;

  PeriodoLetivo.fromMap(Map map) {
     _ano = map[HelperPeriodo.anoColumn];
     _semestre = map[HelperPeriodo.semestreColumn];
     _dataInicio = map[HelperPeriodo.dataInicioColumn];
     _dataFinal = map[HelperPeriodo.dataFinalColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperPeriodo.anoColumn: ano,
      HelperPeriodo.semestreColumn: semestre,
      HelperPeriodo.dataInicioColumn: dataInicio,
      HelperPeriodo.dataFinalColumn: dataFinal
    };
    return map;
  }

  @override
  String toString() {
    return this._ano.toString() + "." + this._semestre.toString();
  }
}
