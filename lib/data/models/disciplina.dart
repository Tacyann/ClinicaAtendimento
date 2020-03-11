import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/models/curso.dart';

class Disciplina {
  int _id;
  String _nomeDisc;
  int _creditos;
  String _tipo;
  int _hrs;
  int _limiteFaltas;
  Curso _curso;
  int _idCurso;

  Disciplina({int id, String nome, int creditos, String tipo, int hrs, int limite, int idCurso}){
    this._id = id;
    this._nomeDisc = nome;
    this._creditos = creditos;
    this._tipo = tipo;
    this._hrs = hrs;
    this._limiteFaltas = limite;
    this._idCurso = idCurso;
  }

  int get id => this._id;
  set id(int id) => this._id = id;

  String get nomeDisc => this._nomeDisc;
  set nomeDisc(String nomeDisc) => this._nomeDisc = nomeDisc;

  int get creditos => this._creditos;
  set creditos(int creditos) => this._creditos = creditos;

  String get tipo => this._tipo;
  set tipo(String tipo) => this._tipo = tipo;

  int get hrs => this._hrs;
  set hrs(int hrs) => this._hrs = hrs;

  int get limiteFaltas => this._limiteFaltas;
  set limiteFaltas(int limiteFaltas) => this._limiteFaltas = limiteFaltas;

  int get idCurso => this._idCurso;
  set idCurso(int idCurso) => this._idCurso = idCurso;

  Curso get curso => _curso;
  set curso(Curso curso) {
    this._curso = curso;
    this._idCurso = this._curso.id;
  }
  Disciplina.fromMap(Map map){
    _id = map[HelperDisciplina.idColumn];
    _nomeDisc = map[HelperDisciplina.nomeColumn];
    _creditos = map[HelperDisciplina.creditosColumn];
    _tipo = map[HelperDisciplina.tipoColumn];
    _hrs = map[HelperDisciplina.hrsObgColumn];
    _limiteFaltas = map[HelperDisciplina.limiteColumn];
    _idCurso = map[HelperDisciplina.idCursoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperDisciplina.nomeColumn: nomeDisc,
      HelperDisciplina.creditosColumn: creditos,
      HelperDisciplina.tipoColumn: tipo,
      HelperDisciplina.hrsObgColumn: hrs,
      HelperDisciplina.limiteColumn: limiteFaltas,
      HelperDisciplina.idCursoColumn: idCurso,
    };

    if(id != null){
      map[HelperDisciplina.idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Disciplina(id: $id, nome: $nomeDisc)";
  }

}
