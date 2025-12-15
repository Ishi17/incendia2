import 'close_guard_types.dart';
import 'close_guard_stub.dart'
    if (dart.library.html) 'close_guard_web.dart';

void registerBeforeUnloadGuard({
  required CloseAttemptCallback onAttempt,
  required String message,
}) =>
    registerBeforeUnloadGuardImpl(onAttempt: onAttempt, message: message);

void unregisterBeforeUnloadGuard() => unregisterBeforeUnloadGuardImpl();
