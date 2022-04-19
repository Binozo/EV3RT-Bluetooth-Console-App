import 'package:ev3rt_bluetooth_console_app/data/cubits/bluetooth_address_input/bluetooth_address_input_cubit.dart';
import 'package:ev3rt_bluetooth_console_app/data/cubits/bluetooth_connect/bluetooth_connect_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _bluetoothAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EV3RT Console')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter the Bluetooth Address of your EV3:",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            const Text("(Note: You need an EV3 which runs EV3RT. You can find the BT address above the \"Load App\" button)", textAlign: TextAlign.center,),
            const SizedBox(height: 20.0),
            TextField(
              onChanged: (String text) => context.read<BluetoothAddressInputCubit>().onTextChanged(text),
              controller: _bluetoothAddressController,
              decoration: const InputDecoration(hintText: "00:00:00:00:00:00", hintStyle: TextStyle(color: Colors.white70)),
            ),
            const SizedBox(height: 20.0),
            BlocConsumer<BluetoothConnectCubit, BluetoothConnectState>(
              listener: (context, state) {
                if (state is BluetoothConnectConnectingFailed) {
                  _showFailedConnectionDialog(context);
                }else if(state is BluetoothConnectConnectingSuccessful) {
                  Wakelock.enable();
                  Navigator.of(context).pushReplacementNamed('/console');
                }
              },
              builder: (context, state) {
                if(state is BluetoothConnectConnectingAllowed) {
                  return ElevatedButton(onPressed: () => context.read<BluetoothConnectCubit>().connect(), child: const Text("Connect"));
                }else if(state is BluetoothConnectConnectingNotAllowed || state is BluetoothConnectInitial) {
                  return const ElevatedButton(child: Text("Connect"), onPressed: null);
                }else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _showFailedConnectionDialog(BuildContext context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Connection Failed"),
        content: const Text("Oh no! :( \nPlease check the Bluetooth address and try again.\nYou could try to restart the EV3 and connect again."),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("OK"))
        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final prefs = await SharedPreferences.getInstance();
    final address = prefs.getString('bluetooth_address');
    if(address != null) {
      _bluetoothAddressController.text = address;
      context.read<BluetoothAddressInputCubit>().onTextChanged(address);
    }
  }
}
