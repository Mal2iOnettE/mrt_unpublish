import 'package:flutter/material.dart';

enum TabItem { home, promotion, map, infomation, other }

Map<TabItem, String> tabName = {
  TabItem.home: 'home',
  TabItem.promotion: 'promotion',
  TabItem.map: 'map',
  TabItem.infomation: 'infomaton',
  TabItem.other: 'otherp',
};

Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.red,
  TabItem.promotion: Colors.green,
  TabItem.map: Colors.purple,
  TabItem.infomation: Colors.yellow,
  TabItem.other: Colors.orange,
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.home),
        _buildItem(tabItem: TabItem.promotion),
        _buildItem(tabItem: TabItem.map),
        _buildItem(tabItem: TabItem.infomation),
        _buildItem(tabItem: TabItem.other),
        
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = tabName[tabItem];
    IconData icon = Icons.layers;
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }
}
