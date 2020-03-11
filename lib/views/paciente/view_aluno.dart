import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/models/aluno.dart';
import 'package:magister_mobile/data/models/curso.dart';
import 'package:magister_mobile/views/aluno/edit_aluno.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class ViewAluno extends StatefulWidget {
  final Aluno aluno;
  ViewAluno({this.aluno});
  @override
  _ViewAlunoState createState() => _ViewAlunoState();
}

class _ViewAlunoState extends State<ViewAluno> {
  HelperCurso helperCurso = new HelperCurso();
  Curso curso;

  @override
  void initState() {
    super.initState();
    helperCurso.getFirst(widget.aluno.idCurso).then((value){
      setState(() {
        curso = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.aluno.nome),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditAluno(
                        true,
                        aluno: widget.aluno,
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
              "ID. " + widget.aluno.id.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          viewCard(curso.nomeCurso, "Curso", context, Colors.indigoAccent),
          viewCard(widget.aluno.dataNascimento, "Data de Nascimento", context, Colors.indigoAccent),
          viewCard(widget.aluno.mgp.toString(), "MGP", context, Colors.indigoAccent),
          viewCard(widget.aluno.totalCredito.toString(), "Total de credito", context, Colors.indigoAccent),
        ],
      ),
    );
  }
}