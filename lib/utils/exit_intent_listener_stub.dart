typedef ExitIntentCallback = void Function();

class ExitIntentSubscription {
  const ExitIntentSubscription();

  void dispose() {}
}

ExitIntentSubscription registerExitIntentListener(ExitIntentCallback callback) {
  return const ExitIntentSubscription();
}
