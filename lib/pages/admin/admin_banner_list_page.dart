import 'package:color_ado/bloc/admin/admin_banner_list_bloc.dart';
import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/create_edit_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:color_ado/widgets/vertical_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBannerListPage extends StatelessWidget {
  const AdminBannerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminBannerListBloc>(
      create: (_) => AdminBannerListBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreateEditWidget(
                  title: 'Create Banner',
                  isEnableImage: true,
                  path: kBannerPath,
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
          title: const Text('Banner'),
        ),
        body: Selector<AdminBannerListBloc, List<BannerVO>?>(
          selector: (_, bloc) => bloc.getBannerList,
          builder: (context, bannerList, __) {
            if (bannerList == null) {
              return const SizedBox();
            }
            if (bannerList.isEmpty) {
              return const DataEmptyWidget();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: bannerList.length,
              itemBuilder: (_, index) => VerticalListWidget(
                image: bannerList[index].url,
                id: bannerList[index].id,
                onTapDelete: () {
                  final bloc = context.read<AdminBannerListBloc>();
                  showDialog(
                      context: context,
                      builder: (_) => SampleDialogWidget.twoButton(
                            title: 'Conformation',
                            content: 'Are you sure want to delete?',
                            onButtonPressed: () {
                              Navigator.of(context).pop();

                              bloc.onTapDeleteBanner(bannerList[index].id).then((_) {}).catchError((error) {
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
                        isEnableImage: true,
                        title: 'Edit Banner',
                        preImageURL: bannerList[index].url,
                        path: kBannerPath,
                        id: bannerList[index].id,
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
