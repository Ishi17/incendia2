import 'dart:html' as html;

typedef ExitIntentCallback = void Function();

class ExitIntentSubscription {
  ExitIntentSubscription(this._onDispose);

  final ExitIntentCallback? _onDispose;

  void dispose() {
    _onDispose?.call();
  }
}

ExitIntentSubscription registerExitIntentListener(ExitIntentCallback callback) {
  bool hasTriggered = false;
  html.EventListener? mouseListener;
  html.EventListener? visibilityListener;

  void removeListeners() {
    if (mouseListener != null) {
      html.document.removeEventListener('mouseout', mouseListener);
      mouseListener = null;
    }
    if (visibilityListener != null) {
      html.document.removeEventListener('visibilitychange', visibilityListener);
      visibilityListener = null;
    }
  }

  void maybeTrigger() {
    if (hasTriggered) return;
    hasTriggered = true;
    removeListeners();
    callback();
  }

  mouseListener = (event) {
    if (event is html.MouseEvent) {
      final related = event.relatedTarget;
      if (related == null && event.client.y <= 0) {
        maybeTrigger();
      }
    }
  };

  visibilityListener = (event) {
    if (html.document.visibilityState == 'hidden') {
      maybeTrigger();
    }
  };

  html.document.addEventListener('mouseout', mouseListener);
  html.document.addEventListener('visibilitychange', visibilityListener);

  return ExitIntentSubscription(removeListeners);
}
