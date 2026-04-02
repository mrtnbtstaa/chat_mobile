import 'package:chat/core/extensions/int_extension.dart';
import 'package:intl/intl.dart';
extension DatetimeExtension on DateTime {

  String formatRelativeTime(){

    final nowUTC = DateTime.now().toUtc();

    final dbDateUTC = toUtc();

    final difference = nowUTC.difference(dbDateUTC);

    if(difference.inSeconds < 60){
      return "Just now";
    }else if(difference.inMinutes < 60){
      return "${difference.inMinutes}m ago";
    }else if(difference.inHours < 24){
      return "${difference.inHours}h ago";
    }else if(difference.inDays < 7){
      return "${difference.inDays}d ago";
    }else if(difference.inDays < 30){
      final weeks = (difference.inDays / 7).floor();
      return "${weeks}wk ago";
    }else{
      if(dbDateUTC.year != nowUTC.year){
        return DateFormat("MMM d, y").format(dbDateUTC); // Oct 12, 2025
      }else{
        return DateFormat("MMM d").format(dbDateUTC); // March 12
      }
    }
  }

  String formattedTime() => DateFormat("h:m a").format(this);
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