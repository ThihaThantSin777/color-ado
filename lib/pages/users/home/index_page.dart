import 'package:color_ado/bloc/users/index_bloc.dart';
import 'package:color_ado/pages/coming_soon_page.dart';
import 'package:color_ado/pages/users/home/cu_events_page.dart';
import 'package:color_ado/pages/users/home/home_page.dart';
import 'package:color_ado/pages/users/home/news_page.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IndexBloc>(
      create: (_) => IndexBloc(),
      child: Scaffold(
        bottomNavigationBar: const _IndexBottomNavigationBarView(),
        body: Selector<IndexBloc, UserBottomNavigationBarIndex>(
            selector: (_, bloc) => bloc.getActiveIndex,
            builder: (_, activeIndex, __) => IndexedStack(
                  index: activeIndex.index,
                  children: const [
                    HomePage(),
                    NewsPage(),
                    CUEventsPage(),
                    ComingSoonPage(),
                  ],
                )),
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
          return BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: activeIndex.index,
            onTap: (index) {
              final bloc = context.read<IndexBloc>();
              bloc.setActiveIndex = UserBottomNavigationBarIndex.values.elementAt(index);
            },
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home_filled,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Icons.home,
                ),
                label: kHomeBottomNavigationBar,
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.newspaper_outlined,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Icons.newspaper,
                ),
                label: kNewsBottomNavigationBar,
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.event_available,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Icons.event,
                ),
                label: kCUEventsBottomNavigationBar,
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Icons.settings,
                ),
                label: kSettingBottomNavigationBar,
              ),
            ],
          );
        });
  }
}
