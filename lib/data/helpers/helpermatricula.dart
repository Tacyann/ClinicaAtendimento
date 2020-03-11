import 'package:magister_mobile/data/helpers/helperbase.dart';
import 'package:magister_mobile/data/models/matricula.dart';
import 'package:sqflite/sqflite.dart';

class HelperMatricula extends HelperBase<Matricula> {
  static final String matriculaTable = "tb_matricula";
  static final String idAlunoColumn = "aluno_id";
  static final String turmaAnoColumn = "turma_ano";
  static final String turmaSemestreColumn = "turma_semestre";
  static final String turmaIdDiscColumn = "turma_id_disc";
  static final String nota1Column = "nota1";
  static final String nota2Column = "nota2";
  static final HelperMatricula _instance = HelperMatricula.getInstance();

  factory HelperMatricula() => _instance;
  HelperMatricula.getInstance();

  Future<int> deleteMatricula(int alunoId, int turmaAno, int turmaSemestre, int turmaidDisc) async {
    return db.then((database) async {
      return await database.delete(matriculaTable,
          where:
              "$idAlunoColumn = ? AND $turmaAnoColumn = ? AND $turmaSemestreColumn = ? AND $turmaIdDiscColumn = ?",
          whereArgs: [alunoId, turmaAno, turmaSemestre, turmaidDisc]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $matriculaTable");
        List<Matricula> lista = List();
        for (Map m in listMap) {
          lista.add(Matricula.fromMap(m));
        }
        return lista;
      });

  Future<Matricula> getFirstMatricula(int alunoId, int turmaAno, int turmaSemestre, int turmaidDisc) async =>
      db.then((database) async {
        List<Map> maps = await database.query(matriculaTable,
            columns: [
              idAlunoColumn,
              turmaAnoColumn,
              turmaSemestreColumn,
              turmaIdDiscColumn,
              nota1Column,
              nota2Column
            ],
            where:
              "$idAlunoColumn = ? AND $turmaAnoColumn = ? AND $turmaSemestreColumn = ? AND $turmaIdDiscColumn = ?",
          whereArgs: [alunoId, turmaAno, turmaSemestre, turmaidDisc]);

        if (maps.length > 0) {
          return Matricula.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $matriculaTable");
    }));
  }

  @override
  Future<Matricula> save(Matricula matricula) async {
    db.then((database) async {
      await database.insert(matriculaTable, matricula.toMap());
    });
    return matricula;
  }

  @override
  Future<int> update(Matricula data) async => await db.then((database) {
        return database.update(matriculaTable, data.toMap(),
            where:
              "$idAlunoColumn = ? AND $turmaAnoColumn = ? AND $turmaSemestreColumn = ? AND $turmaIdDiscColumn = ?",
          whereArgs: [data.alunoId, data.turmaAno, data.turmaSemestre, data.turmaIdDisciplina]);
      });

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<Matricula> getFirst(int id) {
    // TODO: implement getFirst
    return null;
  }
}
