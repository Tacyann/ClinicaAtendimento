import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperaluno.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/models/aluno.dart';
import 'package:magister_mobile/data/models/curso.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditAluno extends StatefulWidget {
  final bool edit;
  final Aluno aluno;

  EditAluno(this.edit, {this.aluno}) : assert(edit == true || aluno == null);
  @override
  _EditCursoState createState() => _EditCursoState();
}

class _EditCursoState extends State<EditAluno> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController totalCreditoController = new TextEditingController();
  TextEditingController dataController = new TextEditingController();
  TextEditingController mgpController = new TextEditingController();
  TextEditingController idCursoController = new TextEditingController();
  Curso selected;
  String current = "Selecione Curso";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      nomeController.text = widget.aluno.nome.toString();
      totalCreditoController.text = widget.aluno.totalCredito.toString();
      dataController.text = widget.aluno.dataNascimento.toString();
      mgpController.text = widget.aluno.mgp.toString();
      HelperCurso.getInstance().getFirst(widget.aluno.idCurso).then((value) {
        current = value.nomeCurso;
      });
    }
  }

  void onPressed() async {
    if (!_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Carregando')));
    } else if (widget.edit == true) {
      HelperAluno.getInstance().update(new Aluno(
        id: widget.aluno.id,
        nomeAluno: nomeController.text,
        totalCredito: int.parse(totalCreditoController.text),
        dataNascimento: dataController.text,
        mgp: double.parse(mgpController.text),
        idCurso: int.parse(idCursoController.text),
      ));
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      await HelperAluno.getInstance().save(
        new Aluno(
          nomeAluno: nomeController.text,
          totalCredito: int.parse(totalCreditoController.text),
          dataNascimento: dataController.text,
          mgp: double.parse(mgpController.text),
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
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.edit ? "Editar Aluno" : "Novo Aluno"),
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
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Image.asset("assets/aluno.png"),
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
                    formField(nomeController, "Nome do Aluno", Icons.person,
                        TextInputType.text, Colors.indigoAccent,
                        initialValue: widget.edit ? widget.aluno.nome : "s"),
                    formField(
                      totalCreditoController,
                      "total crédito",
                      Icons.apps,
                      TextInputType.number,
                      Colors.indigoAccent,
                    ),
                    formField(
                        dataController,
                        "Data de nascimento",
                        Icons.calendar_today,
                        TextInputType.text,
                        Colors.indigoAccent,
                        initialValue: widget.edit ? widget.aluno.nome : "d"),
                    formField(
                      mgpController,
                      "MGP",
                      Icons.apps,
                      TextInputType.number,
                      Colors.indigoAccent,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.indigoAccent, width: 1),
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
                                      color: Colors.indigoAccent,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                          primaryColor: Colors.indigoAccent,
                                          accentColor: Colors.indigoAccent,
                                          hintColor: Colors.indigoAccent),
                                      child: DropdownButton<Curso>(
                                        style: TextStyle(
                                          color: Colors.indigoAccent,
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
