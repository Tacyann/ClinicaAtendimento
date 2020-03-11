import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperaluno.dart';
import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/helpers/helperprofessor.dart';
import 'package:magister_mobile/data/models/aluno.dart';
import 'package:magister_mobile/data/models/curso.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:magister_mobile/data/models/professor.dart';
import 'package:magister_mobile/views/curso/edit_curso.dart';
import 'package:magister_mobile/views/matricula/edit_matricula.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class ViewCurso extends StatefulWidget {
  final Curso curso;
  ViewCurso({this.curso});

  @override
  _ViewCursoState createState() => _ViewCursoState();
}

class _ViewCursoState extends State<ViewCurso> {
  HelperProfessor helperProfessor = new HelperProfessor();
  Professor coordenador;

  @override
  void initState() {
    super.initState();
    helperProfessor.getFirst(widget.curso.idCoordenador).then((value) {
      setState(() {
        coordenador = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.curso.nomeCurso),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditCurso(true, curso: widget.curso)));
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          viewCard(coordenador.nomeProf, "Coordenador", context, Colors.deepOrange),
          faixaCard(Colors.deepOrange, "Lista de todos os alunos do curso"),
          Expanded(
            child: FutureBuilder<List>(
              future:
                  HelperAluno.getInstance().getAllFromCurso(widget.curso.id),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Aluno aluno = snapshot.data[index];
                      return ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditMatricula(false, aluno: aluno,)));
                        },
                        title: Text(aluno.nome),
                        leading: CircleAvatar(
                          child: Text(
                            aluno.id.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepOrange,
                          maxRadius: 12.0,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          faixaCard(
              Colors.deepOrange, "Lista de todos as disciplinas do curso"),
          Expanded(
            child: FutureBuilder<List>(
              future: HelperDisciplina.getInstance()
                  .getAllFromCurso(widget.curso.id),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Disciplina disciplina = snapshot.data[index];
                      return ListTile(
                        title: Text(disciplina.nomeDisc),
                        leading: CircleAvatar(
                          child: Text(
                            disciplina.id.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepOrange,
                          maxRadius: 12.0,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          faixaCard(
              Colors.deepOrange, "Lista de todos os  professores do curso"),
          Expanded(
            child: FutureBuilder<List>(
              future: HelperProfessor.getInstance().getAllProfFromCurso(widget.curso.id),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Professor professor = snapshot.data[index];
                      return ListTile(
                        title: Text(professor.nomeProf),
                        leading: CircleAvatar(
                          child: Text(
                            professor.id.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepOrange,
                          maxRadius: 12.0,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
