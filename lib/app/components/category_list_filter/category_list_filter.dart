import 'package:flutter/material.dart';

class CategoryListFilter extends StatefulWidget {
  const CategoryListFilter({Key? key}) : super(key: key);

  @override
  State<CategoryListFilter> createState() => _CategoryListFilterState();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  NewItem(this.isExpanded, this.header, this.body, this.iconpic);
}

class _CategoryListFilterState extends State<CategoryListFilter> {
  List<NewItem> items = <NewItem>[
    NewItem(
        false, // isExpanded ?
        'Header', // header
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              const Text('data'),
              const Text('data'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('data'),
                  Text('data'),
                  Text('data'),
                ],
              ),
              const Radio(value: null, groupValue: null, onChanged: null)
            ])), // body
        const Icon(Icons.image) // iconPic
        ),
  ];

  late ListView listCriteria;

  @override
  Widget build(BuildContext context) {
    listCriteria = ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: item.iconpic,
                    title: Text(
                      item.header,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
                isExpanded: item.isExpanded,
                body: item.body,
              );
            }).toList(),
          ),
        ),
      ],
    );

    return listCriteria;
  }
}
