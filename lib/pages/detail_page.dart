import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';

class DetailPage extends StatelessWidget {
  final TransactionModel transaction;

  const DetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final formatRupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    final isIncome = transaction.category == "Pemasukan";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
        backgroundColor: const Color(0xFF1ABC9C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text("Jumlah", style: TextStyle(color: Colors.grey[600])),

              Text(
                formatRupiah.format(transaction.amount),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? Colors.green : Colors.red,
                ),
              ),

              const SizedBox(height: 20),

              Text("Kategori", style: TextStyle(color: Colors.grey[600])),

              Text(transaction.category),

              const SizedBox(height: 20),

              Text("Tanggal", style: TextStyle(color: Colors.grey[600])),

              Text(transaction.date),
            ],
          ),
        ),
      ),
    );
  }
}
