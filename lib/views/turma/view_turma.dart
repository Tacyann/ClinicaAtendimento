import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/helpers/helperprofessor.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:magister_mobile/data/models/professor.dart';
import 'package:magister_mobile/data/models/turma.dart';
import 'package:magister_mobile/views/turma/edit_turma.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class ViewTurma extends StatefulWidget {
  final Turma turma;
  ViewTurma({this.turma});
  @override
  _ViewTurmaState createState() => _ViewTurmaState();
}

class _ViewTurmaState extends State<ViewTurma> {
  HelperProfessor helperProfessor = new HelperProfessor();
  HelperDisciplina helperDisciplina = new HelperDisciplina();
  Professor professor;
  Disciplina disciplina;

  @override
  void initState() {
    super.initState();
    helperProfessor.getFirst(widget.turma.idProf).then((value) {
      setState(() {
        professor = value;
      });
    });
    helperDisciplina
      ..getFirst(widget.turma.idDisc).then((value) {
        setState(() {
          disciplina = value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TURMA"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditTurma(
                        true,
                        turma: widget.turma,
                      )));
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Um total de " + widget.turma.vagas.toString() + " vagas",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          viewCard(widget.turma.ano.toString() + "." + widget.turma.semestre.toString(), "Periodo Letivo", context, Colors.teal),
          viewCard(disciplina.nomeDisc, "Disciplina", context, Colors.teal),
          viewCard(professor.nomeProf, "Professor", context, Colors.teal),
        ],
      ),
    );
  }
}
