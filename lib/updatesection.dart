import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'blueprovider.dart';
import 'constants.dart';

class UpdateSection extends StatefulWidget {
  const UpdateSection({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  State<UpdateSection> createState() => _UpdateSectionState();
}

class _UpdateSectionState extends State<UpdateSection> {
  late BlueProvider _blueProvider;
  FilePickerResult? filePickerResult;
  File? pickedFile;
  late Uint8List filebytes;
  // Uint8List cmdbytes = Uint8List(256 + 3);
  bool _isRunning = false;
  int fidx = 0;
  int _seconds = 0;
  int s_mode = 0;
  late Timer _timer;
  var _openResult = 'Unknown';
  String rcvoldcmd = '0';
  String _rf235Value = '30';
  FocusNode _gnumFocus = FocusNode();
  FocusNode _gcountFocus = FocusNode();
  FocusNode _gmemidFocus = FocusNode();

  TextEditingController gruopNumberContoller = TextEditingController();
  TextEditingController gruopMemberIDContoller = TextEditingController();
  TextEditingController gruopMemberCountContoller = TextEditingController();
  TextEditingController soundFileContoller = TextEditingController();
  TextEditingController sourceFileContoller = TextEditingController();

  static const List<String> rf235List = [
    '0',
    '5',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
    '55',
    '60',
    '65',
    '70',
    '75',
    '80',
    '85',
    '90',
    '95',
    '100'
  ];
  int crc16umts(List<int> bytes) {
    int crc = 0x0000;
    const int polynomial = 0x8005;
    for (final byte in bytes) {
      crc ^= byte << 8;
      for (int i = 0; i < 8; i++) {
        if ((crc & 0x8000) != 0) {
          crc = (crc << 1) ^ polynomial;
        } else {
          crc <<= 1;
        }
      }
    }
    return crc & 0xFFFF;
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {

      switch(s_mode)
      {
        case  0:
                  rcvoldcmd = '0';
                  _sendcommand(0x45);
                  s_mode ++;
                  break;

        case  1:  if(rcvoldcmd == 'E')
                  {
                    filebytes = pickedFile!.readAsBytesSync();
                    List<int> cmdbytes = [];
                    cmdbytes.add(0xF2);
                    cmdbytes.add(1);
                    cmdbytes.add(1);
                    cmdbytes.add(0x4D);
                    int i = 0;
                    for(i = 0;i < 256; i ++) {
                      cmdbytes.add(filebytes[fidx ++]);
                      if(fidx == filebytes.lengthInBytes)
                        {
                          break;
                        }
                    }
                    cmdbytes.add(0xF3);
                    int crc16 = crc16umts(cmdbytes);
                    cmdbytes.add(crc16 & 0xFF);
                    cmdbytes.add(crc16 >> 8);
                    print("cmdbytes.length = ");
                    print(cmdbytes.length);

                    _senddata('M',cmdbytes, cmdbytes.length);
                    rcvoldcmd = '0';
                    s_mode ++;
                  }
                  break;

        case  2:  if(rcvoldcmd == 'M')
                  {
                    List<int> cmdbytes = [];
                    cmdbytes.add(0xF2);
                    cmdbytes.add(1);
                    cmdbytes.add(1);
                    cmdbytes.add(0x4D);
                    int i = 0;
                    for(i = 0;i < 256; i ++) {
                      cmdbytes.add(filebytes[fidx ++]);
                      if(fidx == filebytes.lengthInBytes)
                      {
                        break;
                      }
                    }
                    cmdbytes.add(0xF3);
                    int bcc = 0;
                    cmdbytes.forEach((num) {
                      bcc ^= num;
                    });
                    cmdbytes.add(bcc);
                    _senddata('M',cmdbytes, cmdbytes.length);
                    rcvoldcmd = '0';
                  }
                  break;

        case  3:
                  break;
      }

      //_sendcommand(0x3D);   //'='
    });
  }
  void _stopTimer() {
    if(_isRunning)
      {
        _isRunning = false;
        _timer.cancel();

      }
  }
  getImageorVideoFromGallery(context) async {
    // filePickerResult = await FilePicker.platform.pickFiles();
    filePickerResult = await FilePicker.platform.pickFiles(type: FileType.any);

    if (filePickerResult != null) {
      pickedFile = File(filePickerResult!.files.single.path.toString());
      gruopNumberContoller.text = pickedFile.toString().split('/').last;
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) =>
      //     filePickerResult!.files.single.extension == 'bin'
      //         ? VideoBlock(file: pickedFile!)
      //         : ImageBlock(
      //       file: pickedFile!,
      //     )
      // )
      // );
    } else {
      // can perform some actions like notification etc
    }
  }
  @override
  Widget build(BuildContext context)  {

    _blueProvider = Provider.of<BlueProvider>(context, listen: false);

    _rf235Value = (Provider.of<BlueProvider>(context).rf235value.toString());

    gruopMemberIDContoller.text =
    (Provider
        .of<BlueProvider>(context)
        .groupMemberID
        .toString());
    gruopMemberCountContoller.text =
    (Provider
        .of<BlueProvider>(context)
        .groupMemberCount
        .toString());

    rcvoldcmd =
    (Provider
        .of<BlueProvider>(context)
        .oldcmd
        .toString());
    return GestureDetector(
      onTap: () {
        _gnumFocus.unfocus();
        _gcountFocus.unfocus();
        _gmemidFocus.unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60.0,
                    child: Text(
                      '음성파일',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 200,
                    //child: Flexible(
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: gruopNumberContoller,
                      // onSubmitted: sendMsg,  //키보드로 엔터 클릭 시 호출
                      // onChanged: checkText,  //text 가 입력될 때 마다 호출
                      focusNode: _gnumFocus,
                      decoration: InputDecoration(
                        // labelText: '텍스트 입력',
                        hintText: '음성 파일',
                        labelText: '음성 파일',
                        border: OutlineInputBorder(), //외곽선
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      style:
                      ElevatedButton.styleFrom(minimumSize: Size(80, 60)),
                      onPressed: () {
                        getImageorVideoFromGallery(context);

                      },
                      icon: Icon(
                        Icons.surround_sound_outlined,
                      ),
                      label: Text(
                        '음성파일\r\n   선택',
                        style: TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                            color: Colors.white),
                      )),
                  ElevatedButton.icon(
                      style:
                      ElevatedButton.styleFrom(minimumSize: Size(80, 60)),
                      onPressed: () async {
                        // final result = await OpenFile.open(pickedFile!.path);
                        // if(result.message == "done")
                        {
                          _stopTimer();
                          s_mode = 0;


                          _startTimer();
                        }

                      },
                      icon: Icon(
                        Icons.send_rounded,
                      ),
                      label: Text(
                        '음성파일\r\n   전송',
                        style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                height: 10,
                color: Colors.grey,
                thickness: 0.5,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150.0,
                    child: Text(
                      ' RF235출력\r\n(H 버전 이후) ',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    alignment: Alignment.center,
                    child: DropdownButton(
                      isExpanded: true,
                      value: _rf235Value,
                      menuMaxHeight: 250,
                      items: rf235List.map((String itemText) {
                        return DropdownMenuItem<String>(
                          value: itemText,
                          child: SizedBox(child: Text(itemText)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _rf235Value = newValue!;
                          _blueProvider.setRf235value(rf235List.indexOf(newValue));
                          _sendcommand(0x3D);   //'='
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              ElevatedButton.icon(
                  style:
                  ElevatedButton.styleFrom(minimumSize: Size(150, 60)),
                  onPressed: () {
                    _sendcommand(0x2B);
                  },
                  icon: Icon(
                    Icons.restart_alt_outlined,
                  ),
                  label: Text(
                    '재시작',
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _soundfiledown() async {
    if (_blueProvider.soundFilePath == "") {
      showAlertDialog("음성파일 오류", "음성파일을 확인해주세요");
      return;
    }
    _sendcommand(0x40);


    // File file = File(soundFilePath);
    // RandomAccessFile raf = file.openSync(mode: FileMode.read);
    // raf.setPositionSync(0);
    // Uint8List data = raf.readSync(20);
    // print(data.toString());
    // _senddtabuf(data);
  }

  _senddtabuf(List<int> cmd) async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == WOO_UART_SERVICE) {
        List<BluetoothCharacteristic> blueChar = service.characteristics;
        blueChar.forEach((f) {
          if (f.uuid.toString().compareTo(WOO_UART_READ_CHARACTERISTIC) == 0) {
            f.write(cmd, withoutResponse: true);
          }
        });
      }
    });
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
              0x02,
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
              0x03
            ];
            int bcc = 0;
            cmdList[1] = cmd!;
            if (cmd == 0x51) {
            }
            else if (cmd == 0x71) {}
            else if (cmd == 0x45) {
            }
            bcc = 0;
            cmdList.forEach((num) {
              bcc ^= num;
            });
            cmdList.add(bcc);
            f.write(cmdList, withoutResponse: false);
            debugPrint('CMD = ' + cmdList.toString());
          }
        });
      }
    });
  }
  String dumpHexToString(List<int> data) {
    StringBuffer sb = StringBuffer();
    data.forEach((f) {
      sb.write(f.toRadixString(16).padLeft(2, '0'));
      sb.write(" ");
    });
    return sb.toString();
  }

  String conertHexDecimal(String str1) {
    final fullString = str1;
    int number = 0;
    for (int i = 0; i <= fullString.length - 8; i += 8) {
      final hex = fullString.substring(i, i + 8);

      number = int.parse(hex, radix: 16);
      print(number);
    }
    return number.toString();
  }
  _senddata(String? cmd,List<int> buf, int lng) async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == WOO_UART_SERVICE) {
        List<BluetoothCharacteristic> blueChar = service.characteristics;
        blueChar.forEach((f) {
          if (f.uuid.toString().compareTo(WOO_UART_READ_CHARACTERISTIC) == 0) {
            f.write(buf, withoutResponse: true);
            debugPrint('CMD = ' + dumpHexToString(buf));
          }
        });
      }
    });
  }
  void showAlertDialog(String msg1, String msg2) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg1),
          content: Text(msg2),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }

}
