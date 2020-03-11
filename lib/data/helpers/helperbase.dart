import 'package:magister_mobile/data/helpers/helperaluno.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/helpers/helpermatricula.dart';
import 'package:magister_mobile/data/helpers/helperperiodo.dart';
import 'package:magister_mobile/data/helpers/helperprofessor.dart';
import 'package:magister_mobile/data/helpers/helperturma.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class HelperBase<T> {
  static final String dataBaseName = "magister_mobile.db";
  Database _database;

  Future<T> getFirst(int id);
  Future<T> save(T curso);
  Future<int> delete(int id);
  Future<int> update(T data);
  Future<List> getAll();
  Future<int> getNumber();

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dataBaseName);

    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future _create(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperProfessor.professorTable}(${HelperProfessor.idColumn} INTEGER PRIMARY KEY, ${HelperProfessor.nomeColumn} TEXT, ${HelperProfessor.matriculaColumn} INTEGER)");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperCurso.cursoTable}(${HelperCurso.idColumn} INTEGER PRIMARY KEY, ${HelperCurso.nomeColumn} TEXT, ${HelperCurso.totalCreditoColumn} INTEGER, ${HelperCurso.idCoordenadorColumn} INTEGER, FOREIGN KEY(${HelperCurso.idCoordenadorColumn}) REFERENCES ${HelperProfessor.professorTable}(${HelperProfessor.idColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperAluno.alunoTable}(${HelperAluno.idColumn} INTEGER PRIMARY KEY, ${HelperAluno.nomeColumn} TEXT, ${HelperAluno.totalCreditoColumn} INTEGER, ${HelperAluno.dataColumn} TEXT, ${HelperAluno.mgpColumn} DOUBLE, ${HelperAluno.idCursoColumn} INTEGER, FOREIGN KEY(${HelperAluno.idCursoColumn}) REFERENCES ${HelperCurso.cursoTable}(${HelperCurso.idColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperPeriodo.periodoTable}(${HelperPeriodo.anoColumn} INTEGER, ${HelperPeriodo.semestreColumn} INTEGER, ${HelperPeriodo.dataInicioColumn} TEXT, ${HelperPeriodo.dataFinalColumn} TEXT, PRIMARY KEY(${HelperPeriodo.anoColumn}, ${HelperPeriodo.semestreColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperDisciplina.disciplinaTable}(${HelperDisciplina.idColumn} INTEGER PRIMARY KEY, ${HelperDisciplina.nomeColumn} TEXT, ${HelperDisciplina.creditosColumn} INTEGER, ${HelperDisciplina.tipoColumn} TEXT, ${HelperDisciplina.hrsObgColumn} INTEGER, ${HelperDisciplina.limiteColumn} INTEGER, ${HelperDisciplina.idCursoColumn} INTEGER, FOREIGN KEY(${HelperDisciplina.idCursoColumn}) REFERENCES ${HelperCurso.cursoTable}(${HelperCurso.idColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperTurma.turmaTable}(${HelperTurma.anoColumn} INTEGER,"
        "${HelperTurma.semestreColumn} INTEGER," 
        "${HelperTurma.idDiscColumn} INTEGER,"
        "${HelperTurma.vagaColumn} INTEGER,"
        "${HelperTurma.idProfColumn} INTEGER,"
        "FOREIGN KEY(${HelperTurma.anoColumn}) REFERENCES ${HelperPeriodo.periodoTable}(${HelperPeriodo.anoColumn})," 
        "FOREIGN KEY(${HelperTurma.semestreColumn}) REFERENCES ${HelperPeriodo.periodoTable}(${HelperPeriodo.semestreColumn})," 
        "FOREIGN KEY(${HelperTurma.idDiscColumn}) REFERENCES ${HelperDisciplina.disciplinaTable}(${HelperDisciplina.idColumn})," 
        "FOREIGN KEY(${HelperTurma.idProfColumn}) REFERENCES ${HelperProfessor.professorTable}(${HelperProfessor.idColumn})," 
        "PRIMARY KEY(${HelperTurma.anoColumn}, ${HelperTurma.semestreColumn}, ${HelperTurma.idDiscColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperMatricula.matriculaTable}(${HelperMatricula.idAlunoColumn} INTEGER,"
        "${HelperMatricula.turmaAnoColumn} INTEGER," 
        "${HelperMatricula.turmaSemestreColumn} INTEGER,"
        "${HelperMatricula.turmaIdDiscColumn} INTEGER,"
        "${HelperMatricula.nota1Column} DOUBLE,"
        "${HelperMatricula.nota2Column} DOUBLE,"
        "FOREIGN KEY(${HelperMatricula.idAlunoColumn}) REFERENCES ${HelperAluno.alunoTable}(${HelperAluno.idColumn})," 
        "FOREIGN KEY(${HelperMatricula.turmaAnoColumn}) REFERENCES ${HelperTurma.turmaTable}(${HelperTurma.anoColumn})," 
        "FOREIGN KEY(${HelperMatricula.turmaSemestreColumn}) REFERENCES ${HelperTurma.turmaTable}(${HelperTurma.semestreColumn})," 
        "FOREIGN KEY(${HelperMatricula.turmaIdDiscColumn}) REFERENCES ${HelperTurma.turmaTable}(${HelperTurma.idDiscColumn})," 
        "PRIMARY KEY(${HelperMatricula.idAlunoColumn}, ${HelperMatricula.turmaAnoColumn}, ${HelperMatricula.turmaSemestreColumn}, ${HelperMatricula.turmaIdDiscColumn}))");
  }
}
