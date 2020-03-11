import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperaluno.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/helpers/helpermatricula.dart';
import 'package:magister_mobile/data/helpers/helperturma.dart';
import 'package:magister_mobile/data/models/aluno.dart';
import 'package:magister_mobile/data/models/curso.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:magister_mobile/data/models/matricula.dart';
import 'package:magister_mobile/data/models/turma.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditMatricula extends StatefulWidget {
  final bool edit;
  final Matricula matricula;
  final Aluno aluno;

  EditMatricula(this.edit, {this.aluno, this.matricula});
  @override
  _EditMatriculaState createState() => _EditMatriculaState();
}

class _EditMatriculaState extends State<EditMatricula> {
  HelperAluno helperAluno = new HelperAluno();
  HelperCurso helperCurso = new HelperCurso();
  Aluno aluno;
  Curso cursoAluno;
  List<Disciplina> listAlunoDisciplina = new List();

  Disciplina selectedDisciplia;
  Turma selectedTurma;
  String currentTurma = "Selecione uma turma";
  String currentDisciplina = "Selecione as disciplinas";

  TextEditingController alunoIdController = new TextEditingController();
  TextEditingController turmaAnoController = new TextEditingController();
  TextEditingController turmaSemestreController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      alunoIdController.text = widget.matricula.alunoId.toString();
      turmaAnoController.text = widget.matricula.turmaAno.toString();
      turmaSemestreController.text = widget.matricula.turmaSemestre.toString();
    }
    setState(() {
      alunoIdController.text = widget.aluno.id.toString();
    });

    helperAluno.getFirst(widget.aluno.id).then((value) {
      setState(() {
        aluno = value;
      });
    });
    helperCurso.getFirst(widget.aluno.idCurso).then((curso) {
      setState(() {
        cursoAluno = curso;
      });
    });
  }

  void onPressed() async {
    if (widget.edit == true) {
      HelperMatricula.getInstance().update(new Matricula(
        alunoId: widget.matricula.alunoId,
        turmaAno: widget.matricula.turmaAno,
        turmaSemestre: widget.matricula.turmaSemestre,
        turmaIdDisc: widget.matricula.turmaIdDisciplina,
      ));
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      for (int i = 0; i < listAlunoDisciplina.length; i++) {
        await HelperMatricula.getInstance().save(
          new Matricula(
            alunoId: int.parse(alunoIdController.text),
            turmaAno: int.parse(turmaAnoController.text),
            turmaSemestre: int.parse(turmaSemestreController.text),
            turmaIdDisc: listAlunoDisciplina[i].id,
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.edit
              ? "Editar matricula"
              : "Processo de Matricula de " + aluno.nome,
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: Colors.lime,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              onPressed();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.lime, width: 1),
              ),
              child: FutureBuilder<List>(
                  future: HelperTurma.getInstance().getAll(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: Colors.lime,
                          ),
                          Theme(
                            data: new ThemeData(
                                primaryColor: Colors.lime,
                                accentColor: Colors.lime,
                                hintColor: Colors.lime),
                            child: DropdownButton<Turma>(
                              style: TextStyle(
                                color: Colors.lime,
                                fontWeight: FontWeight.bold,
                              ),
                              items: snapshot.data
                                  .map((turma) => DropdownMenuItem<Turma>(
                                        child: Text(turma.ano.toString() +
                                            "." +
                                            turma.semestre.toString()),
                                        value: turma,
                                      ))
                                  .toList(),
                              onChanged: (Turma value) {
                                setState(() {
                                  selectedTurma = value;
                                  turmaAnoController.text =
                                      selectedTurma.ano.toString();
                                  turmaSemestreController.text =
                                      selectedTurma.semestre.toString();
                                  currentTurma = value.ano.toString() +
                                      "." +
                                      value.semestre.toString();
                                });
                              },
                              isExpanded: false,
                              //value: _currentUser,
                              hint: Text(currentTurma.toUpperCase()),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          faixaCard(Colors.lime, "Disciplinas"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.lime, width: 1),
              ),
              child: FutureBuilder<List>(
                  future: HelperDisciplina.getInstance()
                      .getAllFromCurso(cursoAluno.id),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: Colors.lime,
                          ),
                          Theme(
                            data: new ThemeData(
                                primaryColor: Colors.lime,
                                accentColor: Colors.lime,
                                hintColor: Colors.lime),
                            child: DropdownButton<Disciplina>(
                              style: TextStyle(
                                color: Colors.lime,
                                fontWeight: FontWeight.bold,
                              ),
                              items: snapshot.data
                                  .map((disciplina) =>
                                      DropdownMenuItem<Disciplina>(
                                        child: Text(disciplina.nomeDisc),
                                        value: disciplina,
                                      ))
                                  .toList(),
                              onChanged: (Disciplina value) {
                                setState(() {
                                  selectedDisciplia = value;
                                  currentDisciplina = value.nomeDisc;
                                });
                              },
                              isExpanded: false,
                              //value: _currentUser,
                              hint: Text(currentDisciplina.toUpperCase()),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.lime,
                            ),
                            onPressed: () {
                              setState(() {
                                listAlunoDisciplina.add(selectedDisciplia);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.lime, width: 1),
                ),
                child: ListView.builder(
                  itemCount: listAlunoDisciplina.length,
                  itemBuilder: (BuildContext context, int index) {
                    Disciplina itemDisc = listAlunoDisciplina[index];
                    return ListTile(
                      title: Text(itemDisc.nomeDisc),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
