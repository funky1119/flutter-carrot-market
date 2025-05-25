import 'package:flutter_carrot_market/screen/main/tab/tab_item.dart';
import 'package:flutter_carrot_market/screen/main/tab/tab_navigator.dart';
import 'package:flutter/material.dart';

import '../../common/common.dart';
import 'w_menu_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabItem _currentTab = TabItem.home;
  final tabs = [TabItem.home, TabItem.favorite];
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  int get _currentIndex => tabs.indexOf(_currentTab);

  GlobalKey<NavigatorState> get _currentTabNavigationKey =>
      navigatorKeys[_currentIndex];

  bool get extendBody => true;

  static double get bottomNavigationBarBorderRadius => 30.0;

  @override
  void initState() {
    super.initState();
    initNavigatorKeys();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isRootPage,
      onPopInvoked: _handleBackPressed,
      child: Scaffold(
        extendBody: extendBody, //bottomNavigationBar 아래 영역 까지 그림
        drawer: const MenuDrawer(),
        body: Container(
          color: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.2), // 또는 커스텀 색상 사용 시 직접 지정
          padding: EdgeInsets.only(
            bottom: extendBody ? (60 - bottomNavigationBarBorderRadius) : 0,
          ),
          child: SafeArea(bottom: !extendBody, child: pages),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  bool get isRootPage =>
      _currentTab == TabItem.home &&
      _currentTabNavigationKey.currentState?.canPop() == false;

  IndexedStack get pages => IndexedStack(
    index: _currentIndex,
    children: List.generate(tabs.length, (index) {
      final tab = tabs[index];
      return Offstage(
        offstage: _currentTab != tab,
        child: TabNavigator(navigatorKey: navigatorKeys[index], tabItem: tab),
      );
    }),
  );

  void _handleBackPressed(bool didPop) {
    if (!didPop) {
      if (_currentTabNavigationKey.currentState?.canPop() == true) {
        Nav.pop(_currentTabNavigationKey.currentContext!);
        return;
      }

      if (_currentTab != TabItem.home) {
        _changeTab(tabs.indexOf(TabItem.home));
      }
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(bottomNavigationBarBorderRadius),
          topRight: Radius.circular(bottomNavigationBarBorderRadius),
        ),
        child: BottomNavigationBar(
          items: navigationBarItems(context),
          currentIndex: _currentIndex,
          selectedItemColor: context.appColors.text,
          unselectedItemColor: context.appColors.iconButtonInactivate,
          onTap: _handleOnTapNavigationBarItem,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> navigationBarItems(BuildContext context) {
    return List.generate(tabs.length, (index) {
      final tab = tabs[index];
      return tab.toNavigationBarItem(
        context,
        isActivated: _currentIndex == index,
      );
    });
  }

  void _changeTab(int index) {
    setState(() {
      _currentTab = tabs[index];
    });
  }

  BottomNavigationBarItem bottomItem(
    bool activate,
    IconData iconData,
    IconData inActivateIconData,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(
        key: ValueKey(label),
        activate ? iconData : inActivateIconData,
        color:
            activate
                ? context.appColors.iconButton
                : context.appColors.iconButtonInactivate,
      ),
      label: label,
    );
  }

  void _handleOnTapNavigationBarItem(int index) {
    final oldTab = _currentTab;
    final targetTab = tabs[index];
    if (oldTab == targetTab) {
      final navigationKey = _currentTabNavigationKey;
      popAllHistory(navigationKey);
    }
    _changeTab(index);
  }

  void popAllHistory(GlobalKey<NavigatorState> navigationKey) {
    final bool canPop = navigationKey.currentState?.canPop() == true;
    if (canPop) {
      while (navigationKey.currentState?.canPop() == true) {
        navigationKey.currentState!.pop();
      }
    }
  }

  void initNavigatorKeys() {
    for (final _ in tabs) {
      navigatorKeys.add(GlobalKey<NavigatorState>());
    }
  }
}
