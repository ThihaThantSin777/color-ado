import 'package:color_ado/bloc/users/notification_bloc.dart';
import 'package:color_ado/data/vos/notification_vo/notification_vo.dart';
import 'package:color_ado/pages/users/cu_events_details_page.dart';
import 'package:color_ado/pages/users/news_details_page.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/widgets/data_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as time_ago;

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationBloc>(
      create: (_) => NotificationBloc(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Notification'),
          ),
          body: Selector<NotificationBloc, List<NotificationVO>?>(
              selector: (_, bloc) => bloc.getNotificationList,
              builder: (context, notificationList, __) {
                if (notificationList == null) {
                  return const SizedBox.shrink();
                }
                if (notificationList.isEmpty) {
                  return const DataEmptyWidget();
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: notificationList.length,
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        final type = notificationList[index].payload;
                        final dataSplit = type.split("|");
                        if (dataSplit.firstOrNull == kCUEventsPath) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CUEventsDetailsPage(
                              title: dataSplit[1],
                              description: dataSplit.lastOrNull ?? '',
                            ),
                          ));
                        }

                        if (dataSplit.firstOrNull == kNewsPath) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => NewsDetailsPage(
                              image: dataSplit.lastOrNull ?? '',
                              title: dataSplit[1],
                              description: dataSplit[2],
                            ),
                          ));
                        }
                      },
                      child: _NotificationView(
                        notification: notificationList[index],
                      ),
                    );
                  },
                );
              })),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView({
    required this.notification,
  });

  final NotificationVO notification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 23,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    notification.notificationTitle,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(time_ago.format(DateTime.parse(notification.createdAt))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
