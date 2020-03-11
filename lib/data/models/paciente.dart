

class Paciente {
  int _id;
  String _nomePaciente;
  String _dataNascimento;
  int sexo;
  int _idConsulta;
  Consulta _consulta;

  Paciente({int id, String nomePaciente,  String dataNascimento, int sexo, int idConsulta}){
    this._id = id;
    this._nomePaciente = nomePaciente;
    this._dataNascimento = dataNascimento;
    this._sexo = sexo;
    this._idConsulta = idConsulta;
  }

  int get id => _id;
  set id(int id) => this._id = id;

  String get nome => _nomePaciente;
  set nome(String nome) => this._nomePaciente = nome;

  int get sexo => _sexo;
  set sexo(int sexo) => this._sexo = sexo;

  String get dataNascimento => this._dataNascimento;
  set dataNascimento(String dataNascimento) => this._dataNascimento = dataNascimento;


  int get idConsulta => this._idConsulta;
  set idConsulta(int idConsulta) => this._idConsulta= idConsulta;

  Consulta get consulta => _consulta;
  set consulta(Consulta _consulta) {
    this._consulta = _consulta;
    this._idConsulta = this._consulta.id;
  }

  Paciente.fromMap(Map map){
    _id = map[HelperPaciente.idColumn];
    _nomePaciente = map[HelperPaciente.nomeColumn];
    _dataNascimento = map[HelperPaciente.dataColumn];
    _sexo = map[HelperPaciente.sexoColumn];
    _idCurso = map[HelperPaciente.idConsultaColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperPaciente.nomeColumn: nome,
      HelperPaciente.dataColumn: dataNascimento,
      HelperPaciente.sexoColumn: sexo,
      HelperPaciente.idConsultaColumn: idCurso,
    };

    if(id != null){
      map[HelperPaciente.idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Paciente(id: $id, nome: $nome)";
  }

}
