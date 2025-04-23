import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/features/message/presentation/message_view_model.dart';
import 'package:yaallo/features/message/presentation/widgets/messages_widget.dart';
import 'package:yaallo/features/message/presentation/widgets/new_chat_detail.dart';

import '../../../config/shimmers/job_shimmer.dart';
import '../../../config/themes/app_theme.dart';

class MessageView extends ConsumerWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageState = ref.watch(messageViewModelProvider);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: const SizedBox(),
          leadingWidth: 8,
          elevation: 5,
          backgroundColor: AppTheme.primaryColor,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          title: const Text(
            'Messages',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: messageState.isLoading && messageState.messages.isEmpty
            ? const JobShimmer(count: 2)
            : messageState.messages.isEmpty
                ? RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    onRefresh: () async {
                      ref
                          .read(messageViewModelProvider.notifier)
                          .resetState();
                    },
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/no_messages.png'),
                            const Text(
                              'No new messages.\nChat with your fans below!',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    onRefresh: () async {
                      ref
                          .read(messageViewModelProvider.notifier)
                          .resetState();
                    },
                    child: MessagesWidget(
                      messages: messageState.messages[0],
                      users: messageState.messages[1],
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(navigationServiceProvider).navigateTo(page: const NewChatView());
          },
          backgroundColor: AppTheme.primaryColor,
          child: const Icon(Icons.add),
        ));
  }
}
