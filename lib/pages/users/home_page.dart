import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/bloc/users/home_bloc.dart';
import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/pages/users/home_details_page.dart';
import 'package:color_ado/pages/users/view_all_page.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/card_image_horizontal_list_widget.dart';
import 'package:color_ado/widgets/custom_indicator_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/shimmer_loading_widget.dart';
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
                  height: kBannerViewHeight,
                  child: Selector<HomeBloc, List<BannerVO>?>(
                    selector: (_, bloc) => bloc.getBannerList,
                    builder: (_, bannerList, __) {
                      if (bannerList == null) {
                        return const _BannerLoadingView();
                      }
                      if (bannerList.isEmpty) {
                        return const DataEmptyWidget();
                      }

                      return _BannerView(
                        bannerList: bannerList,
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: kSP20x,
                ),

                ///Facilities View
                Selector<HomeBloc, List<FacilitiesVO>?>(
                  selector: (_, bloc) => bloc.getFacilitiesList,
                  builder: (_, facilitiesList, __) {
                    if (facilitiesList == null) {
                      return const _CardImageHorizontalLoadingView(
                        height: kFacilitiesViewHeight,
                      );
                    }
                    if (facilitiesList.isEmpty) {
                      return const DataEmptyWidget();
                    }

                    return CardImageHorizontalListWidget(
                      onTapImageCard: (image, description, pdfName, pdfUrl, title) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HomeDetailsPage(
                              image: image,
                              description: description,
                              pdfName: pdfName,
                              pdfUrl: pdfUrl,
                              title: title,
                            ),
                          ),
                        );
                      },
                      title: kFacilitiesText,
                      imageAndDescList: facilitiesList
                          .map(
                            (e) => (
                              e.url,
                              e.description,
                              e.pdfName,
                              e.pdfURL,
                              e.title,
                            ),
                          )
                          .toList(),
                      onTapViewAll: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ViewAllPage(
                              title: kFacilitiesText,
                              viewAllPath: kFacilitiesPath,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: kSP20x,
                ),

                ///Centers View
                Selector<HomeBloc, List<CentersVO>?>(
                  selector: (_, bloc) => bloc.getCentersList,
                  builder: (_, centersList, __) {
                    if (centersList == null) {
                      return const _CardImageHorizontalLoadingView(
                        height: kCentersViewHeight,
                      );
                    }
                    if (centersList.isEmpty) {
                      return const DataEmptyWidget();
                    }

                    return CardImageHorizontalListWidget(
                      onTapImageCard: (image, description, pdfName, pdfUrl, title) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => HomeDetailsPage(
                                  image: image,
                                  description: description,
                                  pdfName: pdfName,
                                  pdfUrl: pdfUrl,
                                  title: title,
                                )));
                      },
                      title: kCentersText,
                      imageAndDescList: centersList
                          .map(
                            (e) => (
                              e.url,
                              e.description,
                              e.pdfName,
                              e.pdfURL,
                              e.title,
                            ),
                          )
                          .toList(),
                      onTapViewAll: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ViewAllPage(
                            title: kCentersText,
                            viewAllPath: kCentersPath,
                          ),
                        ));
                      },
                      cardListViewHeight: kCentersViewHeight,
                    );
                  },
                ),
                const SizedBox(
                  height: kSP20x,
                ),

                ///Local And International Relationship View
                Selector<HomeBloc, List<LocalAndInternationalRelationsVO>?>(
                  selector: (_, bloc) => bloc.getLocalAndInternationalRelationsList,
                  builder: (_, localAndInternationalRelationsList, __) {
                    if (localAndInternationalRelationsList == null) {
                      return const _CardImageHorizontalLoadingView(
                        height: kLocalAndInternationalRelationshipsViewHeight,
                      );
                    }
                    if (localAndInternationalRelationsList.isEmpty) {
                      return const DataEmptyWidget();
                    }

                    return CardImageHorizontalListWidget(
                      onTapImageCard: (image, description, pdfName, pdfUrl, title) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => HomeDetailsPage(
                                  image: image,
                                  description: description,
                                  pdfName: pdfName,
                                  pdfUrl: pdfUrl,
                                  title: title,
                                )));
                      },
                      title: kLocalAndInternationalRelationShipsText,
                      cardListViewHeight: kLocalAndInternationalRelationshipsViewHeight,
                      imageAndDescList: localAndInternationalRelationsList
                          .map(
                            (e) => (
                              e.url,
                              e.description,
                              e.pdfName,
                              e.pdfURL,
                              e.title,
                            ),
                          )
                          .toList(),
                      onTapViewAll: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ViewAllPage(
                            title: kLocalAndInternationalRelationShipsText,
                            viewAllPath: kLocalAndInternationalRelationsPath,
                          ),
                        ));
                      },
                    );
                  },
                ),

                const SizedBox(
                  height: kSP50x,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerLoadingView extends StatelessWidget {
  const _BannerLoadingView();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      itemBuilder: (_, index) => const Padding(
        padding: EdgeInsets.all(kSP10x),
        child: ShimmerLoadingWidget(
          height: kBannerViewHeight,
          width: double.infinity,
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
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(kSP10x),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kSP10x),
                child: CachedNetworkImage(
                  imageUrl: widget.bannerList[index].url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: kSP20x,
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

class _CardImageHorizontalLoadingView extends StatelessWidget {
  const _CardImageHorizontalLoadingView({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: kSP10x,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.only(
            right: kSP10x,
          ),
          child: ShimmerLoadingWidget(
            height: height,
            width: kShimmerLoadingViewDefaultWidth,
          ),
        ),
      ),
    );
  }
}
