import 'package:expense_app/widgets/chat_bar.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/transactionn.dart';
import 'package:intl/intl.dart';
class chart extends StatelessWidget {
  final List<Transactionn> recentTransaction;
  chart(this.recentTransaction);
  List<Map<String,Object>> get groupedTransactionValue{
    return List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index),);
        double totalSum=0.0;
        for(var i=0;i< recentTransaction.length;i++){
          if(recentTransaction[i].date.day==weekDay.day && recentTransaction[i].date.month==weekDay.month
          && recentTransaction[i].date.year==weekDay.year){
           totalSum += recentTransaction[i].ammount;
          }
        }
      
return{'day':DateFormat.E().format(weekDay).substring(0,3),'amount':totalSum};
    }).reversed.toList(); 
    
  }
  double get maxSpend{
    double a=0.0; //there is also a groupedtransactionvalue.fold method to implement this takes the function
  for (var i = 0; i < groupedTransactionValue.length; i++) {

    a += groupedTransactionValue[i]['amount'] as double;
  }
  return a;
  }
  @override
  Widget build(BuildContext context) {
     return  Card(elevation: 8,margin: EdgeInsets.all(20),
     child: Padding(padding: EdgeInsets.all(20),child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: groupedTransactionValue.map((e) {
       return Flexible(fit: FlexFit.tight, child:chatBar(e['day'].toString(), e['amount'] as double,maxSpend==0.0?0.0: (e['amount'] as double)  / maxSpend),);
     }).toList(),)));
  }
}