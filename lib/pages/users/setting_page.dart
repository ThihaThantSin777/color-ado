import 'package:color_ado/bloc/users/setting_bloc.dart';
import 'package:color_ado/data/vos/setting_vo/setting_vo.dart';
import 'package:color_ado/pages/admin/login_page.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/utils/image_utils.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingBloc>(
      create: (_) => SettingBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kSP20x),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage()));
                        },
                        icon: const Icon(Icons.login)),
                  ),
                  Center(
                    child: Image.asset(
                      ImageUtils.kAppLogo,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const Text(
                    'Technology University Colorado',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: kSP10x,
                  ),
                  Selector<SettingBloc, List<SettingVO>?>(
                      selector: (_, bloc) => bloc.getSettingList,
                      builder: (_, settingList, __) {
                        if (settingList == null) {
                          return const SizedBox();
                        }
                        if (settingList.isEmpty) {
                          return const DataEmptyWidget();
                        }

                        return ExpansionPanelList.radio(
                          expandedHeaderPadding: const EdgeInsets.all(8.0),
                          children: settingList.map<ExpansionPanelRadio>((SettingVO setting) {
                            return ExpansionPanelRadio(
                              value: setting.id,
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(setting.title),
                                );
                              },
                              body: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: ListTile(
                                  title: Text(setting.description),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
