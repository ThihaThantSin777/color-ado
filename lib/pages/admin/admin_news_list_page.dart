import 'package:color_ado/bloc/admin/admin_news_list_bloc.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/create_edit_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:color_ado/widgets/vertical_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminNewsListPage extends StatelessWidget {
  const AdminNewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminNewsListBloc>(
      create: (_) => AdminNewsListBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreateEditWidget(
                  title: 'Create News',
                  path: kNewsPath,
                  isEnableDescription: true,
                  isEnableTitle: true,
                  isEnableImage: true,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.create,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('News'),
        ),
        body: Selector<AdminNewsListBloc, List<NewsVO>?>(
          selector: (_, bloc) => bloc.getNewsList,
          builder: (context, newsList, __) {
            if (newsList == null) {
              return const SizedBox();
            }
            if (newsList.isEmpty) {
              return const DataEmptyWidget();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: newsList.length,
              itemBuilder: (_, index) => VerticalListWidget(
                title: newsList[index].title,
                description: newsList[index].description,
                image: newsList[index].image,
                id: newsList[index].id,
                onTapDelete: () {
                  final bloc = context.read<AdminNewsListBloc>();
                  showDialog(
                      context: context,
                      builder: (_) => SampleDialogWidget.twoButton(
                            title: 'Conformation',
                            content: 'Are you sure want to delete?',
                            onButtonPressed: () {
                              Navigator.of(context).pop();
                              bloc.onTapDeleteNews(newsList[index].id).then((_) {}).catchError((error) {
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (_) => SampleDialogWidget(
                                          title: 'Error',
                                          content: error.toString(),
                                          buttonText: 'OK',
                                          onButtonPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ));
                              });
                            },
                            buttonText: 'Yes',
                            onSecondaryButtonPressed: () {
                              Navigator.of(context).pop();
                            },
                            secondaryButtonText: 'No',
                          ));
                },
                onTapEdit: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CreateEditWidget(
                        title: 'Edit News',
                        path: kNewsPath,
                        id: newsList[index].id,
                        preDescription: newsList[index].description,
                        preTitle: newsList[index].title,
                        preImageURL: newsList[index].image,
                        isEnableDescription: true,
                        isEnableTitle: true,
                        isEnableImage: true,
                      ),
                    ),
                  );
                },
              ),
              separatorBuilder: (_, index) => const Divider(
                thickness: 1.2,
              ),
            );
          },
        ),
      ),
    );
  }
}
