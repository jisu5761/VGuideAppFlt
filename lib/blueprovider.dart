import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'updatesection.dart';

class BlueProvider extends ChangeNotifier {
  List<int> bleinfo = [
    0,
    0,
    5,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<int> bleetcinfo = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];

  String _soundFilePath = "";
  String _devtime = "2022-01-01 01:00";
  int _devid = 0;
  int _devnumber = 0;
  int _rf235value = 30;
  int _beaconrssicutvalue = 127;
  int _beaconrssivalue= 100;
  String _oldcmd = '0';


  int _nightOffset = 4;
  int _nightStart = 1;
  int _nightEnd = 1;
  int _groupid = 0;
  int _posrssicut = 0;
  int _sigrssicut = 0;
  int _posrssircv = 0;
  int _sigrssircv = 0;
  int _rf235rssircv = 0;
  int _womanmute1 = 0;
  int _womanmute2 = 0;
  int _manmute1 = 0;
  int _manmute2 = 0;
  int _bitsel = 0;
  int _womanvol = 8;
  int _manvol = 8;
  int _birdvol = 8;
  int _cricketvol = 8;
  int _melodyvol = 8;
  int _etcvol = 8;
  int _dingvol = 8;
  String _sexValue = '여자';
  String _birdCricketValue = '새';
  String _crossValue = '교차로';
  String _pillarValue = '일반지주';
  String _setupValue = '미설정';
  String _firstValue = '먼저';

  String _groupNumber = '0';
  String _groupMemberID = '0';
  String _groupMemberCount = '0';

  String get soundFilePath => _soundFilePath;
  int get rf235rssircv => _rf235rssircv;

  int get beaconrssicutvalue => _beaconrssicutvalue;

  int get beaconrssi => _beaconrssivalue;

  String get oldcmd => _oldcmd;

  String get groupNumber => _groupNumber;

  String get groupMemberID => _groupMemberID;

  String get groupMemberCount => _groupMemberCount;

  String get sexValue => _sexValue;

  String get birdCricketValue => _birdCricketValue;

  String get crossValue => _crossValue;

  String get pillarValue => _pillarValue;

  String get setupValue => _setupValue;

  String get firstValue => _firstValue;

  int get possetdata => _posrssicut;

  int get posrcvdata => _posrssircv;

  int get sigsetdata => _sigrssicut;

  int get sigrcvdata => _sigrssircv;

  int get devnumber => _devnumber;

  String get devtime => _devtime;

  int get devid => _devid; //bleinfo[2];

  int get rf235value => _rf235value;

  int get groupid => _groupid; //bleetcinfo[9] * 256 + bleetcinfo[10];
  int get womanmute1 => _womanmute1;

  int get womanmute2 => _womanmute2;

  int get manmute1 => _manmute1;

  int get manmute2 => _manmute2;

  int get bitsel => _bitsel;

  int get womanvol => _womanvol;

  int get manvol => _manvol;

  int get birdvol => _birdvol;

  int get cricketvol => _cricketvol;

  int get dingvol => _dingvol;

  int get melodyvol => _melodyvol;

  int get etcvol => _etcvol;

  int get nightOffset => _nightOffset;

  int get nightStart => _nightStart;

  int get nightEnd => _nightEnd;

