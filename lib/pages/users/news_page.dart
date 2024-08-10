import 'package:color_ado/bloc/users/news_bloc.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/pages/users/news_details_page.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/shimmer_loading_widget.dart';
import 'package:color_ado/widgets/vertical_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsBloc>(
      create: (_) => NewsBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Selector<NewsBloc, List<NewsVO>?>(
              selector: (_, bloc) => bloc.getNews,
              builder: (_, news, __) {
                if (news == null) {
                  return const _NewsLoadingView();
                }
                if (news.isEmpty) {
                  return const DataEmptyWidget();
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(kSP20x),
                  separatorBuilder: (_, bloc) => const SizedBox(
                    height: kSP20x,
                  ),
                  itemCount: news.length,
                  itemBuilder: (_, index) {
                    final newData = news[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => NewsDetailsPage(
                              description: newData.description,
                              title: newData.title,
                              image: newData.image,
                            ),
                          ),
                        );
                      },
                      child: VerticalListWidget(
                        title: newData.title,
                        description: newData.description,
                        image: newData.image,
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}

class _NewsLoadingView extends StatelessWidget {
  const _NewsLoadingView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kSP20x),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(4, (index) {
            return const Padding(
              padding: EdgeInsets.only(bottom: kSP20x),
              child: ShimmerLoadingWidget(height: kBlueCardContainerHeight, width: double.infinity),
            );
          }).toList(),
        ),
      ),
    );
  }
}
