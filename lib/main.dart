import 'package:flutter/material.dart';
import 'package:magister_mobile/views/aluno/home_aluno.dart';
import 'package:magister_mobile/views/curso/home_curso.dart';
import 'package:magister_mobile/views/disciplina/home_disciplina.dart';
import 'package:magister_mobile/views/matricula/home_matricula.dart';
import 'package:magister_mobile/views/periodoLetivo/home_periodoLetivo.dart';
import 'package:magister_mobile/views/professor/home_professor.dart';
import 'package:magister_mobile/views/turma/home_turma.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magister Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("MAGISTER"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            menuCard(Icons.school, "Professor", Colors.amber, HomeProfessor(), context),
            menuCard(Icons.school, "Curso", Colors.deepOrange, HomeCurso(), context),
            menuCard(Icons.school, "Aluno", Colors.indigoAccent, HomeAluno(), context),
            menuCard(Icons.school, "Período Letivo", Colors.lightGreen, HomePeriodoLetivo(), context),
            menuCard(Icons.school, "Discilinas", Colors.purple, HomeDisciplina(), context),
            menuCard(Icons.school, "Turma", Colors.teal, HomeTurma(), context),
            menuCard(Icons.school, "Matricula", Colors.lime, HomeMatricula(), context),
          ],
        ),
      ),
    );
  }
}


