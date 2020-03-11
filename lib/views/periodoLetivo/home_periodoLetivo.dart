import 'package:flutter/material.dart';
import 'package:magister_mobile/data/helpers/helperperiodo.dart';
import 'package:magister_mobile/data/models/periodoletivo.dart';
import 'package:magister_mobile/views/periodoLetivo/edit_periodoLetivo.dart';

class HomePeriodoLetivo extends StatefulWidget {
  @override
  _HomePeriodoLetivoState createState() => _HomePeriodoLetivoState();
}

class _HomePeriodoLetivoState extends State<HomePeriodoLetivo> {
  @override
  void didUpdateWidget(HomePeriodoLetivo oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PERIODO LETIVO"),
        backgroundColor: Colors.lightGreen,
        elevation: 1,
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: HelperPeriodo.getInstance().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                PeriodoLetivo item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.lightGreen),
                  onDismissed: (direction) {
                    HelperPeriodo.getInstance()
                        .deletePeriodo(item.ano, item.semestre);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                          item.ano.toString() + "." + item.semestre.toString()),
                      subtitle: Text(item.dataInicio.toString() +
                          " - " +
                          item.dataFinal.toString()),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditPeriodoLetivo(
                                  true,
                                  periodo: item,
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
          backgroundColor: Colors.lightGreen,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditPeriodoLetivo(false)));
          }),
    );
  }
}
