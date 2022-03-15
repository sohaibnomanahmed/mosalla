extension DateOnlyCompare on DateTime {
  bool isAfterTime(DateTime other) {
    if (hour > other.hour){
      return true;
    }
    if (hour == other.hour && minute > other.minute){
      return true;
    }
    if (hour == other.hour && minute == other.minute && second > other.second){
      return true;
    }
    return false;
  }

  bool isBeforeTime(DateTime other) {
    if (hour > other.hour){
      return false;
    }
    if (hour == other.hour && minute > other.minute){
      return false;
    }
    if (hour == other.hour && minute == other.minute && second > other.second){
      return false;
    }
    return true;
  }
}