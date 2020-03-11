import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helpermatricula.dart';
import 'package:magister_mobile/data/models/matricula.dart';
import 'package:magister_mobile/views/matricula/edit_matricula.dart';
import 'package:magister_mobile/views/matricula/edit_nota.dart';

class HomeMatricula extends StatefulWidget {
  @override
  _HomeMatriculaState createState() => _HomeMatriculaState();
}

class _HomeMatriculaState extends State<HomeMatricula> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MATRICULAS"),
        backgroundColor: Colors.lime,
        elevation: 1,
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: HelperMatricula.getInstance().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Matricula item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.lime),
                  onDismissed: (direction) {
                    HelperMatricula.getInstance().deleteMatricula(
                        item.alunoId,
                        item.turmaAno,
                        item.turmaSemestre,
                        item.turmaIdDisciplina);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text("ID do aluno: " + item.alunoId.toString()),
                      subtitle: Text("Nota1: " +
                          item.nota1.toString() +
                          "   " +
                          " Nota2: " +
                          item.nota2.toString()),
                      leading: CircleAvatar(
                        backgroundColor: Colors.lime,
                        child: Text((index + 1).toString(),
                            style: TextStyle(color: Colors.white)),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditNotaMatricula(matricula: item)));
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lime,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditMatricula(false)));
          }),
    );
  }
}
