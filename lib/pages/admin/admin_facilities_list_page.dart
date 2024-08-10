import 'package:color_ado/bloc/admin/admin_facilities_list_bloc.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/create_edit_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:color_ado/widgets/vertical_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminFacilitiesListPage extends StatelessWidget {
  const AdminFacilitiesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminFacilitiesListBloc>(
      create: (_) => AdminFacilitiesListBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreateEditWidget(
                  title: 'Create Facilities',
                  path: kFacilitiesPath,
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
          title: const Text('Facilities'),
        ),
        body: Selector<AdminFacilitiesListBloc, List<FacilitiesVO>?>(
          selector: (_, bloc) => bloc.getFacilitiesList,
          builder: (context, facilitiesList, __) {
            if (facilitiesList == null) {
              return const SizedBox();
            }
            if (facilitiesList.isEmpty) {
              return const DataEmptyWidget();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: facilitiesList.length,
              itemBuilder: (_, index) => VerticalListWidget(
                image: facilitiesList[index].url,
                title: facilitiesList[index].title,
                description: facilitiesList[index].description,
                onTapDelete: () {
                  final bloc = context.read<AdminFacilitiesListBloc>();
                  showDialog(
                      context: context,
                      builder: (_) => SampleDialogWidget.twoButton(
                            title: 'Conformation',
                            content: 'Are you sure want to delete?',
                            onButtonPressed: () {
                              Navigator.of(context).pop();

                              bloc.onTapDeleteFacilities(facilitiesList[index].id).then((_) {}).catchError((error) {
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
                        title: 'Edit Facilities',
                        preImageURL: facilitiesList[index].url,
                        path: kFacilitiesPath,
                        id: facilitiesList[index].id,
                        preDescription: facilitiesList[index].description,
                        prePDFName: facilitiesList[index].pdfName,
                        prePDFurl: facilitiesList[index].pdfURL,
                        preTitle: facilitiesList[index].title,
                        isEnableUploadPDF: true,
                        isEnablePDFName: true,
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
