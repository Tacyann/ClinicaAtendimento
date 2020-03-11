class DiaSemana {
int _id;
String _nome;

_DiaSemana({int id, String nome}){
    this._id = id;
    this._nome = nome;
  }

  int get id => _id;
  set id(int id) => this._id = id;

  String get nome => _nome;
  set nome(String nome) => this._nome= nome;



   _DiaSemana.fromMap(Map map){
    _id = map[Helper_DiaSemana.idColumn];
    _nome = map[Helper_DiaSemana.nomeColumn];

  }

  Map toMap() {
    Map<String, dynamic> map = {
      Helper_DiaSemana.nomeColumn: nome,
    };

    if(id != null){
      map[Helper_DiaSemana.idColumn] = id;
    }
    return map;
  }

    @override
  String toString() {
    return "_DiaSemana(id: $id, nome: $nome)";
  }

}