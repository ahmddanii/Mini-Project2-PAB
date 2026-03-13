import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../services/supabase_service.dart';

class EditTransactionPage extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransactionPage({super.key, required this.transaction});

  @override
  State<EditTransactionPage> createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late String _selectedCategory;

  final supabase = SupabaseService.client;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.transaction.title);
    _amountController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );
    _dateController = TextEditingController(text: widget.transaction.date);
    _selectedCategory = widget.transaction.category;
  }

  Future<void> updateTransaction() async {
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (_titleController.text.isEmpty ||
        amount <= 0 ||
        _dateController.text.isEmpty) {
      return;
    }

    await supabase
        .from('transactions')
        .update({
          'title': _titleController.text,
          'amount': amount,
          'category': _selectedCategory,
          'date': _dateController.text,
        })
        .eq('id', widget.transaction.id);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatRupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    // final inputAmount = double.tryParse(_amountController.text) ?? 0;

    InputDecoration inputStyle(String label) {
      return InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1ABC9C),
        title: const Text(
          "Edit Transaksi",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1ABC9C), Color(0xFF16A085)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit data transaksi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: _titleController,
              decoration: inputStyle("Nama Transaksi"),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: inputStyle(
                "Jumlah Transaksi",
              ).copyWith(prefixText: formatRupiah.currencySymbol),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: "Pemasukan",
                      child: Text("Pemasukan"),
                    ),
                    DropdownMenuItem(
                      value: "Pengeluaran",
                      child: Text("Pengeluaran"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: _pickDate,
              decoration: inputStyle(
                "Tanggal",
              ).copyWith(suffixIcon: const Icon(Icons.calendar_today)),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1ABC9C), Color(0xFF16A085)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                onPressed: updateTransaction,
                child: const Text(
                  "Update Transaksi",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
