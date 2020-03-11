import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperaluno.dart';
import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/helpers/helpermatricula.dart';
import 'package:magister_mobile/data/models/aluno.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:magister_mobile/data/models/matricula.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditNotaMatricula extends StatefulWidget {
  final Matricula matricula;

  EditNotaMatricula({this.matricula});
  @override
  _EditNotaMatriculaState createState() => _EditNotaMatriculaState();
}

class _EditNotaMatriculaState extends State<EditNotaMatricula> {
  HelperAluno helperAluno = new HelperAluno();
  Aluno aluno;
  TextEditingController nota1Controller = new TextEditingController();
  TextEditingController nota2Controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    helperAluno.getFirst(widget.matricula.alunoId).then((value) {
      setState(() {
        aluno = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Notas"),
        backgroundColor: Colors.lime,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          viewCard(aluno.nome, "", context, Colors.lime),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.lime, width: 1),
                ),
                child: FutureBuilder<List>(
                  future: HelperDisciplina.getInstance().getAll(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Disciplina disciplina = snapshot.data[index];
                          return Card(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(disciplina.nomeDisc + ":"),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: nota1Controller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Nota 1",
                                    ),
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: nota2Controller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Nota 2",
                                    ),
                                  ),
                                )),
                                IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.lime,
                                  ),
                                  onPressed: () {
                                    HelperMatricula.getInstance().update(new Matricula(
                                      alunoId: widget.matricula.alunoId,
                                      turmaAno: widget.matricula.turmaAno,
                                      turmaSemestre: widget.matricula.turmaSemestre,
                                      turmaIdDisc: widget.matricula.turmaIdDisciplina,
                                      nota1: double.parse(nota1Controller.text),
                                      nota2: double.parse(nota2Controller.text),
                                    ));
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
