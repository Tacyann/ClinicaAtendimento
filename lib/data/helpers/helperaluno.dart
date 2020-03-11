import 'dart:async';
import 'package:magister_mobile/data/helpers/helperbase.dart';
import 'package:magister_mobile/data/models/aluno.dart';
import 'package:sqflite/sqflite.dart';

class HelperAluno extends HelperBase<Aluno> {
  static final String alunoTable = "tb_aluno";
  static final String idColumn = "id";
  static final String nomeColumn = "nome";
  static final String totalCreditoColumn = "total_credito";
  static final String dataColumn = "data_nascimento";
  static final String mgpColumn = "mgp";
  static final String idCursoColumn = "id_curso";
  static final HelperAluno _instance = HelperAluno.getInstance();

  factory HelperAluno() => _instance;
  HelperAluno.getInstance();

  @override
  Future<int> delete(int id) {
    return db.then((database) async {
      return await database
          .delete(alunoTable, where: "$idColumn = ?", whereArgs: [id]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $alunoTable");
        List<Aluno> lista = List();
        for (Map m in listMap) {
          lista.add(Aluno.fromMap(m));
        }
        return lista;
      });

 @override
  Future<Aluno> getFirst(int id) async => db.then((database) async {
        List<Map> maps = await database.query(alunoTable,
            columns: [
              idColumn,
              nomeColumn,
              totalCreditoColumn,
              dataColumn,
              mgpColumn,
              idCursoColumn,
            ],
            where: "$idColumn = ?",
            whereArgs: [id]);

        if (maps.length > 0) {
          return Aluno.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $alunoTable");
    }));
  }

  @override
  Future<Aluno> save(Aluno aluno) async {
    db.then((database) async {
      await database.insert(alunoTable, aluno.toMap());
    });
    return aluno;
  }

  @override
  Future<int> update(Aluno data) async => await db.then((database) {
        return database.update(alunoTable, data.toMap(),
            where: "$idColumn = ?", whereArgs: [data.id]);
      });

  Future<List> getAllFromCurso(int id) async => db.then((database) async {
        List listMap = await database.query(alunoTable, where: "$idCursoColumn = ?", whereArgs: [id]);
        List<Aluno> lista = List();
        for (Map m in listMap) {
          lista.add(Aluno.fromMap(m));
        }
        return lista;
      });
}
