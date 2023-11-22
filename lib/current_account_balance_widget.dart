import 'package:event_bus_test/event_builder.dart';
import 'package:event_bus_test/events.dart';
import 'package:flutter/widgets.dart';

class CurrentAccountBalanceWidget extends StatelessWidget {
  const CurrentAccountBalanceWidget({
    super.key,
    this.textStyle,
  });

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return EventBuilder<CurrentAccountBalanceEvent, double>(
      initialData: 0,
      builder: (context, data) {
        return Text(
          '$data',
          style: textStyle,
        );
      },
    );
  }
}
