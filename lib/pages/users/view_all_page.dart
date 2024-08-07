import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/bloc/users/view_all_bloc.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/pages/users/home_details_page.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllPage extends StatelessWidget {
  const ViewAllPage({
    super.key,
    required this.title,
    required this.viewAllPath,
  });

  final String viewAllPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewAllBloc>(
      create: (_) => ViewAllBloc(
        path: viewAllPath,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(kSP10x),
          child: switch (viewAllPath) {
            kFacilitiesPath => const _FacilitiesViewAllVerticalListView(),
            kCentersPath => const _CentersViewAllVerticalListView(),
            kLocalAndInternationalRelationsPath => const _LocalAndInternationalRelationshipsView(),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class _FacilitiesViewAllVerticalListView extends StatelessWidget {
  const _FacilitiesViewAllVerticalListView();

  @override
  Widget build(BuildContext context) {
    return Selector<ViewAllBloc, List<FacilitiesVO>?>(
        selector: (_, bloc) => bloc.getFacilitiesList,
        builder: (_, facilitiesList, __) {
          if (facilitiesList == null) {
            return const _ViewAllLoadingView();
          }
          if (facilitiesList.isEmpty) {
            return const DataEmptyWidget();
          }

          return ListView.builder(
            itemCount: facilitiesList.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HomeDetailsPage(
                          image: facilitiesList[index].url,
                          description: facilitiesList[index].description,
                        )));
              },
              child: Card(
                margin: const EdgeInsets.only(
                  bottom: kSP20x,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    kSP10x,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: facilitiesList[index].url,
                    height: kCardImageHorizontalListHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _CentersViewAllVerticalListView extends StatelessWidget {
  const _CentersViewAllVerticalListView();

  @override
  Widget build(BuildContext context) {
    return Selector<ViewAllBloc, List<CentersVO>?>(
        selector: (_, bloc) => bloc.getCentersList,
        builder: (_, centersList, __) {
          if (centersList == null) {
            return const _ViewAllLoadingView();
          }
          if (centersList.isEmpty) {
            return const DataEmptyWidget();
          }

          return ListView.builder(
            itemCount: centersList.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HomeDetailsPage(
                          image: centersList[index].url,
                          description: centersList[index].description,
                        )));
              },
              child: Card(
                margin: const EdgeInsets.only(
                  bottom: kSP20x,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    kSP10x,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: centersList[index].url,
                    height: kCardImageHorizontalListHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _LocalAndInternationalRelationshipsView extends StatelessWidget {
  const _LocalAndInternationalRelationshipsView();

  @override
  Widget build(BuildContext context) {
    return Selector<ViewAllBloc, List<LocalAndInternationalRelationsVO>?>(
        selector: (_, bloc) => bloc.getLocalAndInternationalRelationsList,
        builder: (_, localAndInternationalRelationsList, __) {
          if (localAndInternationalRelationsList == null) {
            return const _ViewAllLoadingView();
          }
          if (localAndInternationalRelationsList.isEmpty) {
            return const DataEmptyWidget();
          }

          return ListView.builder(
            itemCount: localAndInternationalRelationsList.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HomeDetailsPage(
                          image: localAndInternationalRelationsList[index].url,
                          description: localAndInternationalRelationsList[index].description,
                        )));
              },
              child: Card(
                margin: const EdgeInsets.only(
                  bottom: kSP20x,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    kSP10x,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: localAndInternationalRelationsList[index].url,
                    height: kCardImageHorizontalListHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _ViewAllLoadingView extends StatelessWidget {
  const _ViewAllLoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) => const Padding(
        padding: EdgeInsets.only(bottom: kSP10x),
        child: ShimmerLoadingWidget(
          height: kCardImageHorizontalListHeight,
          width: double.infinity,
        ),
      ),
    );
  }
}
