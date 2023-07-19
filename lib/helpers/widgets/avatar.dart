
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.url,
    required this.radius,
    this.onTap,
  }) : super(key: key);

  const Avatar.small({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 20,
        super(key: key);

  const Avatar.medium({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 26,
        super(key: key);

  const Avatar.large({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 60,
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
        backgroundImage: NetworkImage(url!),
        backgroundColor: Theme.of(context).cardColor,
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundImage:const AssetImage('assets/images/user.png'),
        backgroundColor: Theme.of(context).cardColor,

        /*
        backgroundColor: Theme.of(context).cardColor,
        child: Center(
          child: Text(
            '?',
            style: TextStyle(fontSize: radius),
          ),
        ),
        */
      );
    }
  }
}





