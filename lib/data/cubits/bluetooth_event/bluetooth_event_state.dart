part of 'bluetooth_event_cubit.dart';

abstract class BluetoothEventState extends Equatable {
  const BluetoothEventState();
}

class BluetoothEventInitial extends BluetoothEventState {
  @override
  List<Object> get props => [];
}

class BluetoothEventDisconnected extends BluetoothEventState {
  @override
  List<Object> get props => [];
}

class BluetoothEventMessage extends BluetoothEventState {
  final List<String> messages;

  const BluetoothEventMessage(this.messages);

  @override
  List<Object> get props => [messages.hashCode];
}

class BluetoothEventJSON extends BluetoothEventState {
  final Map<String, String> json;

  const BluetoothEventJSON(this.json);

  @override
  List<Object> get props => [json.hashCode];
}
