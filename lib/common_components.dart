import 'package:flutter/material.dart';

class CheckboxState {
  final String title;
  bool value;
  var activeColor = Colors.brown;
  CheckboxState({
    required this.title,
    this.value = false,
  });
}

class TextFormFieldState {
  final String title;
  final myController = TextEditingController();
  var activeColor = Colors.brown;
  TextFormFieldState({
    required this.title,
  });
}

class NewWidgetTextfield extends StatelessWidget {
  const NewWidgetTextfield({
    Key? key,
    required this.myController,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController myController;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: TextFormField(
        controller: myController,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}

List<DataCell> getCells(List<String> cells) {
  return cells.map((String cell) {
    return DataCell(
      Text(cell),
    );
  }).toList();
}

List<DataColumn> getColumns(List<String> colums) {
  return colums.map((String colum) {
    return DataColumn(
      label: Text(colum),
    );
  }).toList();
}
