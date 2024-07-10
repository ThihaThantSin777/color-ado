import 'package:color_ado/bloc/index_bloc.dart';
import 'package:color_ado/pages/users/coming_soon_page.dart';
import 'package:color_ado/pages/users/home_page.dart';
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
        body: Selector<IndexBloc, int>(
            selector: (_, bloc) => bloc.getActiveIndex,
            builder: (_, activeIndex, __) => IndexedStack(
                  index: activeIndex,
                  children: const [
                    HomePage(),
                    ComingSoonPage(),
                    ComingSoonPage(),
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
    return Selector<IndexBloc, int>(
        selector: (_, bloc) => bloc.getActiveIndex,
        builder: (_, activeIndex, __) {
          return BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: activeIndex,
            onTap: (index) {
              final bloc = context.read<IndexBloc>();
              bloc.setActiveIndex = index;
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
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.newspaper_outlined,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Icons.newspaper,
                ),
                label: 'News',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.event_available,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Icons.event,
                ),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          );
        });
  }
}
