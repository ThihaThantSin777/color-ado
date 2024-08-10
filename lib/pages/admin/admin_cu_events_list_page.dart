import 'package:color_ado/bloc/admin/admin_cu_events_list_bloc.dart';
import 'package:color_ado/data/vos/cu_events_vo/cu_events_vo.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/create_edit_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:color_ado/widgets/vertical_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminCUEventsListPage extends StatelessWidget {
  const AdminCUEventsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminCUEventsListBloc>(
      create: (_) => AdminCUEventsListBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreateEditWidget(
                  title: 'Create CU Events',
                  path: kCUEventsPath,
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
          title: const Text('CU Events'),
        ),
        body: Selector<AdminCUEventsListBloc, List<CUEventsVO>?>(
          selector: (_, bloc) => bloc.getCUEventList,
          builder: (context, cuEventsList, __) {
            if (cuEventsList == null) {
              return const SizedBox();
            }
            if (cuEventsList.isEmpty) {
              return const DataEmptyWidget();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: cuEventsList.length,
              itemBuilder: (_, index) => VerticalListWidget(
                title: cuEventsList[index].title,
                description: cuEventsList[index].description,
                onTapDelete: () {
                  final bloc = context.read<AdminCUEventsListBloc>();
                  showDialog(
                      context: context,
                      builder: (_) => SampleDialogWidget.twoButton(
                            title: 'Conformation',
                            content: 'Are you sure want to delete?',
                            onButtonPressed: () {
                              Navigator.of(context).pop();
                              bloc.onTapDeleteCUEvents(cuEventsList[index].id).then((_) {}).catchError((error) {
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
                        title: 'Edit CU Events',
                        path: kCUEventsPath,
                        id: cuEventsList[index].id,
                        preDescription: cuEventsList[index].description,
                        preTitle: cuEventsList[index].title,
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
