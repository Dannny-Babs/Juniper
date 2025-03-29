import 'package:flutter/material.dart';
import '../utils/utils.dart';


class ScaffoldWithBottomNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNavBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: child,
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color:
                  isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
              boxShadow: [
                BoxShadow(
                  color: AppColors.backgroundDark.withAlpha(20),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: state.isTabLoading
                ? SizedBox(
                    height: 53,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : NavigationBar(
                    height: 53,
                    elevation: 0,
                    selectedIndex: state.currentIndex,
                    backgroundColor: isDarkMode
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    indicatorColor: isDarkMode
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysShow,
                    animationDuration: const Duration(milliseconds: 500),
                    onDestinationSelected: (index) {
                      context.read<NavigationBloc>().add(TabChanged(index));
                      switch (index) {
                        case 0:
                          context.go('/home');
                          break;
                        case 1:
                          context.go('/portfolio');
                          break;
                        case 2:
                          context.go('/chat');
                          break;
                        case 3:
                          context.go('/profile');
                          break;
                      }
                    },
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(EneftyIcons.building_3_outline),
                        selectedIcon: Icon(EneftyIcons.building_3_bold),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(EneftyIcons.chart_outline),
                        selectedIcon: Icon(EneftyIcons.chart_bold),
                        label: 'Portfolio',
                      ),
                      NavigationDestination(
                        icon: Icon(EneftyIcons.messages_3_outline),
                        selectedIcon: Icon(EneftyIcons.messages_3_bold),
                        label: 'Chat',
                      ),
                      NavigationDestination(
                        icon: Icon(EneftyIcons.profile_circle_outline),
                        selectedIcon: Icon(EneftyIcons.profile_circle_bold),
                        label: 'Profile',
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
