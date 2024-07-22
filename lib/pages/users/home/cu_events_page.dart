import 'package:color_ado/bloc/users/cu_events_bloc.dart';
import 'package:color_ado/data/vos/cu_events_vo/cu_events_vo.dart';
import 'package:color_ado/pages/users/home/cu_events_details_page.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/utils/string_extensions.dart';
import 'package:color_ado/widgets/blue_card_container_widget.dart';
import 'package:color_ado/widgets/custom_date_picker_widget.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CUEventsPage extends StatelessWidget {
  const CUEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CUEventsBloc>(
      create: (_) => CUEventsBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kSP20x,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: kSP20x,
                ),
                child: Text(
                  'CU Events',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: kFontSize22x,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: kSP10x,
              ),
              Builder(builder: (context) {
                return CustomDatePickerWidget(
                  onTapDate: (date) {
                    final bloc = context.read<CUEventsBloc>();
                    bloc.onTapDateSelect(date);
                  },
                );
              }),
              const SizedBox(
                height: kSP10x,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kSP20x,
                ),
                child: Selector<CUEventsBloc, int?>(
                    selector: (_, bloc) => bloc.getCUEventsCountByDate,
                    builder: (_, count, __) {
                      final foundEvents = '$count event'.addS(count ?? 0);
                      if (count == 0) {
                        return const Text(
                          'No Events Found',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            fontSize: kFontSize16x,
                          ),
                        );
                      }
                      return Text(
                        '$foundEvents Found',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: kFontSize16x,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: kSP10x,
              ),
              Selector<CUEventsBloc, List<CUEventsVO>?>(
                  selector: (_, bloc) => bloc.getCUEvents,
                  builder: (_, cuEvents, __) {
                    if (cuEvents == null) {
                      return const SizedBox();
                    }
                    if (cuEvents.isEmpty) {
                      return const DataEmptyWidget();
                    }
                    return Flexible(
                        child: ListView.separated(
                      padding: const EdgeInsets.all(kSP20x),
                      separatorBuilder: (_, bloc) => const SizedBox(
                        height: kSP20x,
                      ),
                      itemCount: cuEvents.length,
                      itemBuilder: (_, index) {
                        final newData = cuEvents[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CUEventsDetailsPage(
                                  description: newData.description,
                                  title: newData.title,
                                ),
                              ),
                            );
                          },
                          child: BlueCardContainerWidget(
                            title: newData.title,
                            description: newData.description,
                            createdAt: newData.createdAt,
                          ),
                        );
                      },
                    ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
