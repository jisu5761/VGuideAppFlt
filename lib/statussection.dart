import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:sguideappflt/mywidget.dart';
import 'package:provider/provider.dart';
import 'package:sguideappflt/blueprovider.dart';
import 'constants.dart';

class StatusSection extends StatefulWidget {
  const StatusSection({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  State<StatusSection> createState() => _StatusSectionState();
}

class _StatusSectionState extends State<StatusSection> {
  late BlueProvider _blueProvider;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController posSetController = TextEditingController();
  TextEditingController sigSetController = TextEditingController();
  TextEditingController posRcvController = TextEditingController();
  TextEditingController sigRcvController = TextEditingController();
  TextEditingController devController = TextEditingController();
  TextEditingController rf235RcvController = TextEditingController();

  String _deviceidValue = '1';
  String _sexValue = '여자';
  String _womanMute1 = '8';
  String _womanMute2 = '8';
  String _manMute1 = '8';
  String _manMute2 = '8';
  String _birdcricketValue = '새';
  String _crossValue = '교차로';
  String _pillarValue = '일반지주';
  String _setupValue = '미설정';
  String _afterValue = '먼저';

  List<String> itemList = [
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
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33'
  ];
  List<String> muteList = [
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
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '20',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
  ];
  String _devidvalue = '0';
  String _groupvalue = '1';
  String _womanmute1 = '8';
  String _womanmute2 = '8';
  String _manmute1 = '8';
  String _manmute2 = '8';

  @override
  Widget build(BuildContext context) {
    _blueProvider = Provider.of<BlueProvider>(context, listen: false);
    posRcvController.text =
        (Provider.of<BlueProvider>(context).posrcvdata.toString());
    sigRcvController.text =
        (Provider.of<BlueProvider>(context).sigrcvdata.toString());

    devController.text =
        (Provider.of<BlueProvider>(context).devnumber.toString());

    posSetController.text =
        (Provider.of<BlueProvider>(context).possetdata.toString());
    sigSetController.text =
        (Provider.of<BlueProvider>(context).sigsetdata.toString());

    rf235RcvController.text =
        (Provider.of<BlueProvider>(context).rf235rssircv.toString());

    _devidvalue = (Provider.of<BlueProvider>(context).devid.toString());
    _womanmute1 = (Provider.of<BlueProvider>(context).womanmute1.toString());
    _womanmute2 = (Provider.of<BlueProvider>(context).womanmute2.toString());
    _manmute1 = (Provider.of<BlueProvider>(context).manmute1.toString());
    _manmute2 = (Provider.of<BlueProvider>(context).manmute2.toString());
    _sexValue = (Provider.of<BlueProvider>(context).sexValue.toString());
    _birdcricketValue =
        (Provider.of<BlueProvider>(context).birdCricketValue.toString());
    _crossValue = (Provider.of<BlueProvider>(context).crossValue.toString());
    _pillarValue = (Provider.of<BlueProvider>(context).pillarValue.toString());
    _setupValue = (Provider.of<BlueProvider>(context).setupValue.toString());
    _afterValue = (Provider.of<BlueProvider>(context).firstValue.toString());
    // _groupvalue = (Provider.of<BlueProvider>(context).groupid.toString());
    var bodyProgress = new Container(
      alignment: AlignmentDirectional.center,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          new Center(
            child: new SizedBox(
              height: 50.0,
              width: 50.0,
              child: new CircularProgressIndicator(
                value: null,
                strokeWidth: 7.0,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: !isReady
            ? bodyProgress
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 80.0,
                          child: Text(
                            '장비ID',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 50,
                          child: DropdownButton(
                            value: _devidvalue,
                            isExpanded: true,
                            items: itemList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _devidvalue = _blueProvider
                                    .setDevidset(itemList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        Container(
                          height: 35,
                          width: 140,
                          //child: Flexible(
                          child: TextField(
                            enabled: false,
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                            controller: devController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          //),
                        )

                        // Opacity(
                        //   opacity: 0.0,
                        //   child: Container(
                        //     width: 80.0,
                        //     child: Text(
                        //       '묶음ID',
                        //       style: TextStyle(
                        //           fontSize: 15.0, fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        // ),
                        // Opacity(
                        //   opacity: 0.0,
                        //   child: Container(
                        //     width: 50,
                        //     child: DropdownButton(
                        //       value: _groupvalue,
                        //       isExpanded: true,
                        //       items: itemList.map((String itemText) {
                        //         return DropdownMenuItem<String>(
                        //           value: itemText,
                        //           child: SizedBox(child: Text(itemText)),
                        //         );
                        //       }).toList(),
                        //       onChanged: (String? newValue) {
                        //         setState(() {
                        //           _groupvalue = _blueProvider
                        //               .setGroupidset(itemList.indexOf(newValue!));
                        //         });
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyEdit(
                          text: '안내 거리',
                          textwidth: 80.0,
                          txtSetController: posSetController,
                          boolean: false,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MyEdit(
                          text: '안내 수신',
                          textwidth: 80.0,
                          txtSetController: posRcvController,
                          boolean: false,
                        ),
                      ],
                    ),
                    //안내거리
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyEdit(
                          text: '신호 거리',
                          textwidth: 80.0,
                          txtSetController: sigSetController,
                          boolean: false,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MyEdit(
                          text: '신호 수신',
                          textwidth: 80.0,
                          txtSetController: sigRcvController,
                          boolean: false,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyEdit(
                          text: '235 거리',
                          textwidth: 80.0,
                          txtSetController: rf235RcvController,
                          boolean: false,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: MyEdit(
                            text: '신호 수신',
                            textwidth: 80.0,
                            txtSetController: rf235RcvController,
                            boolean: false,
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
                          width: dropboxWidth,
                          child: DropdownButton(
                            value: _sexValue,
                            isExpanded: true,
                            items: sexList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _blueProvider
                                    .setSexvalue(sexList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: dropboxWidth,
                          child: DropdownButton(
                            value: _birdcricketValue,
                            isExpanded: true,
                            items: birdCricketList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _blueProvider.setBirdcrickervalue(
                                    birdCricketList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: dropboxWidth,
                          child: DropdownButton(
                            value: _crossValue,
                            isExpanded: true,
                            items: crossList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _blueProvider.setCrossvalue(
                                    crossList.indexOf(newValue!));
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
                          width: dropboxWidth,
                          child: DropdownButton(
                            value: _pillarValue,
                            isExpanded: true,
                            items: pillarList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _blueProvider.setPillarvalue(
                                    pillarList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: dropboxWidth,
                          child: DropdownButton(
                            value: _setupValue,
                            isExpanded: true,
                            items: setupList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _blueProvider.setSetupvalue(
                                    setupList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: dropboxWidth,
                          child: DropdownButton(
                            value: _afterValue,
                            isExpanded: true,
                            items: afterList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _blueProvider.setFirstvalue(
                                    afterList.indexOf(newValue!));
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
                        MyMute(
                          text1: '여자묵음 1',
                          text2: '(단위:0.5초)',
                          textwidth: 80,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          child: DropdownButton(
                            value: _womanmute1,
                            isExpanded: true,
                            items: muteList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _womanmute1 = _blueProvider.setWomanmute1set(
                                    muteList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MyMute(
                          text1: '여자묵음 2',
                          text2: '(단위:0.5초)',
                          textwidth: 80,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          child: DropdownButton(
                            value: _womanmute2,
                            isExpanded: true,
                            items: muteList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _womanmute2 = _blueProvider.setWomanmute2set(
                                    muteList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    //여자묵음
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyMute(
                          text1: '남자묵음 1',
                          text2: '(단위:0.5초)',
                          textwidth: 80,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          child: DropdownButton(
                            value: _manmute1,
                            isExpanded: true,
                            items: muteList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _manmute1 = _blueProvider.setManmute1set(
                                    muteList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MyMute(
                          text1: '남자묵음 2',
                          text2: '(단위:0.5초)',
                          textwidth: 80,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          child: DropdownButton(
                            value: _manmute2,
                            isExpanded: true,
                            items: muteList.map((String itemText) {
                              return DropdownMenuItem<String>(
                                value: itemText,
                                child: SizedBox(child: Text(itemText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _manmute2 = _blueProvider.setManmute2set(
                                    muteList.indexOf(newValue!));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    //남자묵음

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
                              _sendcommand(0x52);
                            },
                            icon: Icon(
                              Icons.refresh_outlined,
                            ),
                            label: Text('설정 읽기',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  letterSpacing: 2.0,
                                  color: Colors.white,
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, elevatedbuttonheight)),
                            onPressed: () => _sendcommand(0x41),
                            icon: Icon(
                              Icons.settings_applications_outlined,
                            ),
                            label: Text(
                              '설정 시작',
                              style:
                                  TextStyle(fontSize: 20.0, letterSpacing: 2.0),
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
                            onPressed: () => _sendcommand(0x69),
                            icon: Icon(
                              Icons.send_and_archive_outlined,
                            ),
                            label: Text(
                              '설정 전송',
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
                            onPressed: () => _sendcommand(0x53),
                            icon: Icon(
                              Icons.save_alt_outlined,
                            ),
                            label: Text(
                              '설정 저장',
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
                            onPressed: () => _sendcommand(0x43),
                            icon: Icon(
                              Icons.cancel_rounded,
                            ),
                            label: Text(
                              '설정 취소',
                              style: TextStyle(
                                fontSize: 20.0,
                                letterSpacing: 2.0,
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 60)),
                              onPressed: () => _sendcommand(0x53),
                              icon: Icon(
                                Icons.save_alt_outlined,
                              ),
                              label: Text(
                                '설정 저장',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  letterSpacing: 2.0,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => _sendcommand(0x52),
      //   icon: Icon(Icons.refresh),
      //   label: Text(
      //     '설정읽기',
      //     style: TextStyle(fontSize: 20.0),
      //   ),
      // ),
    );
  }

  _sendcommand(int? cmd) async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == WOO_UART_SERVICE) {
        List<BluetoothCharacteristic> blueChar = service.characteristics;
        blueChar.forEach((f) {
          if (f.uuid.toString().compareTo(WOO_UART_READ_CHARACTERISTIC) == 0) {
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
            if (cmd == 0x69) {
              cmdList[2] = _blueProvider.devid;
              int _bitselcmd;
              if (_sexValue == sexList[0])
                _bitselcmd = 1;
              else
                _bitselcmd = 0;

              if (_birdcricketValue == birdCricketList[0]) _bitselcmd |= 0x02;
              if (_crossValue == crossList[0]) _bitselcmd |= 0x04;

              if (_pillarValue == pillarList[1])
                _bitselcmd |= 0x08;
              else if (_pillarValue == pillarList[2]) _bitselcmd |= 0x10;

              if (_setupValue == setupList[1]) _bitselcmd |= 0x20;

              if (_afterValue == afterList[0]) _bitselcmd |= 0x40;

              cmdList[13] = _bitselcmd;
              cmdList[14] = _blueProvider.womanmute1;
              cmdList[15] = _blueProvider.womanmute2;
              cmdList[16] = _blueProvider.manmute1;
              cmdList[17] = _blueProvider.manmute2;
            }
            cmdList.forEach((num) {
              bcc ^= num;
            });

            cmdList.add(bcc);
            f.write(cmdList, withoutResponse: true);
            debugPrint(cmdList.toString());
          }
        });
      }
    });
  }
}
