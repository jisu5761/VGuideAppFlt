import 'package:flutter/material.dart';

class MyEdit extends StatelessWidget {
  const MyEdit(
      {Key? key,
      required this.text,
      required this.textwidth,
      required this.txtSetController,
      required this.boolean})
      : super(key: key);

  final String text;
  final double textwidth;
  final TextEditingController txtSetController;
  final bool boolean;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: textwidth,
          child: Text(
            text,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 35,
          width: 60,
          //child: Flexible(
          child: TextField(
            enabled: boolean,
            controller: txtSetController,
            //onSubmitted: _handleSubmitted,
            decoration: const InputDecoration(
              // labelText: '값이 작을수록 먼거리 (1~255)',
              // hintText: '(1~255)',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
          //),
        )
      ],
    );
  }
}

class MyMute extends StatefulWidget {
  MyMute({
    Key? key,
    required this.text1,
    required this.text2,
    required this.textwidth,
  }) : super(key: key);

  final String text1;
  final String text2;
  final double textwidth;

  @override
  State<MyMute> createState() => _MyMuteState();
}

class _MyMuteState extends State<MyMute> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: widget.textwidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.text1,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.text2,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyCombo extends StatelessWidget {
  MyCombo(
      {Key? key,
      required this.text,
      required this.itemList,
      required this.onChanged,
      required this.value,
      required this.textWidth,
      required this.comboWidth})
      : super(key: key);
  final String text;
  String value;
  final double textWidth;
  final double comboWidth;
  final List<String> itemList;
  final VoidCallback onChanged;
  final String _setvalue = '1';

  //final String newvalue;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: textWidth,
        child: Text(
          text,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        width: comboWidth,
        child: DropdownButton(
          value: value,
          isExpanded: true,
          //menuMaxHeight: 250,
          items: itemList.map((String itemText) {
            return DropdownMenuItem<String>(
              value: itemText,
              child: SizedBox(child: Text(itemText)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            value = newValue!;
          },
        ),
      ),
    ]);
  }
}
