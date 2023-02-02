import 'package:chatter/app.dart';
import 'package:chatter/theme.dart';
import 'package:flutter/material.dart';
import 'package:chatter/screens/screens.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  final client = StreamChatClient(streamKey);
  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      title: "Chatter",
      home: const SelectUserScreen(),
      builder: (context, child) {
        return StreamChatCore(client: client, child: child!);
      },
    );
  }
}
