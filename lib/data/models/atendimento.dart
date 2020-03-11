//import 'package:magister_mobile/data/helpers/helperAtendimento.dart';
//import 'package:magister_mobile/data/models/disciplina.dart';
//import 'package:magister_mobile/data/models/periodoletivo.dart';
//import 'package:magister_mobile/data/models/professor.dart';

class Atendimento {
  int _ano;
  int _semestre;
  PeriodoLetivo _peridoLetivo;
  int _vagas;
  int _idDisc;
  Disciplina _disciplina;
  int _idProf;
  Professor _professor;

  Atendimento({int ano, int semestre, int idDisc, int vagas, int idProf}){
    this._ano = ano;
    this._semestre = semestre;
    this._idDisc = idDisc;
    this._vagas = vagas;
    this._idProf = idProf;
  }

  int get ano => this._ano;
  set ano(int ano) => this._ano = ano;

  int get semestre => this._semestre;
  set semestre(int semestre) => this._semestre = semestre;

  int get idDisc => this._idDisc;
  set idDisc(int idDisc) => this._idDisc = idDisc;

  int get vagas => this._vagas;
  set vagas(int vagas) => this._vagas = vagas;

  Disciplina get disciplina => this._disciplina;
  set disciplina(Disciplina disciplina){
    this._disciplina = disciplina;
    this.idDisc = this._disciplina.id;
  }

  PeriodoLetivo get peridoLetivo => this._peridoLetivo;
  set periodoLetivo(PeriodoLetivo periodoLetivo){
      this._peridoLetivo = periodoLetivo;
      this._ano = this._peridoLetivo.ano;
      this._semestre = this._peridoLetivo.semestre;
  }

  int get idProf => this._idProf;
  set idProf(int idProf) => this._idProf = idProf;

  set professor(Professor professor) {
    this._professor = professor;
    this.idProf = this._professor.id;
  }

  Atendimento.fromMap(Map map) {
    _ano = map[HelperAtendimento.anoColumn];
    _semestre = map[HelperAtendimento.semestreColumn];
    _idDisc = map[HelperAtendimento.idDiscColumn];
    _vagas = map[HelperAtendimento.vagaColumn];
    _idProf = map[HelperAtendimento.idProfColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperAtendimento.vagaColumn: vagas,
      HelperAtendimento.idProfColumn: idProf,
    };

    if (ano != null && semestre != null && idDisc != null) {
      map[HelperAtendimento.anoColumn] = ano;
      map[HelperAtendimento.semestreColumn] = semestre;
      map[HelperAtendimento.idDiscColumn] = idDisc;
    }
    return map;
  }
}
