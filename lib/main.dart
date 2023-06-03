// flutter build apk --profile
//Ver2.8  tx235 power > 110 => 50
//Ver2.9  dev id 20->30  오기 수정
//Ver3.1  beacon 설정, 235 rssi 표시

// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sguideappflt/tabsection.dart';
import 'package:sguideappflt/widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';
import 'package:sguideappflt/blueprovider.dart';
import 'constants.dart';

void main() {
  runApp(FlutterBlueApp());
}

class ColorService {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
class FlutterBlueApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '우인 유도기',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorService.createMaterialColor(const Color(0xFF0000FF)),
      ),
      home: StreamBuilder<BleStatus>(
          stream: FlutterBlue.instance.state,
          initialData: BleStatus.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BleStatus.ready) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state!);
          }),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, required this.state}) : super(key: key);

  final BleStatus state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state.toString().substring(15)}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatefulWidget {
  @override
  State<FindDevicesScreen> createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
    void initStatus(){
      super.initState();
    }



  @override
  Widget build(BuildContext context) {
    late String _scanUudi, _writeCharacter;
    return GestureDetector(
      // onHorizontalDragEnd: (DragEndDetails details) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => TabSection(device: flutterBlue)));
      // },
      child: Scaffold(
        appBar: AppBar(
          title: Text('우인 유도기'),
          elevation: 0.0,
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/img.png'),
                  backgroundColor: Colors.white,
                ),
                otherAccountsPictures: [],
                accountName: Text('우인 미디어'),
                accountEmail: Text('음성유도기'),
                decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )),
              ),
              SizedBox(height: 20.0),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_rounded,
                  color: Colors.grey[850],
                ),
                title: Text(
                  '우인 순정품',
                  style: TextStyle(fontSize: 20.0),
                ),
                onTap: () {
                  setState(() {
                    uuidsel = 0;
                  });
                },
                trailing: Icon(
                  (uuidsel == 0) ? Icons.check_circle_rounded : null,
                  color: Colors.grey[850],
                ),
              ),
              SizedBox(height: 20.0),
              ListTile(
                leading: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.grey[850],
                ),
                title: Text(
                  '그외 기타 .. ',
                  style: TextStyle(fontSize: 20.0),
                ),
                onTap: () {
                  setState(() {
                    uuidsel = 1;
                  });
                },
                trailing: Icon(
                  (uuidsel == 1) ? Icons.check_circle_rounded : null,
                  color: Colors.grey[850],
                ),
              ),
            ],
          ),
        ),
        body: HomePage(),
        floatingActionButton: StreamBuilder<bool>(
          stream: FlutterBlue.instance.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data!) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => FlutterBlue.instance.stopScan(),
                backgroundColor: Colors.blueAccent,
              );
            } else {
              String _scanUuid, _writecharacter;

                _scanUuid = WOO_UART_SERVICE;
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () {
                    //FlutterBlue.instance.scanResults
                    // FlutterBlue.instance.resetScanResult();
                    FlutterBlue.instance.startScan(scanMode: ScanMode.balanced,
                        withServices: [Guid(_scanUuid)],
                        timeout: Duration(seconds: 4),);
                  }
              );
            }
          },
        ),
      ),
    );
  }
}



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => FlutterBlue.instance.startScan(
            scanMode: ScanMode.balanced,
            withServices: [Guid(WOO_UART_SERVICE)],
            timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return ChangeNotifierProvider(
                                create: (BuildContext context) =>
                                    BlueProvider(),
                                child: TabSection(device: r.device));
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
