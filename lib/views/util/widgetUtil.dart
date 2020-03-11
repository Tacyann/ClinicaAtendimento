import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

Widget faixaCard(Color color, String title) {
  return Card(
      color: color,
      elevation: 0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
      ),
    ),
  );
}

Widget viewCard(String up, String down, BuildContext context, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 1.0),
    child: Container(
      height: MediaQuery.of(context).size.height / 9,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            up,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          Text(
            down,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget menuCard(IconData icon, String nome, Color color, Widget proximo,
    BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    )),
    color: color,
    margin: EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => proximo,
        ));
      },
      splashColor: Colors.blue,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 80.0,
              color: Colors.white,
            ),
            Text(
              nome.toUpperCase(),
              style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buttonSave(
    Color color, Color color2, BuildContext context, Function onPressed) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 32,
      right: 32,
      top: 16,
    ),
    child: Container(
      height: MediaQuery.of(context).size.height / 12,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [color, color2],
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: FlatButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          "Salvar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    ),
  );
}

Widget formField(TextEditingController controller, String label, IconData icon,
    TextInputType type, Color color,
    {String initialValue}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1),
      ),
      child: Theme(
        data: new ThemeData(
            primaryColor: color, accentColor: color, hintColor: color),
        child: TextFormField(
          keyboardType: type,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(icon),
            labelText: label.toUpperCase(),
            labelStyle: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Campo em branco!';
            }
          },
        ),
      ),
    ),
  );
}

Widget formFieldMask(TextEditingController controller, String label, IconData icon,
    TextInputType type, Color color, int maxlength,
    {String initialValue}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1),
      ),
      child: Theme(
        data: new ThemeData(
            primaryColor: color, accentColor: color, hintColor: color),
        child: MaskedTextField(
          keyboardType: type,
          maxLength: maxlength,
          mask: "xx/xx/xxxx",
          maskedTextFieldController: controller,
          inputDecoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(icon),
            labelText: label.toUpperCase(),
            labelStyle: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

