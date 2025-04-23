import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/config/themes/app_theme.dart';
import 'package:yaallo/core/common/messages/show_snackbar.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:yaallo/core/common/widgets/custom_text_field.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/network/http_service.dart';

class NewChatView extends ConsumerStatefulWidget {
  const NewChatView({super.key});

  @override
  ConsumerState createState() => _NewChatViewState();
}

class _NewChatViewState extends ConsumerState<NewChatView> {
  final controller = TextEditingController();
  final node = FocusNode();
  final key = GlobalKey();

  List<Map<String, dynamic>> userList = [];
  Timer? _debounce;
  bool isLoading = false;

  void _showSendMessageDialog(Map<String, dynamic> user) {
    final messageController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Send Message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: messageController,
                node: FocusNode(), validator: (value) { return null; },
                hintText: 'Message',
              ),
            ],
          ),
          actions: [
            CustomButton(
              onPressed: () async {
                ref.read(navigationServiceProvider).goBack();
                final message = messageController.text.trim();
                if (message.isNotEmpty) {
                  final dio = ref.read(httpServiceProvider(ApiEndpoints.oysterURL));
                  final response = await dio.post(
                    '/insert/',
                    data: {
                      'uid1': ref.read(navViewModelProvider).userData!['hash'],
                      'uid2': user['_id'],
                      'mess': message,
                      'userId': ref.read(navViewModelProvider).userData!['hash'],
                    },
                    options: Options(
                      headers: {
                        'Accept': '*/*',
                        'Authorization': 'Bearer ${ref.read(navViewModelProvider).userData!['accessToken']}',
                      },
                      contentType: 'application/x-www-form-urlencoded',
                    ),
                  );
                  if (response.statusCode == 200) {
                    showSnackBar(ref: ref, message: 'Message Sent Successfully!');
                  } else {
                    showSnackBar(ref: ref, message: 'Failed to send message!', error: true);
                  }
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          title: const Text(
            'New Chat',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Form(
                key: key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  cursorColor: AppTheme.primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintText: 'Search name or email',
                    contentPadding:
                    const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.primaryColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.errorColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIcon: const Icon(
                      Iconsax.search_normal,
                      size: 20,
                    ),
                    prefixIconColor: WidgetStateColor.resolveWith(
                          (states) {
                        if (states.contains(WidgetState.focused)) {
                          return AppTheme.primaryColor;
                        }
                        return Colors.grey;
                      },
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  controller: controller,
                  focusNode: node,
                  validator: (value) {
                    return null;
                  },
                  onTapOutside: (event) {
                    node.unfocus();
                  },
                  onChanged: (value) {
                    setState(() {
                      isLoading = true;
                    });
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(seconds: 2), () async {
                      final dio = ref.read(httpServiceProvider(ApiEndpoints.oysterURL));
                      final response = await dio.post(
                        '/searchnew',
                        data: {'search': value},
                        options: Options(
                          headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                            'Accept': '*/*',
                          },
                        ),
                      );
                      setState(() {
                        userList = List<Map<String, dynamic>>.from(response.data);
                        isLoading = false;
                      });
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              )
                  : ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${userList[index]['fname']} ${userList[index]['lname']}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      userList[index]['email'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    onTap: () {
                      _showSendMessageDialog(userList[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
