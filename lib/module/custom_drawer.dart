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

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(14, 10, 10, 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 240, 246, 252),
                      Color.fromARGB(255, 226, 237, 250),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Friends",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 78, 78, 78),
                              letterSpacing: .2,
                            )
                          )
                        ),
                        _AvatarChip(value: "https://i.pravatar.cc/300"),
                        _AvatarChip(value: "https://i.pravatar.cc/303"),
                        _AvatarChip(value: "https://i.pravatar.cc/305"),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: IconButton(
                          onPressed: () {
                            
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          ),
                        )
                      ],
                    ),
                  ]
                ),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(14, 10, 10, 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 240, 246, 252),
                      Color.fromARGB(255, 226, 237, 250),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Text(
                          "Notes (only me)",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 78, 78, 78),
                            letterSpacing: .2,
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child:  Icon(
                          Icons.note_add_rounded,
                          size: 16,
                          color: Colors.grey.shade600,
                        )
                      )
                    ],)
                  ],
                ),
              ),
              ), 
            

            // !!!!!!!!! Core section =====================
            SizedBox(height: 20),
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




class _AvatarChip extends StatelessWidget {
  final String value;
  const _AvatarChip({required this.value});

  bool get _isUrl => value.startsWith('http://') || value.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: _isUrl ? NetworkImage(value) : null,
      child: !_isUrl
          ? Text(
              value.length >= 2 ? value.substring(0, 2).toUpperCase() : value.toUpperCase(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black87),
            )
          : null,
    );
  }
}