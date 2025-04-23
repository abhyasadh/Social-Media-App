import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/config/themes/app_theme.dart';

import 'chat_detail_page.dart';

class MessagesWidget extends ConsumerWidget {
  final List<dynamic> messages;
  final List<dynamic> users;

  const MessagesWidget({super.key, required this.messages, required this.users});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, dynamic>> combinedData = [];
    for (int i = 0; i < min(messages.length, users.length); i++) {
      var message = messages[i];
      var user = users[i];
      combinedData.add({
        ...message,
        'name': '${user['fname']} ${user['lname'] ?? ''}',
      });
    }

    combinedData.sort((a, b) => b['lastupdate'].compareTo(a['lastupdate']));

    return ListView.separated(
      itemCount: combinedData.length,
      itemBuilder: (context, index) {
        var message = combinedData[index];
        return ListTile(
          contentPadding: const EdgeInsets.all(14),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(message['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, ),),
          ),
          subtitle: Text('${message['lastmess']}...'),
          trailing: Text(
            _formatTimeDifference(message['lastupdate']),
            style: const TextStyle(color: Colors.grey),
          ),
          onTap: () {
            ref.read(navigationServiceProvider).navigateTo(page: ChatDetailPage(chatDetails: message));
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(color: AppTheme.primaryColor, height: 2,),
    );
  }

  String _formatTimeDifference(int timestamp) {
    final now = DateTime.now();
    final messageTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(messageTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
