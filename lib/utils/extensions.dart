
import 'package:intl/intl.dart';

extension StringObj on String {
  DateTime get dateTime {
    return DateTime.parse(this);
  }

 
}

extension DateTimeObjec on DateTime {
  String get weekdayString{

     final format = DateFormat.E('pt_BR');
  return format.format(this);
  }
  String get dateFormata {
    final format = DateFormat("dd/MM/yyyy");
  
    return format.format(this);
  }

  String get timeHourMinute {
    final format = DateFormat("HH:mm");
    return format.format(this);
  }


  String get monthToStringYearNumber {

     var formatter = DateFormat('MMMM', 'pt_BR');
    String month = formatter.format(this);
    return "$month-$year".toUpperCase();

  }

  String get dayString {
   
    return day.toString().padLeft(2,'0');
  }
  

  textDeposit(){

     final format = DateFormat("dd/MM/yyyy");
    final now = DateTime.now();
    if( difference(now).inDays < 0){
      return "Boleto Expirado";
    }else{
      return "Vencimento ${format.format(this)}";
    }
  }
   bool get isExpired{
    final now = DateTime.now();
    return difference(now).inDays < 0;
   }
  
} 

