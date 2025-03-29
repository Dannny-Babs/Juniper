import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatMessageTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(this);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(this);
    } else {
      return DateFormat('MMM d').format(this);
    }
  }
}
