import 'package:color_ado/bloc/users/index_bloc.dart';
import 'package:color_ado/pages/users/cu_events_page.dart';
import 'package:color_ado/pages/users/home_page.dart';
import 'package:color_ado/pages/users/news_page.dart';
import 'package:color_ado/pages/users/notification_page.dart';
import 'package:color_ado/pages/users/setting_page.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/utils/enums.dart';
import 'package:color_ado/widgets/loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IndexBloc>(
      create: (_) => IndexBloc(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Selector<IndexBloc, int?>(
                selector: (_, bloc) => bloc.getTotalNotificationCount,
                builder: (context, notificationCount, __) {
                  return Badge(
                    alignment: const Alignment(0.15, -1),
                    isLabelVisible: notificationCount != null && notificationCount != 0,
                    label: Text(notificationCount.toString()),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () {
                          final bloc = context.read<IndexBloc>();
                          bloc.setNewsNotificationRead();
                          bloc.setCUEventsNotificationRead();
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationPage()));
                        },
                        child: const Icon(
                          Icons.notifications,
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
        bottomNavigationBar: const _IndexBottomNavigationBarView(),
        body: Selector<IndexBloc, LoadingState>(
            selector: (_, bloc) => bloc.getLoadingState,
            builder: (_, loadingState, __) {
              return LoadingStateWidget<IndexBloc>(
                loadingState: loadingState,
                widgetForSuccessState: Selector<IndexBloc, UserBottomNavigationBarIndex>(
                    selector: (_, bloc) => bloc.getActiveIndex,
                    builder: (_, activeIndex, __) => IndexedStack(
                          index: activeIndex.index,
                          children: const [
                            HomePage(),
                            NewsPage(),
                            CUEventsPage(),
                            SettingPage(),
                          ],
                        )),
              );
            }),
      ),
    );
  }
}

class _IndexBottomNavigationBarView extends StatelessWidget {
  const _IndexBottomNavigationBarView();

  @override
  Widget build(BuildContext context) {
    return Selector<IndexBloc, UserBottomNavigationBarIndex>(
        selector: (_, bloc) => bloc.getActiveIndex,
        builder: (_, activeIndex, __) {
          return _CustomBottomNavigationBarWidget(
              currentIndex: activeIndex.index,
              onTap: (index) {
                final bloc = context.read<IndexBloc>();
                bloc.setActiveIndex(UserBottomNavigationBarIndex.values.elementAt(index));
              });
        });
  }
}

class _CustomBottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _CustomBottomNavigationBarWidget({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _CustomNavItemWidget(
            index: 0,
            icon: Icons.home,
            activeIcon: Icons.home_filled,
            label: kHomeBottomNavigationBar,
            isSelected: currentIndex == 0,
            onTap: () {
              onTap(0);
            },
          ),
          Selector<IndexBloc, int>(
              selector: (_, bloc) => bloc.getNewsNotificationCount,
              builder: (_, newsNotificationCount, __) {
                return Badge(
                  isLabelVisible: newsNotificationCount != 0,
                  label: Text(newsNotificationCount.toString()),
                  child: _CustomNavItemWidget(
                    index: 1,
                    icon: Icons.newspaper,
                    activeIcon: Icons.newspaper_outlined,
                    label: kNewsBottomNavigationBar,
                    isSelected: currentIndex == 1,
                    onTap: () {
                      if (newsNotificationCount != 0) {
                        final bloc = context.read<IndexBloc>();
                        bloc.setNewsNotificationRead();
                      }
                      onTap(1);
                    },
                  ),
                );
              }),
          Selector<IndexBloc, int>(
              selector: (_, bloc) => bloc.getCUEventsNotificationCount,
              builder: (_, notificationCount, __) {
                return Badge(
                  isLabelVisible: notificationCount != 0,
                  label: Text(notificationCount.toString()),
                  child: _CustomNavItemWidget(
                    index: 2,
                    icon: Icons.event,
                    activeIcon: Icons.event_available,
                    label: kCUEventsBottomNavigationBar,
                    isSelected: currentIndex == 2,
                    onTap: () {
                      if (notificationCount != 0) {
                        final bloc = context.read<IndexBloc>();
                        bloc.setCUEventsNotificationRead();
                      }
                      onTap(2);
                    },
                  ),
                );
              }),
          _CustomNavItemWidget(
            index: 3,
            icon: Icons.settings,
            activeIcon: Icons.settings,
            label: kSettingBottomNavigationBar,
            isSelected: currentIndex == 3,
            onTap: () {
              onTap(3);
            },
          ),
        ],
      ),
    );
  }
}

class _CustomNavItemWidget extends StatelessWidget {
  final int index;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CustomNavItemWidget({
    required this.index,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
