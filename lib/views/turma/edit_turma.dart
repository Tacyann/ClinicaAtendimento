import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/helpers/helperperiodo.dart';
import 'package:magister_mobile/data/helpers/helperprofessor.dart';
import 'package:magister_mobile/data/helpers/helperturma.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:magister_mobile/data/models/periodoletivo.dart';
import 'package:magister_mobile/data/models/professor.dart';
import 'package:magister_mobile/data/models/turma.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditTurma extends StatefulWidget {
  final bool edit;
  final Turma turma;

  EditTurma(this.edit, {this.turma}) : assert(edit == true || turma == null);

  @override
  _EditTurmaState createState() => _EditTurmaState();
}

class _EditTurmaState extends State<EditTurma> {
  TextEditingController anoController = new TextEditingController();
  TextEditingController semestreController = new TextEditingController();
  TextEditingController idDiscController = new TextEditingController();
  TextEditingController vagasController = new TextEditingController();
  TextEditingController idProfController = new TextEditingController();
  bool visibilidade = true;

  final _formKey = GlobalKey<FormState>();

  Professor selectedProf;
  String currentProf = "Selecione professor".toUpperCase();
  PeriodoLetivo selectedPeriodo;
  String currentPeriodo = "Selecione o período letivo".toUpperCase();
  Disciplina selectedDisci;
  String currentDisc = "Selecione Disciplina".toUpperCase();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      vagasController.text = widget.turma.vagas.toString();
      visibilidade = false;
      HelperProfessor.getInstance().getFirst(widget.turma.idProf).then((value){
        currentProf = value.nomeProf;
      });
    }
  }

  void onPressed() async {
    if (!_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Carregando')));
    } else if (widget.edit == true) {
      HelperTurma.getInstance().update(new Turma(
        ano: widget.turma.ano,
        semestre: widget.turma.semestre,
        idDisc: widget.turma.idDisc,
        vagas: int.parse(vagasController.text),
        idProf: int.parse(idProfController.text),
      ));
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      await HelperTurma.getInstance().save(
        new Turma(
          ano: int.parse(anoController.text),
          semestre: int.parse(semestreController.text),
          idDisc: int.parse(idDiscController.text),
          vagas: int.parse(vagasController.text),
          idProf: int.parse(idProfController.text),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Editar Turma" : "Adicionar turma"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.check),
            onPressed: () {
              onPressed();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Image.asset("assets/curso.png"),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  formField(vagasController, "Vagas", Icons.apps,
                      TextInputType.number, Colors.teal),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.teal, width: 1),
                      ),
                      child: FutureBuilder<List>(
                          future: HelperProfessor.getInstance().getAll(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List> snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    color: Colors.teal,
                                  ),
                                  Theme(
                                    data: new ThemeData(
                                        primaryColor: Colors.teal,
                                        accentColor: Colors.teal,
                                        hintColor: Colors.teal),
                                    child: DropdownButton<Professor>(
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      items: snapshot.data
                                          .map((professor) =>
                                              DropdownMenuItem<Professor>(
                                                child: Text(professor.nomeProf),
                                                value: professor,
                                              ))
                                          .toList(),
                                      onChanged: (Professor value) {
                                        setState(() {
                                          selectedProf = value;
                                          idProfController.text =
                                              selectedProf.id.toString();
                                          currentProf = value.nomeProf;
                                        });
                                      },
                                      isExpanded: false,
                                      hint: Text(currentProf),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Visibility(
                    visible: visibilidade,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.teal, width: 1),
                        ),
                        child: FutureBuilder<List>(
                            future: HelperDisciplina.getInstance().getAll(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 4.0,
                                    bottom: 4.0,
                                    right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      Icons.school,
                                      color: Colors.teal,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                          primaryColor: Colors.teal,
                                          accentColor: Colors.teal,
                                          hintColor: Colors.teal),
                                      child: DropdownButton<Disciplina>(
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: snapshot.data
                                            .map((disciplina) =>
                                                DropdownMenuItem<Disciplina>(
                                                  child:
                                                      Text(disciplina.nomeDisc),
                                                  value: disciplina,
                                                ))
                                            .toList(),
                                        onChanged: (Disciplina value) {
                                          setState(() {
                                            selectedDisci = value;
                                            idDiscController.text =
                                                selectedDisci.id.toString();
                                            currentDisc = value.nomeDisc;
                                          });
                                        },
                                        isExpanded: false,
                                        hint: Text(currentDisc),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibilidade,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.teal, width: 1),
                        ),
                        child: FutureBuilder<List>(
                            future: HelperPeriodo.getInstance().getAll(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 4.0,
                                    bottom: 4.0,
                                    right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      Icons.school,
                                      color: Colors.teal,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                          primaryColor: Colors.teal,
                                          accentColor: Colors.teal,
                                          hintColor: Colors.teal),
                                      child: DropdownButton<PeriodoLetivo>(
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: snapshot.data
                                            .map((periodo) =>
                                                DropdownMenuItem<PeriodoLetivo>(
                                                  child: Text(
                                                      periodo.ano.toString() +
                                                          "." +
                                                          periodo.semestre
                                                              .toString()),
                                                  value: periodo,
                                                ))
                                            .toList(),
                                        onChanged: (PeriodoLetivo value) {
                                          setState(() {
                                            selectedPeriodo = value;
                                            anoController.text =
                                                selectedPeriodo.ano.toString();
                                            semestreController.text =
                                                selectedPeriodo.semestre
                                                    .toString();
                                            currentPeriodo =
                                                value.ano.toString() +
                                                    "." +
                                                    value.semestre.toString();
                                          });
                                        },
                                        isExpanded: false,
                                        hint: Text(currentPeriodo),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
