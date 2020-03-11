
import 'package:magister_mobile/data/helpers/helperbase.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/helpers/helpermatricula.dart';
import 'package:magister_mobile/data/helpers/helperturma.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:sqflite/sqflite.dart';

class HelperDisciplina extends HelperBase<Disciplina> {
  static final String disciplinaTable = "tb_disciplina";
  static final String idColumn = "id";
  static final String nomeColumn = "nome";
  static final String creditosColumn = "creditos";
  static final String tipoColumn = "tipo";
  static final String hrsObgColumn = "hrs_obg";
  static final String limiteColumn = "limite";
  static final String idCursoColumn = "id_curso";
  static final HelperDisciplina _instance = HelperDisciplina.getInstance();

  factory HelperDisciplina() => _instance;
  HelperDisciplina.getInstance();

  @override
  Future<int> delete(int id) async {
    return db.then((database) async {
      return await database
          .delete(disciplinaTable, where: "$idColumn = ?", whereArgs: [id]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $disciplinaTable");
        List<Disciplina> lista = List();
        for (Map m in listMap) {
          lista.add(Disciplina.fromMap(m));
        }
        return lista;
      });

   Future<List> getAllDiscFromAluno(int idCursoFromAluno) async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT DISTINCT disc.${HelperDisciplina.idColumn}, disc.${HelperDisciplina.nomeColumn}, disc.${HelperDisciplina.creditosColumn}, disc.${HelperDisciplina.tipoColumn}, disc.${HelperDisciplina.hrsObgColumn}, disc.${HelperDisciplina.limiteColumn}, disc.${HelperDisciplina.idCursoColumn} FROM $disciplinaTable AS disc "                                 
                                             "INNER JOIN ${HelperTurma.turmaTable} AS turma ON turma.${HelperTurma.idDiscColumn} = disc.${HelperDisciplina.idColumn} "
                                             "INNER JOIN ${HelperMatricula.matriculaTable} AS mat ON mat.${HelperMatricula.turmaIdDiscColumn} = turma.${HelperTurma.idDiscColumn} "
                                            "WHERE curso.${HelperMatricula.idAlunoColumn} = $idCursoFromAluno");                                 
    List<Disciplina> listProf = List();
    for (Map m in listMap) {
      listProf.add(Disciplina.fromMap(m));
    }
    return listProf;
  }

  @override
  Future<Disciplina> getFirst(int id) async => db.then((database) async {
        List<Map> maps = await database.query(disciplinaTable,
            columns: [
              idColumn,
              nomeColumn,
              creditosColumn,
              tipoColumn,
              hrsObgColumn,
              limiteColumn,
              idCursoColumn,
            ],
            where: "$idColumn = ?",
            whereArgs: [id]);

        if (maps.length > 0) {
          return Disciplina.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $disciplinaTable");
    }));
  }

  @override
  Future<Disciplina> save(Disciplina disciplina) async {
    db.then((database) async {
      await database.insert(disciplinaTable, disciplina.toMap());
    });
    return disciplina;
  }

  @override
  Future<int> update(Disciplina data) async => await db.then((database) {
        return database.update(disciplinaTable, data.toMap(),
            where: "$idColumn = ?", whereArgs: [data.id]);
      });

  Future<List> getAllFromCurso(int id) async => db.then((database) async {
        List listMap = await database.query(disciplinaTable, where: "$idCursoColumn = ?", whereArgs: [id]);
        List<Disciplina> lista = List();
        for (Map m in listMap) {
          lista.add(Disciplina.fromMap(m));
        }
        return lista;
      });
}