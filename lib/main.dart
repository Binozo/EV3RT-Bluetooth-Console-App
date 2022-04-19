import 'package:ev3rt_bluetooth_console_app/constants/app_routes.dart';
import 'package:ev3rt_bluetooth_console_app/data/cubits/bluetooth_address_input/bluetooth_address_input_cubit.dart';
import 'package:ev3rt_bluetooth_console_app/data/cubits/bluetooth_connect/bluetooth_connect_cubit.dart';
import 'package:ev3rt_bluetooth_console_app/presentation/resources/color_manager.dart';
import 'package:ev3rt_bluetooth_console_app/presentation/resources/theme_manager.dart';
import 'package:ev3rt_bluetooth_console_app/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/cubits/bluetooth_event/bluetooth_event_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(EV3RTConsole());
}

class EV3RTConsole extends StatelessWidget {
  final BluetoothAddressInputCubit _bluetoothAddressInputCubit = BluetoothAddressInputCubit();
  BluetoothConnectCubit? _bluetoothConnectCubit;
  BluetoothEventCubit? _bluetoothEventCubit;
  EV3RTConsole({Key? key}) : super(key: key) {
    _bluetoothConnectCubit = BluetoothConnectCubit(_bluetoothAddressInputCubit);
    _bluetoothEventCubit = BluetoothEventCubit(_bluetoothConnectCubit!);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _bluetoothAddressInputCubit),
        BlocProvider.value(value: _bluetoothConnectCubit!),
        BlocProvider.value(value: _bluetoothEventCubit!),
      ],
      child: MaterialApp(
        title: "EV3RT Console",
        theme: getTheme(),
        themeMode: ThemeMode.dark,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
