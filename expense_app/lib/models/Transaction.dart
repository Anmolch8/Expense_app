import 'package:hive/hive.dart';
part 'Transaction.g.dart';
@HiveType(typeId: 0)

class Transaction {
  @HiveField(0)
  final String title;
  @HiveField(1)
   final double ammount;
   @HiveField(2)
   final DateTime date; 
Transaction({required this.title,required this.ammount,required this.date});
} 