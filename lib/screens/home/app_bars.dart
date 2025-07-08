import 'package:flutter/material.dart';

PreferredSizeWidget homeAppBar(VoidCallback onProfileTap) {
  return AppBar(
    title: Text(
      'Recofrend',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    ),
    backgroundColor: Colors.lightBlue,
    actions: [
      IconButton(onPressed: onProfileTap, icon: Icon(Icons.account_circle)),
    ],
    elevation: 1,
  );
}

PreferredSizeWidget feedAppBar(int selectedIndex, Function(int) onTabChange) {
  return AppBar(
    title: Text(
      'Recofrend',
      style: TextStyle(
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    backgroundColor: Colors.white,
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: ElevatedButton(
          onPressed: () => onTabChange(0),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedIndex == 0 ? Colors.black : Colors.white,
            foregroundColor: selectedIndex == 0 ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          ),
          child: Text('Trending'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: ElevatedButton(
          onPressed: () => onTabChange(1),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedIndex == 1 ? Colors.black : Colors.white,
            foregroundColor: selectedIndex == 1 ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          ),
          child: Text('Following'),
        ),
      ),
    ],
    elevation: 1,
  );
}

PreferredSizeWidget discoverAppBar(VoidCallback onProfileTap) {
  return AppBar(
    title: Text(
      'Recofrend',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    ),
    backgroundColor: Colors.lightBlue,
    actions: [
      IconButton(onPressed: onProfileTap, icon: Icon(Icons.account_circle)),
    ],
    elevation: 1,
  );
}

PreferredSizeWidget profileAppBar() {
  return AppBar(title: Text('Profile'), backgroundColor: Colors.teal);
}
