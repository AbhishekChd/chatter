import 'package:chatter/app.dart';
import 'package:chatter/screens/screens.dart';
import 'package:chatter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ProfileScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(tag: "user-profile-image", child: Avatar.large(url: context.currentUserImage)),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                context.currentUser?.name ?? "[no name]",
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: _SignOutButton(),
            )
          ],
        ),
      ),
    );
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton({Key? key}) : super(key: key);

  @override
  State<_SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;

  Future<void> _signOut() async {
    setState(() {
      _loading = true;
    });

    try {
      await StreamChatCore.of(context).client.disconnectUser();
      Navigator.of(context).push(SelectUserScreen.route);
    } on Exception catch (e, st) {
      logger.e('Could not sign out', e, st);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : OutlinedButton(
            onPressed: _signOut,
            child: const Text("Sign Out"),
          );
  }
}
