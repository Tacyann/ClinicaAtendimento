
import 'package:magister_mobile/data/helpers/helperbase.dart';
import 'package:magister_mobile/data/models/periodoletivo.dart';
import 'package:sqflite/sqflite.dart';

class HelperPeriodo extends HelperBase<PeriodoLetivo> {
  static final String periodoTable = "tb_periodo";
  static final String anoColumn = "ano";
  static final String semestreColumn = "semestre";
  static final String dataInicioColumn = "data_inicio";
  static final String dataFinalColumn = "data_final";
  
  static final HelperPeriodo _instance = HelperPeriodo.getInstance();

  factory HelperPeriodo() => _instance;
  HelperPeriodo.getInstance();

  Future<int> deletePeriodo(int ano, int semestre) async {
    return db.then((database) async {
      return await database
          .delete(periodoTable, where: "$anoColumn = ? AND $semestreColumn = ?", whereArgs: [ano, semestre]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $periodoTable");
        List<PeriodoLetivo> lista = List();
        for (Map m in listMap) {
          lista.add(PeriodoLetivo.fromMap(m));
        }
        return lista;
      });

  Future<PeriodoLetivo> getFirstPeriodo(int ano, int semestre) async => db.then((database) async {
        List<Map> maps = await database.query(periodoTable,
            columns: [
              anoColumn,
              semestreColumn,
              dataInicioColumn,
              dataFinalColumn,
            ],
            where: "$anoColumn = ? AND $semestreColumn = ?", 
            whereArgs: [ano, semestre]);

        if (maps.length > 0) {
          return PeriodoLetivo.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $periodoTable");
    }));
  }

  @override
  Future<PeriodoLetivo> save(PeriodoLetivo periodo) async {
    db.then((database) async {
      await database.insert(periodoTable, periodo.toMap());
    });
    return periodo;
  }

  @override
  Future<int> update(PeriodoLetivo data) async => await db.then((database) {
        return database.update(periodoTable, data.toMap(),
            where: "$anoColumn = ? AND $semestreColumn = ?", whereArgs: [data.ano, data.semestre]);
      });

  @override
  Future<PeriodoLetivo> getFirst(int id) {
    // TODO: implement getFirst
    return null;
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    return null;
  }
}