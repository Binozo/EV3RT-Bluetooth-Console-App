import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bluetooth_address_input_state.dart';

class BluetoothAddressInputCubit extends Cubit<BluetoothAddressInputState> {
  BluetoothAddressInputCubit() : super(BluetoothAddressInputInitial());

  void onTextChanged(String text) {
    emit(BluetoothAddressInputTextChanged(text));
  }
}
