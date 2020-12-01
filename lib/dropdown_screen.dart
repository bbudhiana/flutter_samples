import 'package:flutter/material.dart';

class DropdownScreen extends StatefulWidget {
  static const routeName = "/dropdown";

  @override
  _DropdownScreenState createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {
  //untuk tampung yang dipilih
  Person selectedPerson;

  //Data untuk dropdown nya
  List<Person> persons = [
    Person('bana'),
    Person('john'),
  ];

  //method create items dibuat dari data untuk items di dropdown
  List<DropdownMenuItem> generateItems(List<Person> persons) {
    List<DropdownMenuItem> items = [];

    for (var item in persons) {
      items.add(DropdownMenuItem(
        /*
          child nya text, dan value nya berupa person
        */
        child: Text(item.name),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo penggunaan Dropdown'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: DropdownButton(
              style: TextStyle(fontSize: 20, color: Colors.purple),
              isExpanded: true,
              value: selectedPerson,
              items: generateItems(persons),
              onChanged: (item) {
                setState(() {
                  selectedPerson = item;
                });
              },
            ),
          ),
          Text(
            selectedPerson != null ? selectedPerson.name : '-no choice-',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Person {
  String name;
  Person(this.name);
}
