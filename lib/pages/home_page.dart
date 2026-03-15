import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_page.dart';
import 'list_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final int activeUserId;

  const HomePage({super.key, required this.activeUserId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget halamanAktif;

    if (currentPage == 0) {
      halamanAktif = _HalamanHome(
        onMulai: () => setState(() => currentPage = 1),
      );
    } else if (currentPage == 1) {
      halamanAktif = AddPage(activeUserId: widget.activeUserId);
    } else {
      halamanAktif = ListPage(activeUserId: widget.activeUserId);
    }

    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? const Color(0xff121212) : const Color(0xFFFFF8FB),

      appBar: currentPage == 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : AppBar(
              backgroundColor:
                  Get.isDarkMode ? const Color(0xff121212) : const Color(0xFFFFF8FB),
              elevation: 0,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text(
                  currentPage == 1 ? 'Add Your Wish' : 'Your Wish List',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : const Color(0xff3b2b2b),
                  ),
                ),
              ),
            ),

      body: halamanAktif,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage == 0 ? 0 : currentPage,
        onTap: (index) => setState(() => currentPage = index),
        backgroundColor:
            Get.isDarkMode ? const Color(0xff1c1c1c) : Colors.white,
        selectedItemColor: const Color.fromARGB(255, 232, 135, 166),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_rounded),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}

class _HalamanHome extends StatelessWidget {
  final VoidCallback onMulai;

  const _HalamanHome({
    required this.onMulai,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Get.isDarkMode
                  ? const [Color(0xff1a1a1a), Color(0xff2b2b2b)]
                  : const [Color(0xFFFFF0F6), Color(0xFFFFF8FB)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.favorite_rounded,
                size: 100,
                color: Color.fromARGB(255, 232, 135, 166),
              ),
              const SizedBox(height: 24),
              Text(
                'Your Wish',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color:
                      Get.isDarkMode ? Colors.white : const Color(0xff3b2b2b),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onMulai,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 232, 135, 166),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Start adding your dream items.',
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: Get.isDarkMode ? Colors.white : const Color(0xff3b2b2b),
            ),
            onPressed: () {
              Get.offAll(() => const LoginPage());
            },
            tooltip: 'Logout',
          ),
        ),        

        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: Icon(
              Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Get.isDarkMode ? Colors.white : const Color(0xff3b2b2b),
            ),
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ),
      ],
    );
  }
}