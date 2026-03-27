import 'package:chat/core/extensions/int_extension.dart';
import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {

  String formattedTime() => DateFormat("h:m a").add_jm().format(this);
  String getGroupDate(){
    final now = DateTime.now(); // Current date
    final today = DateTime(now.year, now.month, now.day); // Today date
    final yesterday = today.subtract(1.days()); // Yesterday date
    final msgDate = DateTime(year, month, day); // Message date from the message data(created_at)

    if(msgDate == today) return "Today";
    if(msgDate == yesterday) return "Yesterday";

    return "${_getMonth(msgDate.month)} ${msgDate.day} ${msgDate.year}";
  }

  String _getMonth(int month){
    return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][month - 1];
  }
}