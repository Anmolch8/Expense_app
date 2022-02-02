//import 'package:expense_app/models/Transaction.dart';
import 'package:expense_app/models/transactionn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  final List <Transactionn> transaction;
  final Function deleteTx;
  TransactionList(this.transaction,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(height:500,child:
    transaction.isEmpty? 
    Column(children: [ Text("No Transaction yet",style: Theme.of(context).textTheme.headline6,),
    SizedBox(height: 20,),
    Container( height: 200,child:Image.asset('assets/images/waiting.png')),
    ],
    ):ListView.builder(  //listview.builder() for better performance 
    //for short lists use listview()
      itemBuilder: (ctx,index){
       /* return Card(child:Row(children: <Widget> [Container(margin:const EdgeInsets.symmetric(vertical: 15,
         horizontal: 15
         ),decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor,width: 2)),
         padding: const EdgeInsets.all(10),
      child: Text('Rs${transaction[index].ammount.toStringAsFixed(2)}',style: const TextStyle(
        fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
          Text(transaction[index].title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          Text(DateFormat().format(transaction[index].date),style: const TextStyle(color: Colors.grey),)],)],),);*/
      return Card(elevation: 5,
        margin:const EdgeInsets.symmetric(vertical: 3,horizontal: 4), child:ListTile(leading: CircleAvatar(radius: 30,child:Padding(padding: EdgeInsets.all(8), child: FittedBox(child: Text('RS${transaction[index].ammount}',
      style: Theme.of(context).textTheme.headline6,),),)),
      title: Text(transaction[index].title,style: Theme.of(context).textTheme.headline6,),
      subtitle: Text(DateFormat.yMMMd().format(transaction[index].date)),
       trailing: IconButton(icon: Icon(Icons.delete), color: Colors.red,onPressed: () =>deleteTx(transaction[index].id),), ));
      },
      itemCount: transaction.length,
      
    ));
  }
}