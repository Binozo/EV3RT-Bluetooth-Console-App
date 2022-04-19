import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ev3rt_bluetooth_console_app/data/cubits/bluetooth_connect/bluetooth_connect_cubit.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:intl/intl.dart';

part 'bluetooth_event_state.dart';

class BluetoothEventCubit extends Cubit<BluetoothEventState> {
  final BluetoothConnectCubit _bluetoothConnectCubit;
  StreamSubscription? _connectStreamSubscription;
  BluetoothConnection? _bluetoothConnection;

  List<String> _messages = List.empty(growable: true);

  BluetoothEventCubit(this._bluetoothConnectCubit) : super(BluetoothEventInitial()) {
    _connectStreamSubscription = _bluetoothConnectCubit.stream.listen((connectState) {
        if(connectState is BluetoothConnectConnectingSuccessful) {
          _messages = List.empty(growable: true);
          //dispose old connection if it exists
          if(_bluetoothConnection != null) {
            _bluetoothConnection?.dispose();
          }
          _bluetoothConnection = connectState.bluetoothConnection;
          _bluetoothConnection?.input?.listen(startListening)
              .onDone(() {
                emit(BluetoothEventDisconnected());
                _bluetoothConnection?.dispose();
              });
        }
    });
  }

  void startListening(Uint8List event) {
    //default handler
    String msg = utf8.decode(event);
    print("Message: $msg");
    if(msg.contains("connected?")) {
      _bluetoothConnection?.output.add(ascii.encode("yes\r"));
      print("Answered connection status request");
      return;
    }else if(msg.contains("delete_last_line")) {
      _messages = List.from(_messages);
      if(_messages.isNotEmpty) {
        _messages.removeLast();
      }
      emit(BluetoothEventMessage(_messages));
      return;
    }
    //check if message is json data
    try {
      final result = jsonDecode(msg);
      emit(BluetoothEventJSON(Map<String, String>.from(result)));
      return;
    }catch(e) {
      print(e);
      // not json data
      // proceed
    }

    _messages = List.from(_messages);
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm:ss.SSS');
    final time = formatter.format(now);
    _messages.add("[$time] $msg");
    emit(BluetoothEventMessage(_messages));
  }

  @override
  Future<void> close() {
    _connectStreamSubscription?.cancel();
    return super.close();
  }
}
