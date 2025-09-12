// lib/core/utils/web_utils.dart
// import للويب فقط
import 'dart:html' as html;

void setupBeforeUnload() {
  html.window.addEventListener('beforeunload', (event) {
    html.window.location.href = '/';
  });
}