  setBleinfo(List<int> data) {
    int i = 0;
    Iterable<int> newIterable = data.map((value) {
      bleinfo[i++] = value;
      return value;
    }).toList();
      debugPrint('cmd = ' + String.fromCharCode(bleinfo[1]));
    switch (String.fromCharCode(bleinfo[1])) {

      case 'E':
                _oldcmd = String.fromCharCode(bleinfo[1]);
                break;

      case 'M':
      _oldcmd = String.fromCharCode(bleinfo[1]);
      break;

      case 'N':
      _oldcmd = String.fromCharCode(bleinfo[1]);
      break;


      case '0':
      case '4':
      case '9':
      case '8':
      case '7':
      case 'R':
      case 'P':
      case 'V':
      case 'v':
      case 'I':
      case 'i':
      case 'g':
      case 'f':
      case 'y':
      case 'Y':
        if(bleinfo[2] > 33) _devid = 0;
        else                _devid = bleinfo[2];

        _groupid = bleinfo[4] * 256 + bleinfo[5];
        _posrssicut = bleinfo[8];
        _posrssircv = bleinfo[9];
        _sigrssicut = bleinfo[10];
        _sigrssircv = bleinfo[11];
        _rf235rssircv = bleinfo[12];
        _bitsel = bleinfo[13];
        if (_bitsel & 0x01 == 0x01) {
          _sexValue = sexList[0];
        } else {
          _sexValue = sexList[1];
        }

        if (_bitsel & 0x02 == 0x02) {
          _birdCricketValue = birdCricketList[0];
        } else {
          _birdCricketValue = birdCricketList[1];
        }

        if (_bitsel & 0x04 == 0x04) {
          _crossValue = crossList[0];
        } else {
          _crossValue = crossList[1];
        }

        if (_bitsel & 0x08 == 0x08) {
          _pillarValue = pillarList[1];
        } else if (_bitsel & 0x10 == 0x10) {
          _pillarValue = pillarList[2];
        } else {
          _pillarValue = pillarList[0];
        }

        if (_bitsel & 0x20 == 0x20) {
          _setupValue = setupList[1];
        } else {
          _setupValue = setupList[0];
        }

        if (_bitsel & 0x40 == 0x40) {
          _firstValue = afterList[0];
        } else {
          _firstValue = afterList[1];
        }

        if(bleinfo[14] > 40)  bleinfo[14] = 40;
        _womanmute1 = bleinfo[14];
        if(bleinfo[15] > 40)  bleinfo[15] = 40;
        _womanmute2 = bleinfo[15];
        if(bleinfo[16] > 40)  bleinfo[16] = 40;
        _manmute1 = bleinfo[16];
        if(bleinfo[17] > 40)  bleinfo[17] = 40;
        _manmute2 = bleinfo[17];
        break;

      case 'e':
        if(bleinfo[2] > 20) bleinfo[2] = 20;
        _womanvol = bleinfo[2];
        if(bleinfo[3] > 20) bleinfo[3] = 20;
        _manvol = bleinfo[3];
        if(bleinfo[4] > 20) bleinfo[4] = 20;
        _birdvol = bleinfo[4];
        if(bleinfo[5] > 20) bleinfo[5] = 20;
        _cricketvol = bleinfo[5];
        if(bleinfo[6] > 20) bleinfo[6] = 20;
        _dingvol = bleinfo[6];
        if(bleinfo[7] > 20) bleinfo[7] = 20;
        _melodyvol = bleinfo[7];
        if(bleinfo[8] > 20) bleinfo[8] = 20;
        _etcvol = bleinfo[8];
        if(bleinfo[9] > 110) bleinfo[9] = 100;
        _rf235value = bleinfo[9];
        _beaconrssicutvalue = bleinfo[10];
        _beaconrssivalue = bleinfo[11];
        break;
      case  't':
        _nightOffset = bleinfo[8];
        _nightStart = bleinfo[10] * 0x100 + bleinfo[9];
        _nightEnd = bleinfo[12] * 0x100 + bleinfo[11];
        _devtime = (bleinfo[13] + 2000).toString() + "-" + bleinfo[14].toString().padLeft(2, '0') + "-" + bleinfo[15].toString().padLeft(2, '0') + " " + bleinfo[16].toString().padLeft(2, '0') + ":" + bleinfo[17].toString().padLeft(2, '0');
        break;

      case  ';':
        _devnumber = bleinfo[2] * 0x1000000 + bleinfo[3]  * 0x10000 + bleinfo[4]  * 0x100 + bleinfo[5];
        break;

      case 'q':
        int gnum = bleinfo[2] * 0x1000000 + bleinfo[3]  * 0x10000 + bleinfo[4]  * 0x100 + bleinfo[5];
        _groupNumber = (gnum).toRadixString(16);
        _groupMemberCount = bleinfo[6].toString();
        _groupMemberID = bleinfo[7].toString();
        break;
    }
    notifyListeners();
  }
  setSoundFilePath(String s)  {
    _soundFilePath = s;
  }
  setDevidset(int value) {
    _devid = value;
    notifyListeners();
  }

  setSexvalue(int value) {
    _sexValue = sexList[value];
    notifyListeners();
  }

