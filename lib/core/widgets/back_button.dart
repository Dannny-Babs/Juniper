import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;

  const PlatformBackButton({
    Key? key,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            child: Icon(
              CupertinoIcons.back,
              color: color ?? CupertinoColors.systemGrey,
              size: 28,
            ),
          )
        : IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: color ?? Theme.of(context).iconTheme.color,
            ),
            onPressed: onPressed,
          );
  }
}