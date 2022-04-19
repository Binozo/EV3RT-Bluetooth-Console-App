import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothRepository {
  bool isAddressOk(String address) {
    return address.isNotEmpty && address.length == 17 && address.contains(":");
  }

  Future<BluetoothConnection?> connect(String address) async {
    try {
      BluetoothConnection connection = await BluetoothConnection.toAddress(address);
      return connection;
    }catch(e) {
      print(e);
      return null;
    }
  }
}