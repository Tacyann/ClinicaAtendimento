import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/helpers/helperprofessor.dart';
import 'package:magister_mobile/data/models/curso.dart';
import 'package:magister_mobile/data/models/professor.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditCurso extends StatefulWidget {
  final bool edit;
  final Curso curso;

  EditCurso(this.edit, {this.curso}) : assert(edit == true || curso == null);
  @override
  _EditCursoState createState() => _EditCursoState();
}

class _EditCursoState extends State<EditCurso> {
  HelperProfessor helper = new HelperProfessor();
  TextEditingController nomeController = new TextEditingController();
  TextEditingController totalCreditoController = new TextEditingController();
  TextEditingController idCoordenadorController = new TextEditingController();
  List<Professor> professores = new List();
  Professor selected;
  String current = "Selecione coordenador".toUpperCase();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      nomeController.text = widget.curso.nomeCurso.toString();
      totalCreditoController.text = widget.curso.totalCredito.toString();
      HelperProfessor.getInstance().getFirst(widget.curso.idCoordenador).then((value){
        current = value.nomeProf;
      });
    }
    helper.getAll().then((list) {
      setState(() {
        professores = list;
      });
    });
  }

  void onPressed() async {
    if (!_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Carregando')));
    } else if (widget.edit == true) {
      HelperCurso.getInstance().update(new Curso(
        id: widget.curso.id,
        nomeCurso: nomeController.text,
        totalCredito: int.parse(totalCreditoController.text),
        idCoordenador: int.parse(idCoordenadorController.text),
      ));
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      await HelperCurso.getInstance().save(
        new Curso(
          nomeCurso: nomeController.text,
          totalCredito: int.parse(totalCreditoController.text),
          idCoordenador: int.parse(idCoordenadorController.text),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Editar Curso" : "Adicionar Curso"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: (){
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
              color: Colors.deepOrange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Image.asset("assets/curso.png"),
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
                    formField(
                        nomeController,
                        "Nome do curso",
                        Icons.school,
                        TextInputType.text,
                        Colors.deepOrange,
                         initialValue: widget.edit ? widget.curso.nomeCurso : "n"),
                    formField(
                        totalCreditoController,
                        "Total de crédito",
                        Icons.apps,
                        TextInputType.number,
                        Colors.deepOrange,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.deepOrange, width: 1),
                        ),
                        child: FutureBuilder<List>(
                            future: HelperProfessor.getInstance().getAll(),
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
                                      Icons.person,
                                      color: Colors.deepOrange,
                                    ),
                                    Theme(
                                      data: new ThemeData(
                                          primaryColor: Colors.deepOrange,
                                          accentColor: Colors.deepOrange,
                                          hintColor: Colors.deepOrange),
                                      child: DropdownButton<Professor>(
                                        style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: snapshot.data
                                            .map((professor) =>
                                                DropdownMenuItem<Professor>(
                                                  child:
                                                      Text(professor.nomeProf),
                                                  value: professor,
                                                ))
                                            .toList(),
                                        onChanged: (Professor value) {
                                          setState(() {
                                            selected = value;
                                            idCoordenadorController.text =
                                                selected.id.toString();
                                            current = value.nomeProf;
                                          });
                                        },
                                        isExpanded: false,
                                        //value: _currentUser,
                                        hint: Text(current),
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
