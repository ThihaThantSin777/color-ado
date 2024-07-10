import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/bloc/home_bloc.dart';
import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/pages/users/coming_soon_page.dart';
import 'package:color_ado/widgets/card_image_horizontal_list_widget.dart';
import 'package:color_ado/widgets/custom_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Banner View
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Selector<HomeBloc, List<BannerVO>?>(
                    selector: (_, bloc) => bloc.getBannerList,
                    builder: (_, bannerList, __) {
                      if (bannerList == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (bannerList.isEmpty) {
                        return const Center(
                          child: Text("Banner data is empty in database"),
                        );
                      }

                      return _BannerView(
                        bannerList: bannerList,
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                ///Facilities View
                Selector<HomeBloc, List<FacilitiesVO>?>(
                  selector: (_, bloc) => bloc.getFacilitiesList,
                  builder: (_, facilitiesList, __) {
                    if (facilitiesList == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (facilitiesList.isEmpty) {
                      return const Center(
                        child: Text("Facilities data is empty in database"),
                      );
                    }

                    return CardImageHorizontalListWidget(
                      title: 'Facilities',
                      imageList: facilitiesList.map((e) => e.url).toList(),
                      onTapViewAll: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ComingSoonPage()));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                ///Centers View
                Selector<HomeBloc, List<CentersVO>?>(
                  selector: (_, bloc) => bloc.getCentersList,
                  builder: (_, centersList, __) {
                    if (centersList == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (centersList.isEmpty) {
                      return const Center(
                        child: Text("Centers data is empty in database"),
                      );
                    }

                    return CardImageHorizontalListWidget(
                      title: 'Centers',
                      imageList: centersList.map((e) => e.url).toList(),
                      onTapViewAll: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ComingSoonPage()));
                      },
                      cardListViewHeight: 200,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                ///Local And International Relationship View
                Selector<HomeBloc, List<LocalAndInternationalRelationsVO>?>(
                  selector: (_, bloc) => bloc.getLocalAndInternationalRelationsList,
                  builder: (_, localAndInternationalRelationsList, __) {
                    if (localAndInternationalRelationsList == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (localAndInternationalRelationsList.isEmpty) {
                      return const Center(
                        child: Text("Local And International Relationships data is empty in database"),
                      );
                    }

                    return CardImageHorizontalListWidget(
                      title: 'Local And International Relationships',
                      cardListViewHeight: 250,
                      imageList: localAndInternationalRelationsList.map((e) => e.url).toList(),
                      onTapViewAll: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ComingSoonPage()));
                      },
                    );
                  },
                ),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerView extends StatefulWidget {
  const _BannerView({
    required this.bannerList,
  });

  final List<BannerVO> bannerList;

  @override
  State<_BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<_BannerView> {
  final _pageController = PageController();
  int _pageIndex = 0;

  @override
  void initState() {
    Timer.periodic(
        const Duration(
          seconds: 2,
        ), (_) {
      _pageController.jumpToPage(_pageIndex == widget.bannerList.length - 1 ? 0 : ++_pageIndex);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: PageView.builder(
          onPageChanged: (index) {
            if (mounted) {
              setState(() {
                _pageIndex = index;
              });
            }
          },
          controller: _pageController,
          itemCount: widget.bannerList.length,
          itemBuilder: (_, index) => CachedNetworkImage(
            imageUrl: widget.bannerList[index].url,
            fit: BoxFit.cover,
          ),
        )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: CustomIndicatorWidget(
                onTapIndicator: (index) {
                  _pageController.jumpToPage(index);
                },
                activeColor: Colors.blue,
                pageIndex: _pageIndex,
                totalIndicator: widget.bannerList.length,
              ),
            )),
      ],
    );
  }
}
