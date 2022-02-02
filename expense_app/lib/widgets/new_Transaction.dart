
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:hive/hive.dart';
class  newTransaction extends StatefulWidget {
 // (newTransaction { Key? key }) : super(key: key);
 final Function addtx;
 newTransaction(this.addtx);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  final TextEditingController _itemName = TextEditingController();

  final TextEditingController _ammount= TextEditingController();


    // void addTransaction(Transaction t){
  DateTime? _selectedDate;
    
  @override
  Widget build(BuildContext context) {
    
                 void _presentDatePicker(){
     showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime.now())
     .then((value) {
       if (value==null){
         return;
       }
       setState(() {
       _selectedDate=value;  
       });
       
     });
     
     
    } 
  void _submitData(){
 
    try{
    final _id=DateTime.now().toString();
    final enteredTitle = _itemName.text;
    final enteredAmmount  = double.parse(_ammount.text);
    if(enteredTitle.isEmpty || enteredAmmount<=0 ||_selectedDate==null)
    {return;}

              //itemBox.add(_itemName.text);
              //itemBox.add(_ammount.text);
              //final newTransaction = Transaction(ammount: double.parse(_ammount.text),title: _itemName.toString(),date: DateTime.now());
              //addTransaction(newTransaction);
              
              widget.addtx(_id.toString(),_itemName.text,double.parse(_ammount.text),_selectedDate);
                  Navigator.of(context).pop();}on FormatException
             
      catch(e){
              const snackbar=SnackBar(content: Text('Please enter valid data'),);
               ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }}
           
  return
   Card(elevation: 5,child:Container(
         padding: const EdgeInsets.all(10),
         child:Column(
           crossAxisAlignment: CrossAxisAlignment.end,children: [
         TextField(decoration: const InputDecoration(labelText: 'Enter Item'),controller: _itemName,
         onSubmitted: (_) => _submitData() ,),
         TextField(decoration: const InputDecoration(labelText: 'Amount'),controller: _ammount,
         keyboardType: TextInputType.number,
         onSubmitted: (_) => _submitData()
      
         ,),
         Row(children: [
          Expanded(child: Text(_selectedDate== null ?"No date choosen":'Picked Date ${DateFormat.yMd().format(_selectedDate!)}',)),
           FlatButton(textColor: Theme.of(context).primaryColor, onPressed: _presentDatePicker, child: Text( "Choose date",style: TextStyle(fontWeight: FontWeight.bold),))
         ],),
         // ignore: deprecated_member_use
      
      RaisedButton(color: Theme.of(context).primaryColor, onPressed: _submitData, child: const Text('Add Expense'),textColor: Colors.white,)
       ],))

    );
  }
}