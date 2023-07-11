import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDataText extends StatelessWidget {
  const FormattedDataText({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Text(
      DateFormat('dd-MMM-yyyy').format(date),
      style: theme.textTheme.bodyMedium,
    );
  }
}
