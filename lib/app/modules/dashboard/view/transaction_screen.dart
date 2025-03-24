import 'package:flutter/material.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/transaction_card.dart';
class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Store Transactions'),
        elevation: 0,
        backgroundColor: const Color(0xFF2C3E50),
      ),
      body:  TransactionTable(),
    );
  }
}