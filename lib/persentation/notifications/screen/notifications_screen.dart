import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/persentation/notifications/cubit/notification_cubit.dart';
import 'package:flutter_shop_store/shared/components/loading.dart';
import 'package:flutter_shop_store/shared/components/network_disconnected.dart';

import '../widget/notification_Item.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationData = BlocProvider.of<NotificationCubit>(context);
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationsLoading) {
          return const Center(
            child: CustomLoading(),
          );
        } else if (state is NotificationsError) {
          return NetworkDisconnected(
            onPress: () {
              BlocProvider.of<NotificationCubit>(context)
                  .getNotificationsData();
            },
          );
        } else {
          return RefreshIndicator(
            child: Container(
              margin: const EdgeInsets.only(left: 8.0),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 16.0,
                    offset: Offset(0.0, 1.0),
                  )
                ],
              ),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) =>
                    NotificationItem(
                  model: notificationData
                      .notificationsModel.notificationData[index],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10.0),
                itemCount:
                    notificationData.notificationsModel.notificationData.length,
              ),
            ),
            onRefresh: () async {
              await Future.wait([
                BlocProvider.of<NotificationCubit>(context)
                    .getNotificationsData()
              ]);
            },
          );
        }
      },
    );
  }
}
