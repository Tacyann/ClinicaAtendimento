import 'package:magister_mobile/data/helpers/helperMedico.dart';

class Medico {
  int _id;
  String _nome;
  String _crm;
  String _tel;
   int _idAtendiemnto;
  Consulta _atendimento;

  Medico({int id, String nome, int matricula}){
    this._id = id;
    this._nome = nome;
    this._matricula = matricula;
  }

  int get id => this._id;
  set id(int id) => this._id = id;

  int get matricula => this._matricula;
  set matricula(int matricula) => this._matricula = matricula;

  String get nomeProf => this._nome;
  set nomeProf(String nomeProf) => this._nome = nomeProf;

  Medico.fromMap(Map map) {
    _id = map[HelperMedico.idColumn];
    _nome = map[HelperMedico.nomeColumn];
    _matricula = map[HelperMedico.matriculaColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperMedico.nomeColumn: this._nome,
      HelperMedico.matriculaColumn: this._matricula
    };

    if (id != null) {
      map[HelperMedico.idColumn] = this._id;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return nomeProf;
  }
}
