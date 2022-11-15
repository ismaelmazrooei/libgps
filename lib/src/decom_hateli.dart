// created by mobadi
import 'package:flutter/material.dart';

class DecomHotli<T extends ChangeNotifier> extends StatefulWidget {
  final T value;
  final Widget? child;
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  const DecomHotli(
      {Key? key, required this.value, required this.builder, this.child})
      : super(key: key);

  @override
  _DecomHotliState<T> createState() => _DecomHotliState<T>();
}

class _DecomHotliState<T extends ChangeNotifier> extends State<DecomHotli<T>> {
  @override
  void initState() {
    widget.value.addListener(_listener);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DecomHotli<T> oldWidget) {
    if (widget.value != oldWidget.value) {
      oldWidget.value.removeListener(_listener);
      widget.value.addListener(_listener);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.value.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.child != null
        ? widget.child!
        : widget.builder(context, widget.value, widget.child);
  }
}
