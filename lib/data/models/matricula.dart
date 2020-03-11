
import 'package:magister_mobile/data/helpers/helpermatricula.dart';
import 'package:magister_mobile/data/models/aluno.dart';
import 'package:magister_mobile/data/models/turma.dart';

class Matricula{
  int _alunoId;
  Aluno _aluno;
  int _turmaAno;
  int _turmaSemestre;
  int _turmaIdDisc;
  Turma _turma;
  double _nota1;
  double _nota2;

  Matricula({int alunoId, int turmaAno, int turmaSemestre, int turmaIdDisc, double nota1, double nota2}){
    this._alunoId = alunoId;
    this._turmaAno = turmaAno;
    this._turmaSemestre = turmaSemestre;
    this._turmaIdDisc = turmaIdDisc;
    this._nota1 = nota1;
    this._nota2 = nota2;
  }

  int get alunoId => this._alunoId;
  set alunoId(int alunoId) => this._alunoId = alunoId;

  int get turmaAno => this._turmaAno;
  set turmaAno(int turmaAno) => this._turmaAno = turmaAno;

  int get turmaSemestre => this._turmaSemestre;
  set turmaSemestre(int turmaSemestre) => this._turmaSemestre = turmaSemestre;

  int get turmaIdDisciplina => this._turmaIdDisc;
  set turmaIdDisciplina (int turmaIdDisciplina) => this._turmaIdDisc = turmaIdDisciplina;

  double get nota1 =>  this._nota1;
  set nota1(double nota1) => this._nota1 = nota1;

  double get nota2 => this._nota2;
  set nota2(double nota2) => this._nota2 = nota2;

   Aluno get aluno => _aluno;
  set aluno(Aluno aluno) {
    this._aluno = aluno;
    this._alunoId = this._aluno.id;
  }
  Matricula.fromMap(Map map){
    _alunoId = map[HelperMatricula.idAlunoColumn];
    _turmaAno = map[HelperMatricula.turmaAnoColumn];
    _turmaSemestre = map[HelperMatricula.turmaSemestreColumn];
    _turmaIdDisc = map[HelperMatricula.turmaIdDiscColumn];
    _nota1 = map[HelperMatricula.nota1Column];
    _nota2 = map[HelperMatricula.nota2Column];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperMatricula.idAlunoColumn: alunoId,
      HelperMatricula.turmaAnoColumn: turmaAno,
      HelperMatricula.turmaSemestreColumn: turmaSemestre,
      HelperMatricula.turmaIdDiscColumn: turmaIdDisciplina,
      HelperMatricula.nota1Column: nota2,
      HelperMatricula.nota2Column: nota2,
    };

    if (alunoId != null && turmaAno != null && turmaSemestre != null && turmaIdDisciplina != null) {
      map[HelperMatricula.idAlunoColumn] = alunoId;
      map[HelperMatricula.turmaAnoColumn] = turmaAno;
      map[HelperMatricula.turmaSemestreColumn] = turmaSemestre;
      map[HelperMatricula.turmaIdDiscColumn] = turmaIdDisciplina;
    }
    return map;
  }

  

}