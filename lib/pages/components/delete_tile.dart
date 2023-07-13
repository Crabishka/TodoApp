import 'package:flutter/material.dart';

class DeleteTile extends StatelessWidget {
  const DeleteTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).maybePop();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Удалить',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}