import 'package:ankmei_app/module/custom_appbar.dart';
import 'package:ankmei_app/module/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final _pages = const [
    _HomeTab(key: PageStorageKey('home')),
    _CalendarTab(key: PageStorageKey('calendar')),
    _WeatherTab(key: PageStorageKey('weather')),
    _SettingsTab(key: PageStorageKey('settings')),
  ];

  final _titles = const ['AnkMei', 'Calendar', 'Weather', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: CustomAppbar(title: _titles[_index]),
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {

            },
          ),
        ],
      ),
      body: IndexedStack(index: _index, children: _pages),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Weather'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),

      // FAB chỉ xuất hiện ở Home (nếu muốn)
      floatingActionButton: _index == 0
          ? FloatingActionButton(
              onPressed: () {/* tạo nhanh task/chức năng home */},
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}


class _HomeTab extends StatelessWidget {
  const _HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HomeHero(),
        SizedBox(height: 16),
        _QuickActions(),
        SizedBox(height: 16),
        _TodayPreview(),
      ],
    );
  }
}

class _HomeHero extends StatelessWidget {
  const _HomeHero({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFA8A8), Color(0xFFB8CFFF)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Hi hiiiiiii ฅ^>⩊<^ ฅ\nLet\'s start your day with a smile!",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w600, 
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Image.asset(
            "assets/vit2.gif",
            height: 120,
            fit: BoxFit.cover,
          )
        ]
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({super.key});
  @override
  Widget build(BuildContext context) {
    Widget card(IconData icon, String label) => Expanded(
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(icon), const SizedBox(height: 6), Text(label)],
        )),
      ),
    );

    return Row(
      children: [
        card(Icons.add_task, 'New task'),
        const SizedBox(width: 12),
        card(Icons.alarm, 'Reminders'),
        const SizedBox(width: 12),
        card(Icons.calendar_month, 'Calendar'),
      ],
    );
  }
}

class _TodayPreview extends StatelessWidget {
  const _TodayPreview({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Today", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        ListTile(leading: Icon(Icons.check_box_outline_blank), title: Text("Buy milk")),
        ListTile(leading: Icon(Icons.check_box_outline_blank), title: Text("Finish report")),
      ],
    );
  }
}

class _CalendarTab extends StatelessWidget {
  const _CalendarTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Calendar'));
}

class _WeatherTab extends StatelessWidget {
  const _WeatherTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Weather'));
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Settings'));
}
