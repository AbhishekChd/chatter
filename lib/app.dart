import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as log;

const streamKey = "5zsp735mdt9y";
var logger = log.Logger();

extension StreamChatContext on BuildContext {
  /// Fetches current
  String? get currentUserImage => StreamChatCore.of(this).currentUser?.image;

  /// Fetches current user
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
