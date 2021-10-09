import 'package:flutter/material.dart';
import 'common_components.dart';


void main()  {
  runApp(const MyApp());}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
  
class _MyAppState extends State<MyApp> {
  final name = TextEditingController();
  final address = TextEditingController();
  final price = TextEditingController();
  final gst = TextEditingController();
  List<String> dropdownValues = ['One', 'Two', 'Free', 'Four'];
  String dropdownValue = 'One';

  var textlab = 'enter';
  final columns = ['name', 'address', 'price', 'gst'];
  List<DataRow> rowList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        NewWidgetTextfield(
                            myController: name,
                            labelText: 'Name',
                            hintText: 'enter '),
                        NewWidgetTextfield(
                            myController: address,
                            labelText: 'address',
                            hintText: ''),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        NewWidgetTextfield(
                            myController: price,
                            labelText: 'price',
                            hintText: '50'),
                        NewWidgetTextfield(
                            myController: gst,
                            labelText: 'GST',
                            hintText: '5%'),
                        TextButton(onPressed: _addRow, child: Text(textlab)),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          elevation: 0,
                          isExpanded: true,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: dropdownValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                DataTable(columns: getColumns(columns), rows: rowList),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _addRow() {
    setState(
      () {
        rowList.add(
          DataRow(
            cells: getCells(
              [
                name.text.toString(),
                address.text.toString(),
                price.text.toString(),
                gst.text.toString()
              ],
            ),
          ),
        );

        name.text = '';
        address.text = '';
        price.text = '';
        gst.text = '';
      },
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20.0, child: Text('Hello World'));
  }
}
