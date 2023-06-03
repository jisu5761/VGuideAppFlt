import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'blueprovider.dart';
import 'constants.dart';
import 'mywidget.dart';

class RfSection extends StatefulWidget {
  RfSection({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;
  late BlueProvider _blueProvider;

  @override
  State<RfSection> createState() => _RfSection();
}

class _RfSection extends State<RfSection> {
  late BlueProvider _blueProvider;
  FocusNode _posFocus = FocusNode();
  FocusNode _sigFocus = FocusNode();
  FocusNode _beaconFocus = FocusNode();
  TextEditingController _posSetController = TextEditingController();
  TextEditingController _sigSetController = TextEditingController();
  TextEditingController _posRcvController = TextEditingController();
  TextEditingController _sigRcvController = TextEditingController();
  TextEditingController _ssidController = TextEditingController();
  TextEditingController _beaconRcvController = TextEditingController();
  TextEditingController _beaconController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _blueProvider = Provider.of<BlueProvider>(context, listen: false);
    _posRcvController.text =
        (Provider.of<BlueProvider>(context).posrcvdata.toString());
    _sigRcvController.text =
        (Provider.of<BlueProvider>(context).sigrcvdata.toString());
    _beaconRcvController.text =
        (Provider.of<BlueProvider>(context).beaconrssi.toString());
    _beaconController.text =
      (Provider.of<BlueProvider>(context).beaconrssicutvalue.toString());

    return GestureDetector(
      onTap: () {
        _posFocus.unfocus();
        _sigFocus.unfocus();
        _beaconFocus.unfocus();
      },
      child: Container(
          margin: EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyEdit(
                      text: '위치 수신',
                      textwidth: 70.0,
                      txtSetController: _posRcvController,
                      boolean: false,
                    ),

                    Container(
                      width: 70.0,
                      child: Text(
                        '위치 설정',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 60,
                      //child: Flexible(
                      child: TextField(
                        enabled: true,
                        focusNode: _posFocus,
                        controller: _posSetController,
                        //onSubmitted: _handleSubmitted,
                        decoration: const InputDecoration(
                          // labelText: '값이 작을수록 먼거리 (1~255)',
                          // hintText: '(1~255)',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _sendcommand(0x72);
                          _posFocus.unfocus();
                        },
                        child: const Text('전송')),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyEdit(
                      text: '신호 수신',
                      textwidth: 70.0,
                      txtSetController: _sigRcvController,
                      boolean: false,
                    ),
                    // SizedBox(
                    //   width: 10.0,
                    // ),
                    Container(
                      width: 70.0,
                      child: Text(
                        '신호 설정',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 60,
                      //child: Flexible(
                      child: TextField(
                        enabled: true,
                        focusNode: _sigFocus,
                        controller: _sigSetController,
                        //onSubmitted: _handleSubmitted,
                        decoration: const InputDecoration(
                          // labelText: '값이 작을수록 먼거리 (1~255)',
                          // hintText: '(1~255)',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    ElevatedButton(
                        onPressed: () {
                          _sendcommand(0x67);
                          _sigFocus.unfocus();
                        },
                        child: const Text('전송')),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyEdit(
                      text: '비콘 수신',
                      textwidth: 70.0,
                      txtSetController: _beaconRcvController,
                      boolean: false,
                    ),

                    Container(
                      width: 70.0,
                      child: Text(
                        '비콘 설정\r\n(255이하)',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 60,
                      //child: Flexible(
                      child: TextField(
                        enabled: true,
                        focusNode: _beaconFocus,
                        controller: _beaconController,
                        //onSubmitted: _handleSubmitted,
                        decoration: const InputDecoration(
                          // labelText: '값이 작을수록 먼거리 (1~255)',
                          // hintText: '(1~255)',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _sendcommand(0x01);
                          _beaconFocus.unfocus();
                        },
                        child: const Text('전송')),
                  ],
                ),
                // SizedBox(
                //   height: 10.0,
                // ),
                Divider(
                  height: 60,
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: _ssidController,
                  // onSubmitted: sendMsg,  //키보드로 엔터 클릭 시 호출
                  // onChanged: checkText,  //text 가 입력될 때 마다 호출
                  decoration: InputDecoration(
                    // labelText: '텍스트 입력',
                    hintText: 'SSID 를 입력해주세요',
                    labelText: 'SSID 를 입력해주세요',
                    border: OutlineInputBorder(), //외곽선
                  ),
                ),


                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(minimumSize: Size(250, 60)),
                    onPressed: () {
                      DateTime now = DateTime.now();
                      _ssidController.text =
                          (now.year - 2000).toString().padLeft(2, '0') +
                              now.month.toString().padLeft(2, '0') +
                              now.day.toString().padLeft(2, '0') +
                              now.hour.toString().padLeft(2, '0') +
                              now.minute.toString().padLeft(2, '0');
                      _sendcommand(0x3B);
                    },
                    icon: Icon(
                      Icons.dynamic_form_outlined,
                    ),
                    label: Text(
                      'SSID 설정',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    )),
                Divider(
                  height: 60,
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(minimumSize: Size(250, 60)),
                    onPressed: () => _sendcommand(0x5E),
                    icon: Icon(
                      Icons.security_update,
                    ),
                    label: Text(
                      '펌웨어 업데이트',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    )),
              ],
            ),
          )),
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
            if (cmd == 0x72) {
              try {
                cmdList[8] = int.parse(_posSetController.text.toString());
              } catch (e) {
                debugPrint(e.toString());
                return;
              }
            } else if (cmd == 0x67) {
              try {
                cmdList[10] = int.parse(_sigSetController.text.toString());
              } catch (e) {
                debugPrint(e.toString());
                return;
              }
            } else if (cmd == 0x01) {
              try {
                cmdList[2] = int.parse(_beaconController.text.toString());
              } catch (e) {
                debugPrint(e.toString());
                return;
              }
            }else if (cmd == 0x3B) {
              try {
                int devnum = int.parse(_ssidController.text.toString());
                cmdList[5] = (devnum >> 24) & 0xFF;
                cmdList[4] = (devnum >> 16) & 0xFF;
                cmdList[3] = (devnum >> 8) & 0xFF;
                cmdList[2] = devnum & 0xFF;
              } catch (e) {
                debugPrint(e.toString());
                return;
              }
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
