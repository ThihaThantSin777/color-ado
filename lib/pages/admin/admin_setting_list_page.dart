import 'package:color_ado/bloc/admin/admin_setting_list_bloc.dart';
import 'package:color_ado/data/vos/setting_vo/setting_vo.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/create_edit_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:color_ado/widgets/vertical_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminSettingListPage extends StatelessWidget {
  const AdminSettingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminSettingListBloc>(
      create: (_) => AdminSettingListBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreateEditWidget(
                  title: 'Create Setting',
                  isEnableTitle: true,
                  isEnableDescription: true,
                  path: kSettingPath,
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
          title: const Text('Settings'),
        ),
        body: Selector<AdminSettingListBloc, List<SettingVO>?>(
          selector: (_, bloc) => bloc.getSettingList,
          builder: (_, settingList, __) {
            if (settingList == null) {
              return const SizedBox();
            }
            if (settingList.isEmpty) {
              return const DataEmptyWidget();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: settingList.length,
              itemBuilder: (_, index) => VerticalListWidget(
                title: settingList[index].title,
                description: settingList[index].description,
                id: settingList[index].id,
                onTapDelete: () {
                  showDialog(
                      context: context,
                      builder: (_) => SampleDialogWidget.twoButton(
                            title: 'Conformation',
                            content: 'Are you sure want to delete?',
                            onButtonPressed: () {
                              Navigator.of(context).pop();
                              final bloc = context.read<AdminSettingListBloc>();
                              bloc.onTapDeleteSetting(settingList[index].id).then((_) {}).catchError((error) {
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
                        isEnableTitle: true,
                        isEnableDescription: true,
                        title: 'Edit Banner',
                        preTitle: settingList[index].title,
                        preDescription: settingList[index].description,
                        path: kSettingPath,
                        id: settingList[index].id,
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
