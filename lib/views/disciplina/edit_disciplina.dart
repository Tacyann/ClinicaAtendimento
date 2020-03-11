import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/models/curso.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditDisciplina extends StatefulWidget {
  final bool edit;
  final Disciplina disciplina;

  EditDisciplina(this.edit, {this.disciplina})
      : assert(edit == true || disciplina == null);
  @override
  _EditDisciplinaState createState() => _EditDisciplinaState();
}

class _EditDisciplinaState extends State<EditDisciplina> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController creditoController = new TextEditingController();
  TextEditingController tipoController = new TextEditingController();
  TextEditingController hrsObgController = new TextEditingController();
  TextEditingController limiteFaltasController = new TextEditingController();
  TextEditingController idCursoController = new TextEditingController();
  Curso selected;
  String current = "Selecione Curso";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      nomeController.text = widget.disciplina.nomeDisc.toString();
      creditoController.text = widget.disciplina.creditos.toString();
      tipoController.text = widget.disciplina.tipo.toString();
      hrsObgController.text = widget.disciplina.hrs.toString();
      limiteFaltasController.text = widget.disciplina.limiteFaltas.toString();
      HelperCurso.getInstance().getFirst(widget.disciplina.idCurso).then((value) {
        current = value.nomeCurso;
      });
    }
  }

  void onPressed() async {
    if (!_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Carregando')));
    } else if (widget.edit == true) {
      HelperDisciplina.getInstance().update(new Disciplina(
        id: widget.disciplina.id,
        nome: nomeController.text,
        creditos: int.parse(creditoController.text),
        tipo: tipoController.text,
        limite: int.parse(limiteFaltasController.text),
        hrs: int.parse(hrsObgController.text),
        idCurso: int.parse(idCursoController.text),
      ));
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      await HelperDisciplina.getInstance().save(
        new Disciplina(
          nome: nomeController.text,
          creditos: int.parse(creditoController.text),
          tipo: tipoController.text,
          limite: int.parse(limiteFaltasController.text),
          hrs: int.parse(hrsObgController.text),
          idCurso: int.parse(idCursoController.text),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.edit ? "Editar Disciplina" : "Nova Disciplina"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              onPressed();
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Image.asset("assets/disciplina.png"),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    formField(nomeController, "Nome da Disciplina",
                        Icons.school, TextInputType.text, Colors.purple,
                        initialValue:
                            widget.edit ? widget.disciplina.nomeDisc : "n"),
                    formField(
                      creditoController,
                      "Créditos",
                      Icons.apps,
                      TextInputType.number,
                      Colors.purple,
                    ),
                    formField(tipoController, "Tipo", Icons.apps,
                        TextInputType.text, Colors.purple,
                        initialValue:
                            widget.edit ? widget.disciplina.tipo : "t"),
                    formField(
                      hrsObgController,
                      "Horas Obrigatórias",
                      Icons.watch_later,
                      TextInputType.number,
                      Colors.purple,
                    ),
                    formField(
                      limiteFaltasController,
                      "Limite de Faltas",
                      Icons.apps,
                      TextInputType.number,
                      Colors.purple,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.purple, width: 1),
                        ),
                        child: FutureBuilder<List>(
                            future: HelperCurso.getInstance().getAll(),
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
                                      color: Colors.purple,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                          primaryColor: Colors.purple,
                                          accentColor: Colors.purple,
                                          hintColor: Colors.purple),
                                      child: DropdownButton<Curso>(
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: snapshot.data
                                            .map((curso) =>
                                                DropdownMenuItem<Curso>(
                                                  child: Text(curso.nomeCurso),
                                                  value: curso,
                                                ))
                                            .toList(),
                                        onChanged: (Curso value) {
                                          setState(() {
                                            selected = value;
                                            idCursoController.text =
                                                selected.id.toString();
                                            current = value.nomeCurso;
                                          });
                                        },
                                        isExpanded: false,
                                        hint: Text(current.toUpperCase()),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
