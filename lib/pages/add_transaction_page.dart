import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/supabase_service.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  final supabase = SupabaseService.client;

  String _selectedCategory = "Pemasukan";

  double currentSaldo = 0;

  Future<void> getSaldo() async {
    final data = await supabase.from('transactions').select();

    double income = 0;
    double expense = 0;

    for (var trx in data) {
      if (trx['category'] == "Pemasukan") {
        income += trx['amount'];
      } else {
        expense += trx['amount'];
      }
    }

    setState(() {
      currentSaldo = income - expense;
    });
  }

  @override
  void initState() {
    super.initState();
    getSaldo();
  }

  Future<void> addTransaction() async {
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (_titleController.text.isEmpty ||
        amount <= 0 ||
        _dateController.text.isEmpty)
      return;

    if (_selectedCategory == "Pengeluaran" && amount > currentSaldo) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saldo tidak cukup untuk pengeluaran!")),
      );
      return;
    }

    await supabase.from('transactions').insert({
      'title': _titleController.text,
      'amount': amount,
      'category': _selectedCategory,
      'date': _dateController.text,
    });

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

    final inputAmount = double.tryParse(_amountController.text) ?? 0;

    double previewSaldo = currentSaldo;

    if (_selectedCategory == "Pemasukan") {
      previewSaldo += inputAmount;
    } else {
      previewSaldo -= inputAmount;
    }

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
          "Tambah Transaksi",
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Saldo Saat Ini",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatRupiah.format(currentSaldo),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
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
              decoration: inputStyle("Jumlah Transaksi"),
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

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: previewSaldo >= 0
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Saldo Setelah Transaksi"),
                  Text(
                    formatRupiah.format(previewSaldo),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: previewSaldo >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
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
                onPressed: addTransaction,
                child: const Text(
                  "Simpan Transaksi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
