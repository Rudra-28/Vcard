import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcard/pages/scanpage.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(title: Text("Contact List")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(ScanPage.routeName);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,

          backgroundColor: Colors.blueAccent,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "All"),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
            ),
          ],
        ),
      ),
    );
  }
}
