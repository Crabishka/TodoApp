import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modelview/app_provider.dart';

class ListStatusRow extends StatelessWidget {
  const ListStatusRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        Text(
          "Выполнено - ${Provider.of<AppProvider>(context, listen: false).getNumberOfFinishedTask()}",
          style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.tertiary, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false)
                  .changeShowedStatus();
            },
            icon: Icon(
              Provider.of<AppProvider>(context).isFinishedShowed
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: theme.colorScheme.secondary,
            ))
      ],
    );
  }
}