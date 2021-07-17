import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

class TitleBar extends StatelessWidget {
  final bool bigTitle;
  final String title;
  final Widget leading;
  final Widget trailing;

  const TitleBar({
    Key key,
    @required this.title,
    this.leading,
    this.trailing,
    this.bigTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          leading ?? const SizedBox(),
          Expanded(
            child: ShowUpAnimation(
              animationDuration: const Duration(
                milliseconds: 1500,
              ),
              curve: Curves.easeOutExpo,
              direction: Direction.vertical,
              offset: 0.5,
              child: AutoSizeText(
                title,
                style: TextStyle(fontSize: bigTitle ? 56 : 18),
                minFontSize: bigTitle ? 40 : 24,
                maxLines: 1,
              ),
            ),
          ),
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}
