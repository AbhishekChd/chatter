import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.radius, this.url, this.onTap}) : super(key: key);

  const Avatar.small({Key? key, this.url, this.onTap})
      : radius = 16,
        super(key: key);

  const Avatar.medium({Key? key, this.url, this.onTap})
      : radius = 30,
        super(key: key);

  const Avatar.large({Key? key, this.url, this.onTap})
      : radius = 44,
        super(key: key);

  final double radius;
  final String? url;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _avatar(context),
    );
  }

  Widget _avatar(BuildContext context) {
    if (url != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).backgroundColor,
        backgroundImage: CachedNetworkImageProvider(url!),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).cardColor,
        child: Center(
            child: Text(
          "?",
          style: TextStyle(fontSize: radius),
        )),
      );
    }
  }
}
