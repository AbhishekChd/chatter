import 'package:chatter/app.dart';
import 'package:chatter/pages/pages.dart';
import 'package:chatter/screens/screens.dart';
import 'package:chatter/theme.dart';
import 'package:chatter/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier("Messages");

  final pages = const [MessagesPage(), NotificationsPage(), CallsPage(), ContactsPage()];

  final pageTitles = const ["Messages", "Notifications", "Calls", "Contacts"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (context, value, child) => Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {},
          ),
        ),
        leadingWidth: 54,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Hero(
              tag: "user-profile-image",
              child: Avatar.small(
                url: context.currentUserImage,
                onTap: () => Navigator.of(context).push(ProfileScreen.route),
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, value, child) => pages[value],
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }

  void _onNavigationItemSelected(index) {
    pageIndex.value = index;
    title.value = pageTitles[index];
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemSelected}) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Card(
      color: isLightMode ? Colors.transparent : null,
      elevation: 0,
      child: SafeArea(
          top: false,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                  index: 0,
                  label: "Messages",
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                  onTap: handleItemSelected,
                  isItemSelected: selectedIndex == 0,
                ),
                _NavigationBarItem(
                  index: 1,
                  label: "Calls",
                  icon: CupertinoIcons.phone_fill,
                  onTap: handleItemSelected,
                  isItemSelected: selectedIndex == 1,
                ),
                ActionButton(color: AppColors.secondary, icon: CupertinoIcons.add, size: 48, onPressed: () {}),
                _NavigationBarItem(
                  index: 2,
                  label: "Contacts",
                  icon: CupertinoIcons.person_2_fill,
                  onTap: handleItemSelected,
                  isItemSelected: selectedIndex == 2,
                ),
                _NavigationBarItem(
                  index: 3,
                  label: "Notifications",
                  icon: CupertinoIcons.bell_solid,
                  onTap: handleItemSelected,
                  isItemSelected: selectedIndex == 3,
                ),
              ],
            ),
          )),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.index,
      required this.onTap,
      this.isItemSelected = false})
      : super(key: key);

  final int index;
  final String label;
  final IconData icon;
  final ValueChanged<int> onTap;
  final bool isItemSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isItemSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 12,
                  color: isItemSelected ? AppColors.secondary : null,
                  fontWeight: isItemSelected ? FontWeight.bold : null),
            )
          ],
        ),
      ),
    );
  }
}
