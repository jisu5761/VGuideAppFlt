import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sguideappflt/main.dart';
import 'package:sguideappflt/rfsection.dart';
import 'package:sguideappflt/soundsection.dart';
import 'package:sguideappflt/statussection.dart';
import 'package:sguideappflt/updatesection.dart';
import 'package:provider/provider.dart';
import 'package:sguideappflt/blueprovider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'constants.dart';

class TabSection extends StatefulWidget {
  const TabSection({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;
  final BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  late BlueProvider _blueProvider;

  late String _scanUuid, _writecharacter;
  Stream<List<int>>? stream;
  bool _datacomming = false;

  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
  }

  @override
  void dispose() {
    disconnectFromDevice();
    super.dispose();
  }

  _Pop() {
    Navigator.of(context).pop(true);
  }

  connectToDevice() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    // new Timer(const Duration(seconds: 15), () {
    //   if (!isReady) {
    //     disconnectFromDevice();
    //     _Pop();
    //   }
    // });

    await widget.device.connect();
    final mtu = await widget.device.mtu.first;
    await widget.device.requestMtu(512);
    // while (mtu != 200) {
    //   print("Waiting for requested MTU");
    //   await Future.delayed(Duration(seconds: 1));
    // }
    discoverServices();

  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _Pop();
      return;
    }
    widget.device.disconnect();
  }

  discoverServices() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {

      if (uuidsel == 0) {
        _scanUuid = WOO_UART_SERVICE;
        _writecharacter  = WOO_UART_WRITE_CHARACTERISTIC;
      } else {
        _scanUuid = HAN_UART_SERVICE;
        _writecharacter = HAN_UART_WRITE_CHARACTERISTIC;
      }
      print(service.uuid.toString());
      print(_scanUuid);
      if (service.uuid.toString().toUpperCase() == _scanUuid.toUpperCase()) {
        print(service.uuid.toString());
        print(_scanUuid);
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == _writecharacter) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;
            setState(() {
              isReady = true;
            });
          }
        });
      }
    });

    if (!isReady) {
      _Pop();
    }
  }

  Widget _dataParser(List<int> dataFromDevice) {
    if (_datacomming) {
      _datacomming = false;
      return Icon(Icons.bluetooth_connected);
    } else {
      _datacomming = true;
      return Icon(Icons.bluetooth);
    }
  }

  @override
  Widget build(BuildContext context) {
    _blueProvider = Provider.of<BlueProvider>(context, listen: false);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(widget.device.name,style: const TextStyle(fontSize: 16),),
          bottom: TabBar(
            // labelColor: Colors.red,
            // unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: '상태'),
              Tab(text: '무선'),
              Tab(text: '음량'),
              Tab(text: '관리'),
            ],
          ),
          actions: [
            StreamBuilder<List<int>>(
                stream: stream,
                builder:
                    (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                  if (snapshot.hasError)
                    return Icon(Icons.phonelink_erase_rounded);
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.length == 20) {
                      debugPrint('BLEDATA : ' + snapshot.data.toString());
                      WidgetsBinding.instance?.addPostFrameCallback(
                          (timeStamp) =>
                              _blueProvider.setBleinfo(snapshot.data!));
                    }
                    return _dataParser(snapshot.data!);
                  } else
                    return Icon(Icons.bluetooth_disabled);
                }),
          ],
        ),
        body: TabBarView(
          children: [

            StatusSection(device: widget.device),
            RfSection(device: widget.device),
            SoundSection(device: widget.device),
            UpdateSection(device: widget.device),
          ],
        ),
      ),
    );
  }
}

// class Util {
//   static List<int> convertInt2Bytes(value, Endian order, int bytesSize ) {
//     try{
//       final kMaxBytes = 8;
//       var bytes = Uint8List(kMaxBytes)
//         ..buffer.asByteData().setInt64(0, value, order);
//       List<int> intArray;
//       if(order == Endian.big){
//         intArray = bytes.sublist(kMaxBytes-bytesSize, kMaxBytes).toList();
//       }else{
//         intArray = bytes.sublist(0, bytesSize).toList();
//       }
//       return intArray;
//     }catch(e) {
//       print('util convert error: $e');
//     }
//     return null;
//   }
// }
