import 'package:chatter/helpers.dart';
import 'package:chatter/models/models.dart';
import 'package:chatter/theme.dart';
import 'package:chatter/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatelessWidget {
  static Route routeWithChannel(Channel channel) => MaterialPageRoute(
        builder: (context) => StreamChannel(child: const ChatScreen(), channel: channel),
      );

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        // title: _AppBarTitle(
        //   messageData: messageData,
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(icon: CupertinoIcons.back, onTap: () => Navigator.of(context).pop())),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(child: IconBorder(icon: CupertinoIcons.video_camera_solid, onTap: () {})),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: IconBorder(icon: CupertinoIcons.phone_solid, onTap: () {})),
          )
        ],
      ),
      body: Column(
        children: const [Expanded(child: _DemoMessageList()), _MessageBottomActionBar()],
      ),
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _MessagesDayGroup(label: "YESTERDAY"),
        Column(
          children: const [
            _MessageTile(
              message: 'Hi, Lucy! How\'s your day going?',
              messageDate: '12:01 PM',
            ),
            _MessageOwnTile(
              message: 'You know how it goes...',
              messageDate: '12:02 PM',
            ),
            _MessageTile(
              message: 'Do you want Starbucks?',
              messageDate: '12:02 PM',
            ),
            _MessageOwnTile(
              message: 'Would be awesome!',
              messageDate: '12:03 PM',
            ),
            _MessageTile(
              message: 'Coming up!',
              messageDate: '12:03 PM',
            ),
            _MessageOwnTile(
              message: 'YAY!!!',
              messageDate: '12:03 PM',
            ),
          ],
        )
      ],
    );
  }
}

class _MessagesDayGroup extends StatelessWidget {
  const _MessagesDayGroup({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Text(
                label,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textFaded),
              ),
            )),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(
          url: Helpers.randomPictureUrl(),
          radius: 22,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageData.senderName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Online now",
                style: TextStyle(fontSize: 12, color: Colors.green),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.message, required this.messageDate}) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    topRight: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(message),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textFaded,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({Key? key, required this.message, required this.messageDate}) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textFaded,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageBottomActionBar extends StatelessWidget {
  const _MessageBottomActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(border: Border(right: BorderSide(color: Theme.of(context).dividerColor))),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(CupertinoIcons.camera_fill),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(hintText: "Type something...", border: InputBorder.none),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ActionButton(color: AppColors.accent, icon: Icons.send_rounded, size: 42, onPressed: () {}),
          )
        ],
      ),
    );
  }
}
