import 'package:ankmei_app/module/custom_header.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(243, 238, 233, 1),
              Color.fromRGBO(197, 216, 240, 1),
            ]
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CustomHeader(
              displayName: "Soi",
              username: "thanhhyun_n",
              backgroundUrl: "assets/shuukuragif.gif",
              avatarUrl: "assets/cat_finger.jpg",
              badges: const [
                Icon(Icons.favorite, size: 18),
                Icon(Icons.visibility_off, size: 18),
                Icon(Icons.warning_amber_rounded, size: 18),
                Icon(Icons.auto_awesome, size: 18),
              ],
            ),
            SizedBox(height: 100),

            // !!!!!!!!! Core section =====================
            Padding(
              padding: EdgeInsetsGeometry.only(left: 24, top: 24, bottom: 8),
              child: Text("Core", style: Theme.of(context).textTheme.titleMedium),
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: Text("Today"),
              onTap: () {
                Navigator.pushNamed(context, "/today");
              },            
            ),
            ListTile(
              leading: Icon(Icons.upcoming),
              title: Text("Upcoming"),
              onTap: () {
                Navigator.pushNamed(context, "/upcoming");
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text("Calendar"),
              onTap: () {
                Navigator.pushNamed(context, "/calendar");
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_open),
              title: Text("Projects"),
              onTap: () {
                Navigator.pushNamed(context, "/projects");
              },
            ),

            // !!!!!!!!! Explore section =====================
            Padding(
              padding: EdgeInsetsGeometry.only(left: 24, top: 24, bottom: 8),
              child: Text("Explore", style: Theme.of(context).textTheme.titleMedium),
            )
          ],
        ),
      ),
    );
  }
}
