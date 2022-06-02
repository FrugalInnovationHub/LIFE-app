//material UI, components & custom theme - standard for every file
import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:passage_flutter/theme/components/outlined_button.dart';
import '../filter_components/background_collecting_task.dart';

//for bluetooth connection
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

//for log statements
import 'dart:developer';

//for using platform exception
import 'package:flutter/services.dart';

import 'package:scoped_model/scoped_model.dart';
import '../filter_components/background_collected_page.dart';

import 'package:passage_flutter/theme/app_theme.dart';

class FiltersHome extends StatefulWidget {
  const FiltersHome({Key? key}) : super(key: key);

  @override
  State<FiltersHome> createState() => _FiltersHomeState();
}

class _FiltersHomeState extends State<FiltersHome> {
// Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  // Get the instance of the Bluetooth
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  BluetoothConnection? connection;

  bool isDisconnecting = false;
  bool _connecting = false;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection!.isConnected;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;

  //used for background data collection
  BackgroundCollectingTask? _collectingTask;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    // If the bluetooth of the device is not enabled,
    // then request permission to turn on bluetooth
    // as the app starts up
    enableBluetooth();

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection!
          .dispose(); //isConnected being true means connection cannot be null
      connection = null;
    }

    super.dispose();
  }

  // Request Bluetooth permission from the user
  Future<bool> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // For retrieving and storing the paired devices
  // in a list.
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      log("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  //returns list of devices to populate dropdown widget
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      for (var device in _devicesList) {
        items.add(DropdownMenuItem(
          child: device.name == null
              ? const Text('no device name')
              : Text(device.name!),
          value: device,
        ));
      }
    }
    return items;
  }

// Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      log('No device selected');
      setState(() {
        _isButtonUnavailable = false;
      });
    } else {
      //start background collecting task here - device can never be null
      await _startBackgroundTask(context, _device!);
      log('test filter filter');
    }
  }

  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
    });

    await _collectingTask!.cancel();
    log('Device disconnected');

    setState(() {
      _connected = false;
      _isButtonUnavailable = false;
    });
  }

  //this is called automatically when the user connects to bluetooth
  Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    setState(() {
      _connecting = true;
    });
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server, context);
      await _collectingTask!.start();
    } catch (ex) {
      _collectingTask?.cancel();
      log('task failed to start');
    } finally {
      setState(() {
        //no matter what, turn off connecting animation @ the end.
        //also make button available
        _connecting = false;
        _isButtonUnavailable = false;
      });

      if (_collectingTask != null) {
        setState(() {
          _connected = true;
        });
      } else {
        log('failed');
        setState(() {
          _connected = false;
        });
      }
    }
  }

  //HERE STARTS THE UI CODE

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text('Filter',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20)),
                    const SizedBox(height: 4),
                    const Text('Hands on experimentation'),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      width: 290,
                      child: Text('Guides',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)),
                    ),
                    const SizedBox(height: 25),
                    outlinedButton(
                      context,
                      text: 'First Time',
                      path: '/',
                      height: 105,
                    ),
                    const SizedBox(height: 20),
                    outlinedButton(
                      context,
                      text: 'Refilling/Maintanence',
                      path: '/',
                      height: 105,
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const AppColors().shadowColor,
                              offset: const Offset(6, 6),
                              blurRadius: 12,
                              spreadRadius: 3,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        width: 600,
                        height: 110,
                        child: TextButton(
                            onPressed:
                                (_connected && _collectingTask?.samples != null)
                                    ? () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ScopedModel<
                                                  BackgroundCollectingTask>(
                                                model: _collectingTask!,
                                                child:
                                                    const BackgroundCollectedPage(),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    : null,
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const AppColors().buttonBlue),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ))),
                            child: const Center(
                                child: Text(
                              'Run Filter/ Open data Page',
                              style: TextStyle(color: Colors.white),
                            )))),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 600,
                      height: 230,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const AppColors().lightBlue,
                                width: 3,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Column(children: [
                              const Text('Connect Filter',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20)),
                              const SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Device Status'),
                                    Text(
                                        _connected
                                            ? 'Connected'
                                            : 'Disconnected',
                                        style: _connected
                                            ? const TextStyle(
                                                color: Colors.green)
                                            : const TextStyle(
                                                color: Colors.red)),
                                  ]),
                              const SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Selected Device'),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const AppColors().lightBlue,
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DropdownButton(
                                        icon: Icon(
                                          Icons.expand_more,
                                          color: const AppColors().buttonBlue,
                                        ),
                                        underline: const SizedBox(),
                                        elevation: 0,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black),
                                        items: _getDeviceItems(),
                                        onChanged: (value) => setState(() =>
                                            _device =
                                                value as BluetoothDevice?),
                                        value: _devicesList.isNotEmpty
                                            ? _device
                                            : null,
                                      ),
                                    ),
                                  ]),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('*Teacher supervision advised'),
                                  (_connecting
                                      ? FittedBox(
                                          child: Container(
                                              margin:
                                                  const EdgeInsets.all(16.0),
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          AppTheme.colors
                                                              .darkBlue))))
                                      : const SizedBox(
                                          height: 16,
                                          width: 16,
                                        )),
                                  Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                const AppColors().shadowColor,
                                            offset: const Offset(6, 6),
                                            blurRadius: 12,
                                            spreadRadius: 3,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      width: 100,
                                      height: 40,
                                      child: TextButton(
                                        onPressed: _isButtonUnavailable
                                            ? null
                                            : _connected
                                                ? _disconnect
                                                : _connect,
                                        child: Text(
                                          _connected ? 'Disconnect' : 'Connect',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const AppColors()
                                                        .buttonBlue),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ))),
                                      )),
                                ],
                              )
                            ]),
                          )),
                    ),
                  ],
                )
              ],
            )));
  }
}




//open bluetooth settings
// ElevatedButton(
//                         onPressed: () {
//                           FlutterBluetoothSerial.instance.openSettings();
//                         },
//                         child: const Text('Bluetooth settings'),
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 AppTheme.colors.buttonBlue)),
//                       ),



