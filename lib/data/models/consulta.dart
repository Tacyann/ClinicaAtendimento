import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/models/professor.dart';

class Consulta {
  int _id;
  String _data;

  Consulta({int id, String _data }){
    this._id = id;
    this._data = data;
 
  }

  int get id => this._id;
  set id(int id) => this._id = id;

  String get data => this._data;
  set data(String data) => this._data = data;


  Consulta.fromMap(Map map){
    _id = map[HelperConsulta.idColumn];
    _data = map[HelperConsulta.dataColumn];
 
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperConsulta.nomeColumn: data,
 
    };

    if(id != null){
      map[HelperConsulta.idColumn] = id;
    }
    return map;
  }
  
}
