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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SeparatedFlex(
        mainAxisSize: MainAxisSize.min,
        separator: const SizedBox(height: 16),
        children: [
          SeparatedFlex(
            separator: const SizedBox(height: 4),
            children: [
              if (title != null)
                DefaultTextStyle(
                  style: context.theme.textTheme.titleMedium!.copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                  child: title!,
                ),
              if (content != null)
                DefaultTextStyle(
                  style: context.theme.textTheme.bodySmall!.copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                  child: content!,
                ),
            ],
          ),
          if (actions.isNotEmpty)
            SeparatedFlex(
              axis: Axis.horizontal,
              separator: const Spacer(),
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: actions,
            ),
        ],
      ),
    );
  }
}
