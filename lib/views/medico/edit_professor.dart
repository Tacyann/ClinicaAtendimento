import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperprofessor.dart';
import 'package:magister_mobile/data/models/professor.dart';
import 'package:magister_mobile/views/util/widgetUtil.dart';

class EditProfessor extends StatefulWidget {
  final bool edit;
  final Professor professor;

  EditProfessor(this.edit, {this.professor})
      : assert(edit == true || professor == null);

  @override
  _EditProfessorState createState() => _EditProfessorState();
}

class _EditProfessorState extends State<EditProfessor> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController matriculaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      nomeController.text = widget.professor.nomeProf;
      matriculaController.text = widget.professor.matricula.toString();
    }
  }

  void onPressed() async {
    if (!_formKey.currentState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Carregando...')));
    } else if (widget.edit == true) {
      HelperProfessor.getInstance().update(new Professor(
        id: widget.professor.id,
        matricula: int.parse(matriculaController.text),
        nome: nomeController.text,
      ));
      Navigator.pop(context);
    } else {
      await HelperProfessor.getInstance().save(
        new Professor(
          nome: nomeController.text,
          matricula: int.parse(matriculaController.text),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.edit ? "Editar Professor" : "Novo Professor"),
        centerTitle: true,
        backgroundColor: Colors.amber,
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
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Image.asset("assets/professor.png"),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    formField(
                        nomeController,
                        "Nome",
                        Icons.person,
                        TextInputType.text,
                        Colors.amber,
                        initialValue: widget.edit ? widget.professor.nomeProf : "n"
                    ),
                    formField(
                        matriculaController,
                        "Matricula",
                        Icons.apps,
                        TextInputType.number,
                        Colors.amber,
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