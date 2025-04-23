import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/notification/presentation/notification_view_model.dart';

import '../../../config/shimmers/job_shimmer.dart';
import '../../../config/themes/app_theme.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 5,
        shadowColor: AppTheme.primaryColor.withOpacity(0.2),
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body: notificationState.isLoading && notificationState.notifications.isEmpty
          ? const JobShimmer(count: 2)
          : notificationState.notifications.isEmpty
          ? RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          ref.read(notificationViewModelProvider.notifier).resetState();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/no_notifications.png'),
            const Text(
              'No notifications available!',
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
          : ListView.builder(
        itemCount: notificationState.notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notificationState.notifications.length.toString()),
            subtitle: Text(notificationState.notifications[index].length.toString()),
          );
        },
      ),
    );
  }
}
