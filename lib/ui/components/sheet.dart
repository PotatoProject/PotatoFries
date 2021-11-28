import 'package:flutter/material.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/ui/components/separated_flex.dart';

class DialogSheet extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

  const DialogSheet({
    this.title,
    this.content,
    this.actions = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: context.mediaQuery.viewPadding.bottom + 8,
      ),
      child: SeparatedFlex(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeparatedFlex(
            children: [
              if (title != null)
                DefaultTextStyle(
                  style: context.friesTheme.textTheme.titleMedium!.copyWith(
                    color: context.friesTheme.colorScheme.onSurface,
                  ),
                  child: title!,
                ),
              if (content != null)
                DefaultTextStyle(
                  style: context.friesTheme.textTheme.bodySmall!.copyWith(
                    color: context.friesTheme.colorScheme.onSurface,
                  ),
                  child: content!,
                ),
            ],
            separator: const SizedBox(height: 4),
          ),
          if (actions.isNotEmpty)
            SeparatedFlex(
              axis: Axis.horizontal,
              children: actions,
              separator: const Spacer(),
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
            ),
        ],
        separator: const SizedBox(height: 16),
      ),
    );
  }
}
