import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperdisciplina.dart';
import 'package:magister_mobile/data/models/disciplina.dart';
import 'package:magister_mobile/views/disciplina/edit_disciplina.dart';
import 'package:magister_mobile/views/disciplina/view_disciplina.dart';

class HomeDisciplina extends StatefulWidget {
  @override
  _HomeDisciplinaState createState() => _HomeDisciplinaState();
}

class _HomeDisciplinaState extends State<HomeDisciplina> {
  @override
  void didUpdateWidget(HomeDisciplina oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DISCIPLINAS"),
        backgroundColor: Colors.purple,
        elevation: 1,
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: HelperDisciplina.getInstance().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Disciplina item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.purple),
                  onDismissed: (direction) {
                    HelperDisciplina.getInstance().delete(item.id);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(item.nomeDisc.toString()),
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Text(item.id.toString(),
                            style: TextStyle(color: Colors.white)),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewDisciplina(
                                  disciplina: item,
                                )));
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditDisciplina(false)));
          }),
    );
  }
}
