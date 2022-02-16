// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';
import 'package:expense_app/widgets/chart.dart';

import './models/transactionn.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:expense_app/widgets/TransactionList.dart';
//import 'package:expense_app/widgets/new_Transaction.dart';
import 'package:expense_app/widgets/new_Transaction.dart';

import 'package:path_provider/path_provider.dart';
import './models/Transaction.dart';
import 'package:flutter/material.dart';
import './widgets/TransactionList.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:hive/hive.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // final Directory doc= await getApplicationDocumentsDirectory();
  //Hive.init(doc.path);
  //Hive.registerAdapter(TransactionAdapter());
  // final itemBox=await Hive.openBox('entries'); used to open page once for every page of application 
  // to open box for only one page use futurebuilder widget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        canvasColor: Colors.grey,
        fontFamily: 'QuickSans',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6 : TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            
          )
        ),
        //appBarTheme: AppBarTheme( 
          //textTheme: ThemeData.light().textTheme.copyWith(
          //subtitle1 : TextStyle(
           // fontFamily: 'OpenSans',
            //fontWeight: FontWeight.bold,
            //fontSize: 50,
            
          //)
        //))

      ),
      home: Homepage() );
  } 
}
class Homepage extends StatefulWidget {

  Homepage({Key? key}) : super(key: key);

  @override
 State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
 
 final List<Transactionn> _TList =  [
  //Transactionn( title: 'groceries', ammount: 500.0, date: DateTime.now()),
  //Transactionn( title: 'clothes', ammount: 400.0, date: DateTime.now())
  ];
  List<Transactionn> get _recentTransaction{
     return _TList.where((ele){
       return ele.date.isAfter(DateTime.now().subtract(Duration(days: 7),
       ),);
     }).toList();
  }

void _addnewTransaction(String id,String tit,double amm,DateTime chosenDate){
  final newtx = Transactionn(id:DateTime.now().toString() ,title: tit,ammount: amm,date: chosenDate);
  setState(() {
    _TList.add(newtx);
  });}
  //@override
  //void initState() {
    // ignore: todo
    // TODO: implement initState
    //super.initState();
    //itemBox= Hive.box('entries');

  //}
void _modalAddNewTransaction(BuildContext ctx){
  showModalBottomSheet(context: ctx, builder: (_){
     return newTransaction(_addnewTransaction);
  });
}
void _deleleTransaction(String id){
     setState(() {
       _TList.removeWhere((element) {
         return element.id== id;
       });
     });
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(title: const Text('Personal Expenses'),
      actions: [IconButton(onPressed: () =>_modalAddNewTransaction(context), icon: Icon(Icons.add))],),
      body:SingleChildScrollView(child: Column(//mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        // ignore: sized_box_for_whitespace
        Container(width:double.infinity,
       child:chart(_recentTransaction),),
  TransactionList(_TList, _deleleTransaction),
      ],)
    ),
    floatingActionButton: FloatingActionButton(onPressed:() =>_modalAddNewTransaction(context),
    child: Icon(Icons.add)),);
  }
}





