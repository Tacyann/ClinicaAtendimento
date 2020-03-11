class Endereco {
  int _id;
  String _cidade;
  String _logradouro;
  String _cep;
  int _idEstado;
  Estado _Estado;

  Endereco({int id, String cidade,  String logradouro, Strng cep, int _idEstado){
    this._id = id;
    this._cidade = cidade;
    this._logradouro = logradouro;
    this._cep = cep;
    this._idEstado = idEstado;
  }

  int get id => _id;
  set id(int id) => this._id = id;

  String get nome => _cidade;
  set nome(String nome) => this._cidade = nome;

  String get logradouro => this._logradouro;
  set logradouro(String logradouro) => this._logradouro = logradouro;

  String get cep => this._cep;
  set cep(String cep) => this._cep = cep;

  int get idEstado=> this._idEstado;
  set idEstado(int idEstado) => this._idEstado= idEstado;

  Estado get estado => _estado;
  set estado(estado estado) {
    this.estado = estado;
    this._idEstado = this._estado.id;
  }

  Endereco.fromMap(Map map){
    _id = map[HelperEndereco.idColumn];
    _cidade = map[HelperEndereco.nomeColumn];
    _logradouro = map[HelperEndereco.dataColumn];
    _cep = map[HelperEndereco.sexoColumn];
    _idEstado = map[HelperEndereco.idEstadoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperEndereco.nomeColumn: nome,
      HelperEndereco.logradouroColumn: logradouro,
      HelperEndereco.cepColumn: sexo,
      HelperEndereco.idEstadoColumn: idCurso,
    };

    if(id != null){
      map[HelperEndereco.idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Endereco(id: $id, nome: $cidade)";
  }

}