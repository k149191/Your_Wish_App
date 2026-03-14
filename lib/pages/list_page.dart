import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/wish.dart';
import 'add_page.dart';

const pinkPrimary = Color.fromARGB(255, 232, 135, 166);

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  final supabase = Supabase.instance.client;

  List<Wish> wishes = [];
  List<Wish> filteredWishes = [];

  String searchQuery = '';
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    fetchWishes();
  }

  Future<void> fetchWishes() async {

    final response = await supabase
        .from('wishes')
        .select()
        .order('created_at', ascending: false);

    wishes = response.map<Wish>((data) {
      return Wish(
        id: data['id'] is int
            ? data['id']
            : int.tryParse(data['id'].toString()),
        title: data['title'] ?? '',
        price: data['price'] != null
            ? (data['price'] is double
                ? data['price']
                : double.tryParse(data['price'].toString()))
            : null,
        category: data['category'] ?? '',
        notes: data['notes'] ?? '',
      );
    }).toList();

    filteredWishes = List.from(wishes);

    setState(() {});
  }

  Future<void> deleteWish(String id) async {

    await supabase
        .from('wishes')
        .delete()
        .eq('id', int.parse(id));

    fetchWishes();
  }

  void applyFilter() {

    setState(() {

      filteredWishes = wishes.where((wish) {

        final matchSearch =
            wish.title.toLowerCase().contains(searchQuery.toLowerCase());

        final matchCategory =
            selectedCategory == 'All' || wish.category == selectedCategory;

        return matchSearch && matchCategory;

      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final inputColor = isDark
        ? Colors.grey.shade900
        : const Color(0xFFFFF0F6);

    final borderColor = pinkPrimary.withOpacity(0.35);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search wishlist...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: inputColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: pinkPrimary, width: 2),
                ),
              ),
              onChanged: (value) {
                searchQuery = value;
                applyFilter();
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                filled: true,
                fillColor: inputColor,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: pinkPrimary, width: 2),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All')),
                DropdownMenuItem(value: 'Skincare', child: Text('Skincare')),
                DropdownMenuItem(value: 'Makeup', child: Text('Makeup')),
                DropdownMenuItem(value: 'Fashion', child: Text('Fashion')),
                DropdownMenuItem(value: 'Buku', child: Text('Buku')),
                DropdownMenuItem(value: 'Makanan', child: Text('Makanan')),
                DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
              ],
              onChanged: (value) {
                selectedCategory = value!;
                applyFilter();
              },
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: filteredWishes.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          size: 80,
                          color: Color(0xFFFFB3D1),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No matching wish found.',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredWishes.length,
                    itemBuilder: (context, index) {

                      final wish = filteredWishes[index];

                      return _KartuWish(
                        wish: wish,
                        onHapus: () => _konfirmasiHapus(context, wish),
                        onEdit: () async {

                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPage(
                                wishYangDiedit: wish,
                              ),
                            ),
                          );

                          if (result == true) {
                            fetchWishes();
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _konfirmasiHapus(BuildContext context, Wish wish) {

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Delete Your Wish?'),
        content: Text('Sure deleting ${wish.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : const Color.fromARGB(255, 22, 22, 22),
            ),
            child: const Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              deleteWish(wish.id.toString());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: pinkPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
            child: const Text(
              'Yes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KartuWish extends StatelessWidget {

  final Wish wish;
  final VoidCallback onHapus;
  final VoidCallback onEdit;

  const _KartuWish({
    required this.wish,
    required this.onHapus,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark
        ? Colors.grey.shade900
        : Colors.white;

    final chipColor = isDark
        ? Colors.grey.shade800
        : const Color(0xFFFFF0F6);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: pinkPrimary.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [

          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: chipColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.favorite,
              color: pinkPrimary,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  wish.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                if (wish.price != null)
                  Text(
                    'Rp ${wish.price!.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: pinkPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                const SizedBox(height: 6),

                if (wish.category.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: chipColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      wish.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                const SizedBox(height: 6),

                if (wish.notes.isNotEmpty)
                  Text(
                    wish.notes,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),

          Column(
            children: [

              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFFFE6EF),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.edit,
                    size: 18,
                    color: pinkPrimary,
                  ),
                  onPressed: onEdit,
                ),
              ),

              const SizedBox(height: 8),

              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFFFE6EF),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.delete,
                    size: 18,
                    color: pinkPrimary,
                  ),
                  onPressed: onHapus,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}