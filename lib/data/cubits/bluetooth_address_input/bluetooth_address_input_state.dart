part of 'bluetooth_address_input_cubit.dart';

abstract class BluetoothAddressInputState extends Equatable {
  const BluetoothAddressInputState();
}

class BluetoothAddressInputInitial extends BluetoothAddressInputState {
  @override
  List<Object> get props => [];
}

class BluetoothAddressInputTextChanged extends BluetoothAddressInputState {
  final String text;

  BluetoothAddressInputTextChanged(this.text);

  @override
  List<Object> get props => [text];
}
