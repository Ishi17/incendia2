import 'dart:async';
import 'dart:html' as html;

import 'package:flutter_window_close/flutter_window_close.dart';

import 'close_guard_types.dart';

StreamSubscription<html.Event>? _beforeUnloadSubscription;

void registerBeforeUnloadGuardImpl({
  required CloseAttemptCallback onAttempt,
  required String message,
}) {
  FlutterWindowClose.setWebReturnValue(message);
  _beforeUnloadSubscription?.cancel();
  _beforeUnloadSubscription = html.window.onBeforeUnload.listen((event) {
    onAttempt();
    final beforeUnloadEvent = event as html.BeforeUnloadEvent;
    beforeUnloadEvent.returnValue = message;
    beforeUnloadEvent.preventDefault();
  });
}

void unregisterBeforeUnloadGuardImpl() {
  FlutterWindowClose.setWebReturnValue(null);
  _beforeUnloadSubscription?.cancel();
  _beforeUnloadSubscription = null;
}
