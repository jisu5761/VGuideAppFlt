import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

import 'blueprovider.dart';
import 'constants.dart';

class SoundSection extends StatefulWidget {
  SoundSection({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  State<SoundSection> createState() => _SoundSection();
}

class _SoundSection extends State<SoundSection> {
  late BlueProvider _blueProvider;
  TextEditingController nightStartController = TextEditingController();
  TextEditingController nightEndController = TextEditingController();
  TextEditingController nowTimeController = TextEditingController();
  TextEditingController devTimeController = TextEditingController();

  String _nightOffset = '4';
  String _masterValue = '8';
  String _womanValue = '8';
  String _manValue = '8';
  String _birdValue = '8';
  String _cricketValue = '8';
  String _dingValue = '8';
  String _melodyValue = '8';
  String _etcValue = '8';
  int _nightStart = 1;
  int _nightEnd = 1;
  static const List<String> itemList = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];

  @override
  Widget build(BuildContext context) {
    _blueProvider = Provider.of<BlueProvider>(context, listen: false);
    _womanValue = (Provider.of<BlueProvider>(context).womanvol.toString());
    _manValue = (Provider.of<BlueProvider>(context).manvol.toString());
    _birdValue = (Provider.of<BlueProvider>(context).birdvol.toString());
    _cricketValue = (Provider.of<BlueProvider>(context).cricketvol.toString());
    _dingValue = (Provider.of<BlueProvider>(context).dingvol.toString());
    _melodyValue = (Provider.of<BlueProvider>(context).melodyvol.toString());
    _etcValue = (Provider.of<BlueProvider>(context).etcvol.toString());
    _nightOffset = (Provider.of<BlueProvider>(context).nightOffset.toString());
    // _nightStart = (Provider.of<BlueProvider>(context).nightStart);
    // _nightEnd = (Provider.of<BlueProvider>(context).nightEnd);
    devTimeController.text = (Provider.of<BlueProvider>(context).devtime);
    nightStartController.text =
        (Provider.of<BlueProvider>(context).nightStart.toString().padLeft(4, '0'));
    nightEndController.text =
        (Provider.of<BlueProvider>(context).nightEnd.toString().padLeft(4, '0'));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton(
                  value: _masterValue,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _masterValue = newValue!;
                    });
                  },
                ),
                TextButton.icon(
                    onPressed: () {
                      _blueProvider.setWomanvolume(int.parse(_masterValue));
                      _blueProvider.setManvolume(int.parse(_masterValue));
                      _blueProvider.setBirdvolume(int.parse(_masterValue));
                      _blueProvider.setCricketvolume(int.parse(_masterValue));
                      _blueProvider.setDingvolume(int.parse(_masterValue));
                      _blueProvider.setMelodyvolume(int.parse(_masterValue));
                      _blueProvider.setEtcvolume(int.parse(_masterValue));
                      _sendcommand(0x61);
                    },
                    icon: Icon(Icons.settings),
                    label: Text(
                      '음량 설정 [ 기본값 ]',
                      style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: Text(
                    '여자',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  value: _womanValue,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _womanValue = newValue!;
                      _blueProvider.setWomanvolume(itemList.indexOf(newValue));
                      _sendcommand(0x31);
                    });
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 80,
                  child: Text(
                    '남자',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  value: _manValue,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _manValue = newValue!;
                      _blueProvider.setManvolume(itemList.indexOf(newValue));
                      _sendcommand(0x32);
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: Text(
                    '새',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  value: _birdValue,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _birdValue = newValue!;
                      _blueProvider.setBirdvolume(itemList.indexOf(newValue));
                      _sendcommand(0x33);
                    });
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 80,
                  child: Text(
                    '귀뚜라미',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownButton(
                  value: _cricketValue,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _cricketValue = newValue!;
                      _blueProvider
                          .setCricketvolume(itemList.indexOf(newValue));
                      _sendcommand(0x34);
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: Text(
                    '딩동댕',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  value: _dingValue,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _dingValue = newValue!;
                      _blueProvider.setDingvolume(itemList.indexOf(newValue));
                      _sendcommand(0x35);
                    });
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 80,
                  child: Text(
                    '멜로디',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownButton(
                  value: _melodyValue,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _melodyValue = newValue!;
                      _blueProvider.setMelodyvolume(itemList.indexOf(newValue));
                      _sendcommand(0x36);
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: Text(
                    '설정',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  value: _etcValue,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _etcValue = newValue!;
                      _blueProvider.setEtcvolume(itemList.indexOf(newValue));
                      _sendcommand(0x37);
                    });
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                Opacity(
                  opacity: 0.0,
                  child: Container(
                    width: 80,
                    child: Text(
                      '멜로디',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: DropdownButton(
                    value: _melodyValue,
                    menuMaxHeight: 250,
                    items: itemList.map((String itemText) {
                      return DropdownMenuItem<String>(
                        value: itemText,
                        child: SizedBox(child: Text(itemText)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _melodyValue = newValue!;
                        _blueProvider
                            .setMelodyvolume(itemList.indexOf(newValue));
                        _sendcommand(0x36);
                      });
                    },
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 10.0,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, elevatedbuttonheight)),
                    onPressed: () => _sendcommand(0x56),
                    icon: Icon(
                      Icons.volume_up_rounded,
                    ),
                    label: Text(
                      '안내 방송',
                      style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                    )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, elevatedbuttonheight)),
                    onPressed: () => _sendcommand(0x76),
                    icon: Icon(
                      Icons.volume_up_rounded,
                    ),
                    label: Text(
                      '신호 방송',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, elevatedbuttonheight)),
                    onPressed: () => _sendcommand(0x73),
                    icon: Icon(
                      Icons.volume_off,
                    ),
                    label: Text(
                      '안내 중지',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, elevatedbuttonheight)),
                    onPressed: () {
                      DateTime now = DateTime.now();
                      nowTimeController.text = now.year.toString() +
                          "-" +
                          now.month.toString().padLeft(2, '0') +
                          "-" +
                          now.day.toString().padLeft(2, '0') +
                          " " +
                          now.hour.toString().padLeft(2, '0') +
                          ":" +
                          now.minute.toString().padLeft(2, '0');
                      _sendcommand(0x4F);
                    },
                    icon: Icon(
                      Icons.speaker,
                    ),
                    label: Text(
                      '음량 읽기',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 10.0,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              //width: 80.0,
              child: Text(
                ' 펌웨어 버전 J 이후 사용 가능 ',
                style:
                TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 20.0,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80.0,
                  child: Text(
                    ' 야간시작 ',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 35,
                  width: 80,
                  //child: Flexible(
                  child: TextField(
                    enabled: true,
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                    controller: nightStartController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  //),
                ),
                Container(
                  width: 80.0,
                  child: Text(
                    ' 야간종료 ',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 35,
                  width: 80,
                  //child: Flexible(
                  child: TextField(
                    enabled: true,
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                    controller: nightEndController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  //),
                )
              ],
            ),
            Container(
              //height: 30,
              alignment: Alignment.center,
              child: Text(
                ' 시간설정 예) 오후 8시 => 2000 \r\n'
                    '기능 해제시 야간시작,야간종료 => 1',
                style:
                TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: Text(
                    '야간 음량 \r\n차이 설정',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  value: _nightOffset,
                  menuMaxHeight: 250,
                  items: itemList.map((String itemText) {
                    return DropdownMenuItem<String>(
                      value: itemText,
                      child: SizedBox(child: Text(itemText)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _nightOffset = newValue!;
                      _blueProvider.setNightoffset(itemList.indexOf(newValue));
                    });
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                Opacity(
                  opacity: 0.0,
                  child: Container(
                    width: 80,
                    child: Text(
                      '남자',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: DropdownButton(
                    value: _manValue,
                    menuMaxHeight: 250,
                    items: itemList.map((String itemText) {
                      return DropdownMenuItem<String>(
                        value: itemText,
                        child: SizedBox(child: Text(itemText)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _manValue = newValue!;
                        _blueProvider.setManvolume(itemList.indexOf(newValue));
                        _sendcommand(0x32);
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100.0,
                  child: Text(
                    ' 현재시각 ',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 35,
                  width: 200,
                  //child: Flexible(
                  child: TextField(
                    enabled: false,
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                    controller: nowTimeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  //),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100.0,
                  child: Text(
                    ' 장비시각 ',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 35,
                  width: 200,
                  //child: Flexible(
                  child: TextField(
                    enabled: false,
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                    controller: devTimeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  //),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, elevatedbuttonheight)),
                    onPressed: () {
                      DateTime now = DateTime.now();

                      String convertedDateTime =
                          "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}-${now.minute.toString()}";
                      nowTimeController.text = now.year.toString() +
                          "-" +
                          now.month.toString().padLeft(2, '0') +
                          "-" +
                          now.day.toString().padLeft(2, '0') +
                          " " +
                          now.hour.toString().padLeft(2, '0') +
                          ":" +
                          now.minute.toString().padLeft(2, '0');

                      _nightStart =
                          int.parse(nightStartController.text.toString().padLeft(4, '0'));
                      _nightEnd = int.parse(nightEndController.text.toString().padLeft(4, '0'));
                      _sendcommand(0x54);
                    },
                    icon: Icon(
                      Icons.nightlight_rounded,
                    ),
                    label: Text(
                      '야간 설정',
                      style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                    )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, elevatedbuttonheight)),
                    onPressed: () {
                      DateTime now = DateTime.now();
                      nowTimeController.text = now.year.toString() +
                          "-" +
                          now.month.toString().padLeft(2, '0') +
                          "-" +
                          now.day.toString().padLeft(2, '0') +
                          " " +
                          now.hour.toString().padLeft(2, '0') +
                          ":" +
                          now.minute.toString().padLeft(2, '0');
                      _sendcommand(0x74);
                    },
                    icon: Icon(
                      Icons.nightlight_outlined,
                    ),
                    label: Text(
                      '야간 읽기',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _sendcommand(int? cmd) async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == HAN_UART_SERVICE) {
        List<BluetoothCharacteristic> blueChar = service.characteristics;
        blueChar.forEach((f) {
          if (f.uuid.toString().compareTo(HAN_UART_READ_CHARACTERISTIC) == 0) {
            debugPrint("${service.uuid}");
            debugPrint("Characteristice =  ${f.uuid}");
            List<int> cmdList = [
              0xA2,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0x00,
              0xA3
            ];
            int bcc = 0;
            cmdList[1] = cmd!;
            if (cmd == 0x31) {
              cmdList[2] = _blueProvider.womanvol;
            } else if (cmd == 0x32) {
              cmdList[3] = _blueProvider.manvol;
            } else if (cmd == 0x33) {
              cmdList[4] = _blueProvider.birdvol;
            } else if (cmd == 0x34) {
              cmdList[5] = _blueProvider.cricketvol;
            } else if (cmd == 0x35) {
              cmdList[6] = _blueProvider.dingvol;
            } else if (cmd == 0x36) {
              cmdList[7] = _blueProvider.melodyvol;
            } else if (cmd == 0x37) {
              cmdList[8] = _blueProvider.etcvol;
            } else if (cmd == 0x61) {
              cmdList[2] = _blueProvider.womanvol;
              cmdList[3] = _blueProvider.manvol;
              cmdList[4] = _blueProvider.birdvol;
              cmdList[5] = _blueProvider.cricketvol;
              cmdList[6] = _blueProvider.dingvol;
              cmdList[7] = _blueProvider.melodyvol;
              cmdList[8] = _blueProvider.etcvol;
            } else if (cmd == 0x54) {
              cmdList[8] = int.parse(_nightOffset);
              cmdList[9] = _nightStart & 0xFF;
              cmdList[10] = (_nightStart >> 8) & 0xFF;
              cmdList[11] = _nightEnd & 0xFF;
              cmdList[12] = (_nightEnd >> 8) & 0xFF;

              DateTime now = DateTime.now();
              cmdList[13] = now.year - 2000;
              cmdList[14] = now.month;
              cmdList[15] = now.day;
              cmdList[16] = now.hour;
              cmdList[17] = now.minute;
            }
            cmdList.forEach((num) {
              bcc ^= num;
            });

            cmdList.add(bcc);
            f.write(cmdList, withoutResponse: true);
            debugPrint('CMD = ' + cmdList.toString());
          }
        });
      }
    });
  }
}
