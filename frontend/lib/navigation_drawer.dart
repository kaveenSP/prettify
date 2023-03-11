import 'package:flutter/material.dart';
import 'package:prettify1/drawer_item.dart';
import 'package:prettify1/pages/aboutus.dart';
import 'package:prettify1/pages/settings.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.deepPurple[100],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(
                height: 40,
              ),
              const Divider(
                thickness: 1,
                height: 40,
                color: Colors.grey,
              ),
              DrawerItem(
                  name: 'Settings',
                  icon: Icons.settings,
                  onPressed: () => onItemPressed(context, index: 0)),
              DrawerItem(
                  name: 'About Us',
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 1)),
              DrawerItem(
                  name: 'Log out',
                  icon: Icons.logout,
                  onPressed: () => onItemPressed(context, index: 2)),
              const SizedBox(
                height: 390,
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Exit',
                  icon: Icons.exit_to_app,
                  onPressed: () => onItemPressed(context, index: 3)),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const settings()));
        break;
    }
  }

  Widget headerWidget() {
    const url =
        'https://media.istockphoto.com/photos/learn-to-love-yourself-first-picture-id1291208214?b=1&k=20&m=1291208214&s=170667a&w=0&h=sAq9SonSuefj3d4WKy4KzJvUiLERXge9VgZO-oqKUOo=';
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Shenal Fernando',
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 0, 0, 0))),
            SizedBox(
              height: 10,
            ),
            Text('shenalF22@gmail.com',
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 3, 3, 3)))
          ],
        )
      ],
    );
  }

  static pop(BuildContext context) {}
}
