import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'events.dart';

class EventBuilder<T extends Event<Y>, Y> extends GetView<T> {
  const EventBuilder({
    super.key,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
    this.initialData,
  });

  final Widget Function(BuildContext context, Y? data) builder;
  final WidgetBuilder? errorBuilder;
  final WidgetBuilder? loadingBuilder;
  final dynamic initialData;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => builder(
        context,
        controller.observable.value,
      ),
    );
  }
}
