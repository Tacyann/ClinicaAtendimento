
class Estado {
int _id;
String _nomeEstado;
String _sigla;

Estado({int id, String nomeEstado, String sigla}){
    this._id = id;
    this._nomeEstado = nomeEstado;
    this._sigla = sigla;
  }

  int get id => _id;
  set id(int id) => this._id = id;

  String get nome => _nomeEstado;
  set nome(String nome) => this._nomeEstado = nome;

  String get sigla => this._sigla;
  set sigla(String sigla) => this._sigla = sigla;

   Estado.fromMap(Map map){
    _id = map[HelperEstado.idColumn];
    _nomeEstado = map[HelperEstado.nomeColumn];
    _sigla = map[HelperEstado.dataColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperEstado.nomeColumn: nome,
      HelperEstado.dataColumn: sigla_sigla,
    };

    if(id != null){
      map[HelperEstado.idColumn] = id;
    }
    return map;
  }

    @override
  String toString() {
    return "Estado(id: $id, nome: $nomeEstado)";
  }

}