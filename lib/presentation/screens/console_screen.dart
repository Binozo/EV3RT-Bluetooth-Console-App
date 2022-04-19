import 'package:ev3rt_bluetooth_console_app/data/cubits/bluetooth_event/bluetooth_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsoleScreen extends StatefulWidget {
  const ConsoleScreen({Key? key}) : super(key: key);

  @override
  State<ConsoleScreen> createState() => _ConsoleScreenState();
}

class _ConsoleScreenState extends State<ConsoleScreen> {

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Console')),
      body: BlocConsumer<BluetoothEventCubit, BluetoothEventState>(
        listener: (context, state) {
          if(state is BluetoothEventMessage) {
            if(scrollController.hasClients) {
              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.ease);
            }

          }
        },
        builder: (context, state) {
      if (state is BluetoothEventMessage) {
        return ListView.builder(
            itemCount: state.messages.length,
            controller: scrollController,
            itemBuilder: (context, i) {
              return Text(state.messages[i]);
            });
      }else if(state is BluetoothEventInitial) {
        return const Center(child: Text("No messages yet"),);
      }else if(state is BluetoothEventJSON) {
        String text = "";
        for(var key in state.json.keys) {
          text += "$key: ${state.json[key]} ";
        }
        return Center(child: Text(text));
      }
      return Text(state.toString());
        },
      ),
    );
  }
}
