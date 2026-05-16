import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/tap_feedback.dart';
import 'routes.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({required this.child, super.key});

  static const _tabRoots = [
    AppRoutes.home,
    AppRoutes.nearby,
    AppRoutes.chatTab,
    AppRoutes.profileView,
  ];

  bool _showBottomNav(String path) {
    if (_tabRoots.contains(path)) return true;
    for (final root in _tabRoots) {
      if (path.startsWith(root)) return true;
    }
    return false;
  }

  int _selectedIndex(String path) {
    if (path.startsWith('/home/chat')) return 2;
    if (path.startsWith('/home/profile')) return 3;
    if (path.startsWith('/home/nearby')) return 1;
    return 0;
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.nearby);
      case 2:
        context.go(AppRoutes.chatTab);
      case 3:
        context.go(AppRoutes.profileView);
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final showNav = _showBottomNav(location);
    final selectedIndex = _selectedIndex(location);
    final primaryColor = Theme.of(context).colorScheme.primary;
    final mutedColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Scaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showNav
          ? FloatingActionButton(
              onPressed: () => context.push('/image-identify'),
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 4,
              child: const Icon(Icons.camera_alt_outlined, size: 28),
            )
          : null,
      bottomNavigationBar: showNav
          ? BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              height: 64,
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  _NavItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: 'nav.home'.tr(),
                    selected: selectedIndex == 0,
                    color: selectedIndex == 0 ? primaryColor : mutedColor,
                    onTap: () => _onTabTapped(context, 0),
                  ),
                  _NavItem(
                    icon: Icons.location_on_outlined,
                    activeIcon: Icons.location_on,
                    label: 'nav.nearby'.tr(),
                    selected: selectedIndex == 1,
                    color: selectedIndex == 1 ? primaryColor : mutedColor,
                    onTap: () => _onTabTapped(context, 1),
                  ),
                  const SizedBox(width: 80),
                  _NavItem(
                    icon: Icons.chat_bubble_outline,
                    activeIcon: Icons.chat_bubble,
                    label: 'nav.chat'.tr(),
                    selected: selectedIndex == 2,
                    color: selectedIndex == 2 ? primaryColor : mutedColor,
                    onTap: () => _onTabTapped(context, 2),
                  ),
                  _NavItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'nav.profile'.tr(),
                    selected: selectedIndex == 3,
                    color: selectedIndex == 3 ? primaryColor : mutedColor,
                    onTap: () => _onTabTapped(context, 3),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TapFeedback(
        onTap: onTap,
        borderRadius: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                    child: child,
                  );
                },
                child: Icon(
                  selected ? activeIcon : icon,
                  key: ValueKey(selected),
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
