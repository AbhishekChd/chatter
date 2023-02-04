import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../theme.dart';

/// Widget for showing an unread indicator
class UnreadMessagesIndicator extends StatelessWidget {
  /// Constructor for creating an [UnreadMessagesIndicator]
  const UnreadMessagesIndicator({
    Key? key,
    required this.channel,
  }) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: BetterStreamBuilder<int>(
        stream: channel.state!.unreadCountStream,
        initialData: channel.state!.unreadCount,
        builder: (context, data) {
          if (data == 0) {
            return const SizedBox.shrink();
          }
          return Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
            child: Center(
              child: Text(
                '${data > 99 ? '99+' : data}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
