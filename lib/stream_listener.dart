library single_result_bloc;

import 'dart:async';

import 'package:flutter/widgets.dart';

/// Widget for managing livecycle of Stream [stream], added to widget tree
class StreamListener<T> extends StatefulWidget {
  final Stream<T> stream;

  final Widget child;
  final void Function(T event) onData;
  final Function? onError;
  final Function()? onDone;
  final bool? cancelOnError;

  const StreamListener({
    required this.stream,
    required this.child,
    required this.onData,
    this.onError,
    this.onDone,
    this.cancelOnError,
    Key? key,
  }) : super(key: key);

  @override
  StreamListenerState createState() => StreamListenerState<T>();
}

class StreamListenerState<T> extends State<StreamListener<T>> {
  StreamSubscription<T>? _streamSubs;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant StreamListener<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _streamSubs?.cancel();
    listen();
  }

  @override
  void dispose() {
    _streamSubs?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listen();
  }

  void listen() {
    _streamSubs = widget.stream.listen(
      widget.onData,
      onDone: widget.onDone,
      onError: widget.onError,
      cancelOnError: widget.cancelOnError,
    );
  }
}
