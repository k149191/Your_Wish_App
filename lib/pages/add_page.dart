import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/wish.dart';

class AddPage extends StatefulWidget {
  final Wish? wishYangDiedit;
  final int activeUserId;

  const AddPage({
    super.key,
    this.wishYangDiedit,
    required this.activeUserId, 
  });

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final supabase = Supabase.instance.client;

  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  String _kategoriDipilih = 'Skincare';

  final List<String> _daftarKategori = [
    'Makeup',
    'Skincare',
    'Fashion',
    'Buku',
    'Makanan',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.wishYangDiedit != null) {
      _titleController.text = widget.wishYangDiedit!.title;
      _priceController.text = widget.wishYangDiedit!.price != null
          ? widget.wishYangDiedit!.price!.toString()
          : '';
      _notesController.text = widget.wishYangDiedit!.notes;
      _kategoriDipilih = widget.wishYangDiedit!.category.isEmpty
          ? 'Skincare'
          : widget.wishYangDiedit!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: const Color.fromARGB(255, 232, 135, 166),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _simpan() async {

    final title = _titleController.text.trim();
    final priceText = _priceController.text.trim();
    final notes = _notesController.text.trim();
    final category = _kategoriDipilih;

    if (title.isEmpty) {
      _showSnack('Title is required');
      return;
    }

    if (category.isEmpty) {
      _showSnack('Category is required');
      return;
    }

    int? price;

    if (priceText.isNotEmpty) {
      price = int.tryParse(priceText);

      if (price == null) {
        _showSnack('Price must be a valid number');
        return;
      }
    }

    try {

      if (widget.wishYangDiedit == null) {

        await supabase.from('wishes').insert({
          'title': title,
          'price': price,
          'category': category,
          'notes': notes,
          'id_users': widget.activeUserId, 
        });

        _showSnack('Wish added successfully');

      } else {

        await supabase
            .from('wishes')
            .update({
              'title': title,
              'price': price,
              'category': category,
              'notes': notes,
            })
            .eq('id_wish', widget.wishYangDiedit!.idWish)
            .eq('id_users', widget.activeUserId);

        _showSnack('Wish updated successfully');
      }

      await Future.delayed(const Duration(milliseconds: 500));

      Get.back(result: true);

    } catch (e) {

      _showSnack('Something went wrong');

    }
  }

  @override
  Widget build(BuildContext context) {

    final isDark = Get.isDarkMode;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _labelField('Title *'),
            TextField(
              controller: _titleController,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
              decoration: _inputDecor('e.g. Wardah Acnederm Facewash'),
            ),
            const SizedBox(height: 16),

            _labelField('Price'),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
              decoration: _inputDecor('e.g. 35000'),
            ),
            const SizedBox(height: 16),

            _labelField('Category*'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff2a2a2a) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFE0EE), width: 1.5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _kategoriDipilih,
                  dropdownColor: isDark ? const Color(0xff2a2a2a) : Colors.white,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  isExpanded: true,
                  onChanged: (nilai) {
                    if (nilai != null) {
                      setState(() => _kategoriDipilih = nilai);
                    }
                  },
                  items: _daftarKategori
                      .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                      .toList(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            _labelField('Notes'),
            TextField(
              controller: _notesController,
              maxLines: 3,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
              decoration: _inputDecor(
                  'Add notes (e.g. why you want this, where to buy)'),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 232, 135, 166),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  widget.wishYangDiedit == null
                      ? 'Add to your wish list.'
                      : 'Update wish',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelField(String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        teks,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9B7A8A),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  InputDecoration _inputDecor(String hint) {

    final isDark = Get.isDarkMode;

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: isDark ? Colors.white54 : Colors.grey,
        fontSize: 14,
      ),
      filled: true,
      fillColor: isDark ? const Color(0xff2a2a2a) : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFFE0EE), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFFE0EE), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF80B3), width: 2),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}