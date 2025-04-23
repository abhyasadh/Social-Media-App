import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/constants/api_endpoints.dart';
import 'package:yaallo/core/network/http_service.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/message/presentation/message_view_model.dart';

import '../../../../config/themes/app_theme.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> chatDetails;

  const ChatDetailPage({super.key, required this.chatDetails});

  @override
  ConsumerState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final scrollController = ScrollController();

  Map<String, dynamic>? chatData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          title: Text(
            widget.chatDetails['name'],
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _fetchChatData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && chatData == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              chatData = snapshot.data!['value']; // Store chat data
              final chats = chatData!['chats'];
      
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
      
              return Padding(
                padding: const EdgeInsets.only(bottom: 86),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final message = chat['mess'];
                    final timestamp = chat['ti'];
                    final formattedTime = _formatTimeDifference(timestamp);
                    final side = chat['seBy'] ==
                        ref.read(navViewModelProvider).userData!['hash']
                        ? true
                        : false;
      
                    return Row(
                      mainAxisAlignment:
                      side ? MainAxisAlignment.end : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (side)
                          Text(formattedTime,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          margin: EdgeInsets.only(
                              top: 10, left: side ? 4 : 14, right: side ? 14 : 4),
                          decoration: BoxDecoration(
                            color: chat['seBy'] ==
                                ref.read(navViewModelProvider).userData!['hash']
                                ? AppTheme.primaryColor
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(message,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        if (!side)
                          Text(formattedTime,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10)),
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              hintText: 'Type a message...',
              hintStyle: const TextStyle(color: AppTheme.primaryColor),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppTheme.primaryColor),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppTheme.primaryColor),
                  borderRadius: BorderRadius.circular(12)),
              labelStyle: const TextStyle(color: AppTheme.primaryColor),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 50,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send_rounded),
                onPressed: () async {
                  if (controller.text.isNotEmpty && chatData != null) {
                    final dio =
                    ref.read(httpServiceProvider(ApiEndpoints.oysterURL));
                    await dio
                        .post(
                      'send/',
                      data: {
                        'uid1': ref.read(navViewModelProvider).userData!['hash'],
                        'uid2': widget.chatDetails['uid2'] == ref.read(navViewModelProvider).userData!['hash']
                            ? widget.chatDetails['uid1']
                            : widget.chatDetails['uid2'],
                        'mess': controller.text,
                        'ty': 1,
                        'code': widget.chatDetails['_id'],
                        'uno': ref.read(navViewModelProvider).userData!['hash'] == widget.chatDetails['uid1'] ? 1 : 2,
                      },
                      options: Options(
                        headers: {
                          'Content-Type': 'application/x-www-form-urlencoded',
                          'Accept': '*/*',
                        },
                      ),
                    )
                        .then((value) {
                      ref.read(messageViewModelProvider.notifier).getMessages();
                      setState(() {
                        _fetchChatData();
                        controller.clear();
                      });
                    });
                  }
                },
              ),
            ),
            onTapOutside: (e) {
              focusNode.unfocus();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchChatData() async {
    final dio = ref.read(httpServiceProvider(ApiEndpoints.oysterURL));
    final response = await dio.post(
      ApiEndpoints.getPosts,
      data: {
        'chatId': widget.chatDetails['_id'],
        'uid': 1,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': '*/*',
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load chat data');
    }
  }

  String _formatTimeDifference(int timestamp) {
    final now = DateTime.now();
    final messageTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(messageTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  @override
  void dispose() {
    scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }
}
