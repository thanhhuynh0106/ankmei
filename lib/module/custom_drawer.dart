import 'package:ankmei_app/module/bottom_sheet.dart';
import 'package:ankmei_app/module/custom_header.dart';
import 'package:ankmei_app/providers/current_user_store.dart';
import 'package:ankmei_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final store = CurrentUserStore.instance;
    final displayName = store.user?.displayName;
    final username = store.user?.username;
    // Fallback to assets when not available
    final backgroundUrl = store.user?.backgroundUrl ?? 'assets/shuukuragif.gif';
    final avatarUrl = store.user?.avatarUrl ?? 'assets/cat_finger.jpg';

    return Drawer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(243, 238, 233, 1),
              Color.fromRGBO(197, 216, 240, 1),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CustomHeader(
              displayName: displayName!,
              username: username!,
              backgroundUrl: backgroundUrl,
              avatarUrl: avatarUrl,
              badges: const [
                Icon(Icons.favorite, size: 18),
                Icon(Icons.visibility_off, size: 18),
                Icon(Icons.warning_amber_rounded, size: 18),
                Icon(Icons.auto_awesome, size: 18),
              ],
            ),
            SizedBox(height: 106),
            // Divider(thickness: 1, color: Colors.grey),

            EditBottomSheet(),

            // !!!!!!!!! Core section =====================
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 20),
              collapsedShape: const RoundedRectangleBorder(
                side: BorderSide.none,
              ),
              shape: const RoundedRectangleBorder(side: BorderSide.none),
              title: Text(
                "Core",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.today, size: 22),
                        ),
                        title: Text("Today", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/today");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.upcoming, size: 22),
                        ),
                        title: Text("Upcoming", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/upcoming");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.calendar_month, size: 22),
                        ),
                        title: Text("Calendar", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/calendar");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.folder_open, size: 22),
                        ),
                        title: Text("Projects", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/projects");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.assignment_ind, size: 22),
                        ),
                        title: Text("Assgined", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/assigned");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // !!!!!!!!! Explore section =====================
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 20),
              collapsedShape: const RoundedRectangleBorder(
                side: BorderSide.none,
              ),
              shape: const RoundedRectangleBorder(side: BorderSide.none),
              title: Text(
                "Utilities",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.sunny_snowing, size: 22),
                        ),
                        title: Text("Weather", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/weather");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.access_time, size: 22),
                        ),
                        title: Text("Clock", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/clock");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.note, size: 22),
                        ),
                        title: Text("Notes", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/notes");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // !!!!!!!!! Settings section =====================
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 20),
              collapsedShape: const RoundedRectangleBorder(
                side: BorderSide.none,
              ),
              shape: const RoundedRectangleBorder(side: BorderSide.none),
              initiallyExpanded: true,
              title: Text(
                "Settings",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.person, size: 22),
                        ),
                        title: Text("Profile", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/profile");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.settings, size: 22),
                        ),
                        title: Text("Settings", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/settings");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.info, size: 22),
                        ),
                        title: Text("About", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pushNamed(context, "/about");
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.logout, size: 22),
                        ),
                        title: Text("Logout", style: TextStyle(fontSize: 14)),
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder:(context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(15),
                                contentTextStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                  ),
                                content: Text("Are you sure you want to logout!?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await AuthService.instance.logout();
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                                      }
                                    },
                                    child: Text("Logout"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
