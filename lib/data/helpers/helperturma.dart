import 'package:magister_mobile/data/helpers/helperbase.dart';
import 'package:magister_mobile/data/models/turma.dart';
import 'package:sqflite/sqflite.dart';

class HelperTurma extends HelperBase<Turma> {
  static final String turmaTable = "tb_turma";
  static final String anoColumn = "ano";
  static final String semestreColumn = "semestre";
  static final String idDiscColumn = "id_disc";
  static final String vagaColumn = "vaga";
  static final String idProfColumn = "id_prof";
  
  static final HelperTurma _instance = HelperTurma.getInstance();

  factory HelperTurma() => _instance;
  HelperTurma.getInstance();

  Future<int> deleteDisciplina(int ano, int semestre, int idDisc) async {
    return db.then((database) async {
      return await database
          .delete(turmaTable, where: "$anoColumn = ? AND $semestreColumn = ? AND $idDiscColumn = ?", whereArgs: [ano, semestre, idDisc]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $turmaTable");
        List<Turma> lista = List();
        for (Map m in listMap) {
          lista.add(Turma.fromMap(m));
        }
        return lista;
      });

  Future<Turma> getFirstSemestre(int ano, int semestre, int idDisc) async => db.then((database) async {
        List<Map> maps = await database.query(turmaTable,
            columns: [
              anoColumn,
              semestreColumn,
              idDiscColumn, 
              vagaColumn,
              idProfColumn,
            ],
            where: "$anoColumn = ? AND $semestreColumn = ? AND $idDiscColumn = ?", 
            whereArgs: [ano, semestre, idDisc]);

        if (maps.length > 0) {
          return Turma.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $turmaTable");
    }));
  }

  @override
  Future<Turma> save(Turma turma) async {
    db.then((database) async {
      await database.insert(turmaTable, turma.toMap());
    });
    return turma;
  }

  @override
  Future<int> update(Turma data) async => await db.then((database) {
        return database.update(turmaTable, data.toMap(),
            where: "$anoColumn = ? AND $semestreColumn = ? AND $idDiscColumn = ?", whereArgs: [data.ano, data.semestre, data.idDisc]);
      });

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<Turma> getFirst(int id) {
    // TODO: implement getFirst
    return null;
  }
}