  setBirdcrickervalue(int value) {
    _birdCricketValue = birdCricketList[value];
    notifyListeners();
  }

  setCrossvalue(int value) {
    _crossValue = crossList[value];
    notifyListeners();
  }

  setNightoffset(int value) {
    _nightOffset = value;
    notifyListeners();
  }

  setPillarvalue(int value) {
    _pillarValue = pillarList[value];
    notifyListeners();
  }

  setSetupvalue(int value) {
    _setupValue = setupList[value];
    notifyListeners();
  }

  setFirstvalue(int value) {
    _firstValue = afterList[value];
    notifyListeners();
  }

  setWomanvolume(int value) {
    _womanvol = value;
    notifyListeners();
  }
  setRf235value(int value) {
    _rf235value = value * 5;
    notifyListeners();
  }

  setBeaconrssicutvalue(int value) {
    _beaconrssicutvalue = value;
    notifyListeners();
  }

  setManvolume(int value) {
    _manvol = value;
    notifyListeners();
  }

  setBirdvolume(int value) {
    _birdvol = value;
    notifyListeners();
  }

  setCricketvolume(int value) {
    _cricketvol = value;
    notifyListeners();
  }

  setMelodyvolume(int value) {
    _melodyvol = value;
    notifyListeners();
  }

  setDingvolume(int value) {
    _dingvol = value;
    notifyListeners();
  }

  setEtcvolume(int value) {
    _etcvol = value;
    notifyListeners();
  }

  setGroupidset(int value) {
    _groupid = value;
    notifyListeners();
  }

  setWomanmanset(int value) {
    _womanmute1 = value;
    notifyListeners();
  }

  setWomanmute1set(int value) {
    _womanmute1 = value;
    notifyListeners();
  }

  setWomanmute2set(int value) {
    _womanmute2 = value;
    notifyListeners();
  }

  setManmute1set(int value) {
    _manmute1 = value;
    notifyListeners();
  }

  setManmute2set(int value) {
    _manmute2 = value;
    notifyListeners();
  }
  //
  // _senddtabuf(List<int> cmd) async {
  //   List<BluetoothService> services = await widget.device.discoverServices();
  //   services.forEach((service) {
  //     if (service.uuid.toString() == HAN_UART_SERVICE) {
  //       List<BluetoothCharacteristic> blueChar = service.characteristics;
  //       blueChar.forEach((f) {
  //         if (f.uuid.toString().compareTo(HAN_UART_READ_CHARACTERISTIC) == 0) {
  //           f.write(cmd, withoutResponse: true);
  //         }
  //       });
  //     }
  //   });
  // }
  // _sendcommand(int? cmd) async {
  //   List<BluetoothService> services = await widget.device.discoverServices();
  //   services.forEach((service) {
  //     if (service.uuid.toString() == HAN_UART_SERVICE) {
  //       List<BluetoothCharacteristic> blueChar = service.characteristics;
  //       blueChar.forEach((f) {
  //         if (f.uuid.toString().compareTo(HAN_UART_READ_CHARACTERISTIC) == 0) {
  //           // debugPrint("${service.uuid}");
  //           // debugPrint("Characteristice =  ${f.uuid}");
  //           List<int> cmdList = [
  //             0xA2,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0x00,
  //             0xA3
  //           ];
  //           int bcc = 0;
  //           cmdList[1] = cmd!;
  //           if (cmd == 0x51) {
  //             //'Q'
  //             try {
  //
  //               cmdList[2] = (bcc >> 24) & 0xFF;
  //               cmdList[3] = (bcc >> 16) & 0xFF;
  //               cmdList[4] = (bcc >> 8) & 0xFF;
  //               cmdList[5] = bcc & 0xFF;
  //
  //               cmdList[6] = bcc & 0xFF;
  //
  //               cmdList[7] = bcc & 0xFF;
  //             } catch (e) {
  //               debugPrint(e.toString());
  //               return;
  //             }
  //           }
  //           if (cmd == 0x71) {}
  //           bcc = 0;
  //           cmdList.forEach((num) {
  //             bcc ^= num;
  //           });
  //           cmdList.add(bcc);
  //           f.write(cmdList, withoutResponse: true);
  //           debugPrint('CMD = ' + cmdList.toString());
  //         }
  //       });
  //     }
  //   });
  // }
}
