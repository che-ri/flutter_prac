import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> blueList = List.empty(growable: true);
  ScanResult? connectedDevice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('블루투스'),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: connectedDevice == null
                      ? Row(
                          children: <Widget>[
                            Text(
                              '연결된 디바이스가 없습니다.',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Text('${connectedDevice!.device.name}'),
                            ElevatedButton(
                                onPressed: () {
                                  onTapDisconnectBtn(connectedDevice!);
                                },
                                child: Text('연결 중지'))
                          ],
                        )),
              ListView.builder(
                shrinkWrap: true,
                itemCount: blueList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        onTapCard(index);
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('NAME : ${getDeviceName(blueList[index])}'),
                            Text(
                              'ID : ${getDeviceId(blueList[index])}',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 10),
                            )
                          ],
                        ),
                      ));
                },
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          flutterBlue.startScan(timeout: Duration(seconds: 4));

          var subscription = flutterBlue.scanResults.listen((results) {
            setState(() {
              blueList = results;
            });
          });

          print(blueList);

          flutterBlue.stopScan();
        },
        child: Icon(Icons.bluetooth),
      ),
    );
  }

  void onTapCard(int index) async {
    print('tap! ${blueList[index].device.name}');

    await blueList[index]
        .device
        .connect(timeout: Duration(seconds: 5))
        .then((_) {
      setState(() {
        connectedDevice = blueList[index];
      });
    }).catchError((e) {
      print('연결 실패 : ${e}');
    });

    print(connectedDevice);
  }

  void onTapDisconnectBtn(ScanResult curDevice) async {
    curDevice.device.disconnect();
    setState(() {
      connectedDevice = null;
    });
  }

  String getDeviceName(ScanResult r) {
    String name = '';
    if (r.device.name.isNotEmpty) {
      name = r.device.name;
    } else if (r.advertisementData.localName.isNotEmpty) {
      name = r.advertisementData.localName;
    } else {
      name = 'N/A';
    }

    return name;
  }

  String getDeviceId(ScanResult r) {
    String id = '';
    if (r.device.id.id.isNotEmpty) {
      id = r.device.id.id;
    } else {
      id = 'N/A';
    }

    return id;
  }
}
