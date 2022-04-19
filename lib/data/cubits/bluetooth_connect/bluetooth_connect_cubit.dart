import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ev3rt_bluetooth_console_app/data/cubits/bluetooth_address_input/bluetooth_address_input_cubit.dart';
import 'package:ev3rt_bluetooth_console_app/data/repositories/bluetooth_repository.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bluetooth_connect_state.dart';

class BluetoothConnectCubit extends Cubit<BluetoothConnectState> {
  final BluetoothAddressInputCubit _bluetoothAddressInputCubit;
  StreamSubscription? _inputStreamSubscription;
  String _address = "";
  final BluetoothRepository _bluetoothRepository = BluetoothRepository();
  BluetoothConnection? _bluetoothConnection;

  BluetoothConnectCubit(this._bluetoothAddressInputCubit) : super(BluetoothConnectInitial()) {
    _inputStreamSubscription = _bluetoothAddressInputCubit.stream.listen((inputState) {
      if(inputState is BluetoothAddressInputTextChanged) {
        _address = inputState.text;
        if(_bluetoothRepository.isAddressOk(_address)) {
          emit(BluetoothConnectConnectingAllowed());
        }else {
          emit(BluetoothConnectConnectingNotAllowed());
        }
      }
    });
  }

  void connect() async {
    emit(BluetoothConnectConnectingStarted());
    final BluetoothConnection? connection = await _bluetoothRepository.connect(_address);
    if(connection == null) {
      emit(BluetoothConnectConnectingFailed());
      emit(BluetoothConnectInitial());
      emit(BluetoothConnectConnectingAllowed());
      return;
    }
    _saveAddress(_address);
    _bluetoothConnection = connection;
    emit(BluetoothConnectConnectingSuccessful(_bluetoothConnection!));
  }

  void _saveAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('bluetooth_address', address);
  }

  @override
  Future<void> close() {
    _inputStreamSubscription!.cancel();
    return super.close();
  }
}
