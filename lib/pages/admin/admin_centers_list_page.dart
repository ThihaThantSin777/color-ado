import 'package:color_ado/bloc/admin/admin_centers_list_bloc.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/create_edit_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:color_ado/widgets/vertical_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminCentersListPage extends StatelessWidget {
  const AdminCentersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminCentersListBloc>(
      create: (_) => AdminCentersListBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreateEditWidget(
                  title: 'Create Centers',
                  path: kCentersPath,
                  isEnableImage: true,
                  isEnableDescription: true,
                  isEnableTitle: true,
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
          title: const Text('Centers'),
        ),
        body: Selector<AdminCentersListBloc, List<CentersVO>?>(
          selector: (_, bloc) => bloc.getCentersList,
          builder: (_, centersList, __) {
            if (centersList == null) {
              return const SizedBox();
            }
            if (centersList.isEmpty) {
              return const DataEmptyWidget();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: centersList.length,
              itemBuilder: (_, index) => VerticalListWidget(
                image: centersList[index].url,
                title: centersList[index].title,
                description: centersList[index].description,
                id: centersList[index].id,
                onTapDelete: () {
                  showDialog(
                      context: context,
                      builder: (_) => SampleDialogWidget.twoButton(
                            title: 'Conformation',
                            content: 'Are you sure want to delete?',
                            onButtonPressed: () {
                              Navigator.of(context).pop();
                              final bloc = context.read<AdminCentersListBloc>();
                              bloc.onTapDeleteCenters(centersList[index].id).then((_) {}).catchError((error) {
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
                        title: 'Edit Centers',
                        preImageURL: centersList[index].url,
                        path: kCentersPath,
                        id: centersList[index].id,
                        preDescription: centersList[index].description,
                        preTitle: centersList[index].title,
                        isEnableImage: true,
                        isEnableDescription: true,
                        isEnableTitle: true,
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
