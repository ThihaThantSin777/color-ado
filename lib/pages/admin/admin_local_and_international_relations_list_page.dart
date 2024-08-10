import 'package:color_ado/bloc/admin/admin_local_and_international_relations_list_bloc.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/create_edit_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:color_ado/widgets/vertical_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminLocalAndInternationalRelationsListPage extends StatelessWidget {
  const AdminLocalAndInternationalRelationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminLocalAndInternationalRelationsListBloc>(
      create: (_) => AdminLocalAndInternationalRelationsListBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreateEditWidget(
                  title: 'Create Local And International Relations',
                  path: kLocalAndInternationalRelationsPath,
                  isEnableImage: true,
                  isEnableDescription: true,
                  isEnableTitle: true,
                  isEnablePDFName: true,
                  isEnableUploadPDF: true,
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
          title: const Text('Local And International Relations'),
        ),
        body: Selector<AdminLocalAndInternationalRelationsListBloc, List<LocalAndInternationalRelationsVO>?>(
          selector: (_, bloc) => bloc.getLocalAndInternationalRelationList,
          builder: (context, list, __) {
            if (list == null) {
              return const SizedBox();
            }
            if (list.isEmpty) {
              return const DataEmptyWidget();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: list.length,
              itemBuilder: (_, index) => VerticalListWidget(
                image: list[index].url,
                title: list[index].title,
                description: list[index].description,
                onTapDelete: () {
                  final bloc = context.read<AdminLocalAndInternationalRelationsListBloc>();
                  showDialog(
                      context: context,
                      builder: (_) => SampleDialogWidget.twoButton(
                            title: 'Conformation',
                            content: 'Are you sure want to delete?',
                            onButtonPressed: () {
                              Navigator.of(context).pop();
                              bloc.onTapDeleteLocalAndInternationalRelations(list[index].id).then((_) {}).catchError((error) {
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
                        title: 'Edit Local and International Relations',
                        preImageURL: list[index].url,
                        path: kLocalAndInternationalRelationsPath,
                        id: list[index].id,
                        preDescription: list[index].description,
                        prePDFName: list[index].pdfName,
                        prePDFurl: list[index].pdfURL,
                        preTitle: list[index].title,
                        isEnableImage: true,
                        isEnableDescription: true,
                        isEnableTitle: true,
                        isEnableUploadPDF: true,
                        isEnablePDFName: true,
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
