import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/models/curso.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:magister_mobile/views/disciplina/edit_disciplina.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class ViewDisciplina extends StatefulWidget {
  final Disciplina disciplina;
  ViewDisciplina({this.disciplina});

  @override
  _ViewDisciplinaState createState() => _ViewDisciplinaState();
}

class _ViewDisciplinaState extends State<ViewDisciplina> {
  HelperCurso helperCurso = new HelperCurso();
  Curso curso;

  @override
  void initState() {
    super.initState();
    helperCurso.getFirst(widget.disciplina.idCurso).then((value){
      setState(() {
        curso = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disciplina.nomeDisc),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditDisciplina(
                        true,
                        disciplina: widget.disciplina,
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
              "ID. " + widget.disciplina.id.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          viewCard(curso.nomeCurso, "Curso", context, Colors.purple),
          viewCard(widget.disciplina.creditos.toString(), "Creditos", context, Colors.purple),
          viewCard(widget.disciplina.limiteFaltas.toString(), "Limite de Faltas", context, Colors.purple),
          viewCard(widget.disciplina.tipo, "Tipo", context, Colors.purple),
          viewCard(widget.disciplina.hrs.toString(), "Horas Obrigatorias", context, Colors.purple),
        ],
      ),
    );
  }
}
