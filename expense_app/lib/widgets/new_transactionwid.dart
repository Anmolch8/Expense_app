
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class transactionWidget extends StatefulWidget {
final Function add;
transactionWidget(this.add);
 
  @override
  State<transactionWidget> createState() => _transactionWidgetState();
}

class _transactionWidgetState extends State<transactionWidget> {
       final TextEditingController _itemName = TextEditingController();
DateTime? _selectedDate;
  final TextEditingController _ammount= TextEditingController();

   void presentDatePicker(){
     showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime.now())
     .then((value) {
       if (value==null){
         return;
       }
       setState(() {
       _selectedDate=value ;  
   
       });
       
     });
     
     
    }
    void _submitData(){
 
    try{
    final enteredTitle = _itemName.text;
    final enteredAmmount  = double.parse(_ammount.text);
    if(enteredTitle.isEmpty || enteredAmmount<=0 ||_selectedDate==null)
    {return;}

              //itemBox.add(_itemName.text);
              //itemBox.add(_ammount.text);
              //final newTransaction = Transaction(ammount: double.parse(_ammount.text),title: _itemName.toString(),date: DateTime.now());
              //addTransaction(newTransaction);
              
              widget.add(_itemName.text,double.parse(_ammount.text),_selectedDate);
                  Navigator.of(context).pop();}on FormatException
             
      catch(e){
              const snackbar=SnackBar(content: Text('Please enter valid data'),);
               ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }} 
  @override
  Widget build(BuildContext context) {
 
    return Card(elevation: 5,child:Container(
         padding: const EdgeInsets.all(10),
         child:Column(
           crossAxisAlignment: CrossAxisAlignment.end,children: [
         TextField(decoration: const InputDecoration(labelText: 'Enter Item'),controller: _itemName,
         onSubmitted: (_) => _submitData(),),
         TextField(decoration: const InputDecoration(labelText: 'Amount'),controller: _ammount,
         keyboardType: TextInputType.number,
         onSubmitted: (_) => _submitData()
      
         ,),
         Row(children: [
          Expanded(child: Text(_selectedDate== null ?"No date choosen":'Picked Date ${DateFormat.yMd().format(_selectedDate!)}',)),
           FlatButton(textColor: Theme.of(context).primaryColor, onPressed:()=> presentDatePicker(), child: Text( "Choose date",style: TextStyle(fontWeight: FontWeight.bold),))
         ],),
         // ignore: deprecated_member_use
      
      RaisedButton(color: Theme.of(context).primaryColor, onPressed:_submitData, child: const Text('Add Expense'),textColor: Colors.white,)
       ],))

    );}
}
