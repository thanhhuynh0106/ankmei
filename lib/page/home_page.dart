import 'package:ankmei_app/custom_object/task.dart';
import 'package:ankmei_app/module/create_task_card.dart';
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
          IconButton(icon: const Icon(Icons.dark_mode), onPressed: () {}),
        ],
      ),
      body: IndexedStack(index: _index, children: _pages),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        height: 84,
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomItem(
                assetPath: 'assets/home.png',
                label: 'Home',
                selected: _index == 0,
                onTap: () => setState(() => _index = 0),
              ),
              _BottomItem(
                assetPath: 'assets/user.png',
                label: 'Profile',
                selected: _index == 1,
                onTap: () => setState(() => _index = 1),
              ),
              const SizedBox(width: 60),
              _BottomItem(
                assetPath: 'assets/calendar.png',
                label: 'Calendar',
                selected: _index == 2,
                onTap: () => setState(() => _index = 2),
              ),
              _BottomItem(
                assetPath: 'assets/notification.png',
                label: 'Notification',
                selected: _index == 3,
                onTap: () => setState(() => _index = 3),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Transform.translate(
        offset: const Offset(0, 6),
        child: SizedBox(
          width: 58,
          height: 58,
          child: FloatingActionButton(
            onPressed: () {
              // action nhanh
            },
            child: const Icon(Icons.add, size: 32),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Color(0xFFEFEFEF)),
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      ),
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
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/natchan.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      // child: Column(
      //   children: [
      //     const Text(
      //       "Hi hiiiiiii ฅ^>⩊<^ ฅ\nLet\'s start your day with a smile!",
      //       style: TextStyle(
      //         fontSize: 18,
      //         fontWeight: FontWeight.w600,
      //         color: Colors.white,
      //         fontStyle: FontStyle.italic,
      //       ),
      //       textAlign: TextAlign.center,
      //     ),
      //     const SizedBox(height: 12),
      //   ],
      // ),
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(icon), const SizedBox(height: 6), Text(label)],
          ),
        ),
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
      children: [
        const Text(
          "Today",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        CreateTaskCard(task: Task(
          id: '1',
          title: 'Design Meeting',
          description: 'Discuss the new app design with the team.',
          category: 'Work',
          priority: TaskPriority.medium,
          assignees: ['AD', 'MT'],
          dueDate: DateTime.now(),
        ))
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

class _BottomItem extends StatelessWidget {
  final String assetPath;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomItem({
    super.key,
    required this.assetPath,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selColor = Colors.black;
    final unSelColor = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.7);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: selColor.withValues(alpha: 0.12),
        highlightColor: selColor.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Image.asset(
                  assetPath,
                  key: ValueKey(selected),
                  width: selected ? 26 : 24,
                  height: selected ? 26 : 24,
                  color: selected ? selColor : unSelColor,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? selColor : unSelColor,
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: selected ? 1 : 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 16,
                  height: 2,
                  decoration: BoxDecoration(
                    color: selColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
