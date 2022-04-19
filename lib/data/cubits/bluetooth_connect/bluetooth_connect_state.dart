part of 'bluetooth_connect_cubit.dart';

@immutable
abstract class BluetoothConnectState {}

class BluetoothConnectInitial extends BluetoothConnectState {}

class BluetoothConnectConnectingAllowed extends BluetoothConnectState {}
class BluetoothConnectConnectingNotAllowed extends BluetoothConnectState {}

class BluetoothConnectConnectingStarted extends BluetoothConnectState {}
class BluetoothConnectConnectingFailed extends BluetoothConnectState {}
class BluetoothConnectConnectingSuccessful extends BluetoothConnectState {
  final BluetoothConnection bluetoothConnection;

  BluetoothConnectConnectingSuccessful(this.bluetoothConnection);
}
