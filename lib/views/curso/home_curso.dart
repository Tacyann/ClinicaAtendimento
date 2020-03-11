import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helpercurso.dart';
import 'package:magister_mobile/data/models/curso.dart';
import 'package:magister_mobile/views/curso/edit_curso.dart';
import 'package:magister_mobile/views/curso/view_curso.dart';

class HomeCurso extends StatefulWidget {
  @override
  _HomeCursoState createState() => _HomeCursoState();
}

class _HomeCursoState extends State<HomeCurso> {
  @override
  void didUpdateWidget(HomeCurso oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CURSOS"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: HelperCurso.getInstance().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Curso item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.deepOrange),
                  onDismissed: (direction) {
                    HelperCurso.getInstance().delete(item.id);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(item.nomeCurso.toString()),
                      subtitle: Text("Credito: " + item.totalCredito.toString()),
                      leading: CircleAvatar(
                        child: Text(
                          item.id.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.deepOrange,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewCurso(curso: item)));
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
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditCurso(false)));
          }),
    );
  }
}
