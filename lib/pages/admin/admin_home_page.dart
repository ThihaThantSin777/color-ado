import 'package:color_ado/bloc/admin/admin_home_bloc.dart';
import 'package:color_ado/pages/admin/admin_banner_list_page.dart';
import 'package:color_ado/pages/admin/admin_centers_list_page.dart';
import 'package:color_ado/pages/admin/admin_cu_events_list_page.dart';
import 'package:color_ado/pages/admin/admin_facilities_list_page.dart';
import 'package:color_ado/pages/admin/admin_local_and_international_relations_list_page.dart';
import 'package:color_ado/pages/admin/admin_news_list_page.dart';
import 'package:color_ado/pages/admin/admin_setting_list_page.dart';
import 'package:color_ado/pages/admin/create_user_page.dart';
import 'package:color_ado/pages/users/index_page.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/utils/enums.dart';
import 'package:color_ado/widgets/card_item_widget.dart';
import 'package:color_ado/widgets/loadin_dialog_widget.dart';
import 'package:color_ado/widgets/loading_state_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({
    super.key,
    required this.userEmail,
  });

  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminHomeBloc>(
      create: (_) => AdminHomeBloc(
        email: userEmail,
      ),
      child: Scaffold(
        body: SafeArea(
            child: Selector<AdminHomeBloc, LoadingState>(
                selector: (_, bloc) => bloc.getLoadingState,
                builder: (_, loadingState, __) {
                  return LoadingStateWidget<AdminHomeBloc>(
                    loadingState: loadingState,
                    widgetForSuccessState: const SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _WelcomeUserAndLogoutView(),
                          SizedBox(
                            height: 30,
                          ),
                          _AdminSelectionCardView(),
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}

class _AdminSelectionCardView extends StatelessWidget {
  const _AdminSelectionCardView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            children: [
              CardItemWidget(
                iconData: Icons.image,
                title: 'Banner',
                onTapCard: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminBannerListPage()));
                },
              ),
              CardItemWidget(
                iconData: Icons.center_focus_weak,
                title: 'Centers',
                onTapCard: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminCentersListPage()));
                },
              ),
              CardItemWidget(
                iconData: Icons.event,
                title: 'CU Events',
                onTapCard: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminCUEventsListPage()));
                },
              ),
              CardItemWidget(
                iconData: Icons.fact_check,
                title: 'Facilities',
                onTapCard: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminFacilitiesListPage()));
                },
              ),
              CardItemWidget(
                iconData: Icons.language,
                title: 'Local And International Relations',
                onTapCard: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminLocalAndInternationalRelationsListPage()));
                },
              ),
              CardItemWidget(
                iconData: Icons.newspaper,
                title: 'News',
                onTapCard: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminNewsListPage()));
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          _OneRowSettingView(onTapCard: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminSettingListPage()));
          }),
        ],
      ),
    );
  }
}

class _OneRowSettingView extends StatelessWidget {
  const _OneRowSettingView({
    required this.onTapCard,
  });

  final Function onTapCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapCard(),
      child: const SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.settings,
                  color: Colors.blue,
                  size: 40,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Setting',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: kFontSize16x,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeUserAndLogoutView extends StatelessWidget {
  const _WelcomeUserAndLogoutView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Selector<AdminHomeBloc, String?>(
              selector: (_, bloc) => bloc.getUserName,
              builder: (_, userName, __) {
                return Text(
                  'Welcome, $userName',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                );
              }),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateUserPage()));
            },
            child: const Icon(
              Icons.person_add,
              color: Colors.black,
              size: 23,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: () {
              final bloc = context.read<AdminHomeBloc>();
              showDialog(context: context, builder: (_) => const LoadingDialog());
              bloc.onTapLogout().then((value) {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const IndexPage(),
                  ),
                  (route) => false,
                );
              }).catchError((error) {
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
            child: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 23,
            ),
          ),
        ],
      ),
    );
  }
}
