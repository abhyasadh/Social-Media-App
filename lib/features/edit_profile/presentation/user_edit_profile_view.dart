import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/core/common/messages/alert_dialogue.dart';

import '../../../../../config/themes/app_theme.dart';
import '../../../../../core/common/provider/image_picker_util.dart';
import '../../../../../core/common/widgets/custom_button.dart';
import '../../../../../core/common/widgets/custom_text_field.dart';
import '../../bottom_navigation/nav_view_model.dart';
import 'edit_profile_view_model.dart';

class UserEditProfileView extends ConsumerStatefulWidget {
  const UserEditProfileView({super.key});

  @override
  ConsumerState createState() => _UserEditProfileViewState();
}

class _UserEditProfileViewState extends ConsumerState<UserEditProfileView> {
  final nameKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  final nameFocusNode = FocusNode();

  final surnameKey = GlobalKey<FormState>();
  late TextEditingController surnameController;
  final surnameFocusNode = FocusNode();

  final aboutKey = GlobalKey<FormState>();
  late TextEditingController aboutController;
  final aboutFocusNode = FocusNode();

  Either<File?, String?>? _img;

  @override
  void initState() {
    super.initState();
    final state = ref.read(navViewModelProvider);

    nameController =
        TextEditingController(text: state.userData?['fname'] ?? '');
    surnameController =
        TextEditingController(text: state.userData?['lname'] ?? '');
    aboutController =
        TextEditingController(text: state.userData?['info'] ?? '');
    if (state.userData?['profile_pic'] != null) {
      _img = Right(state.userData?['profile_pic']);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    aboutController.dispose();

    nameFocusNode.dispose();
    surnameFocusNode.dispose();
    aboutFocusNode.dispose();

    super.dispose();
  }

  void _onImagePicked(File? image) {
    setState(() {
      if (image != null) {
        _img = Left(image);
        ref.read(editProfileViewModelProvider.notifier).uploadImage(image);
      }
    });
  }

  void _onSaveChanges() {
    bool validated = true;
    if (!nameKey.currentState!.validate()) {
      validated = false;
    }
    if (!surnameKey.currentState!.validate()) {
      validated = false;
    }
    if (!aboutKey.currentState!.validate()) {
      validated = false;
    }
    if (validated) {
      ref.read(editProfileViewModelProvider.notifier).updateUser(
          image: _img,
          firstName: nameController.text,
          lastName: surnameController.text,
          info: aboutController.text,
          ref: ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editProfileViewModelProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          title: const Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showAlertDialogue(
                      message: 'Are you sure you want to delete your account?',
                      context: context,
                      ref: ref,
                      onConfirm: () {
                        ref.read(editProfileViewModelProvider.notifier).deleteAccount(ref);
                      },
                  );
                },
                icon: const Icon(
                  Iconsax.trash,
                  size: 30,
                )),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    ImagePickerUtil.showImagePickerOptions(
                      context: context,
                      ref: ref,
                      onImagePicked: _onImagePicked,
                    );
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 116,
                        width: 116,
                        child: _img != null
                            ? CircleAvatar(
                                radius: 58,
                                backgroundImage: _img?.fold(
                                  (l) => FileImage(l!),
                                  (r) => NetworkImage(
                                          "https://media.yaallo.com/upload/img/$r")
                                      as ImageProvider,
                                ),
                              )
                            : Container(
                                width: 116,
                                height: 116,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  borderRadius: BorderRadius.circular(58),
                                  border: Border.all(
                                    color: AppTheme.primaryColor,
                                    width: 4,
                                  ),
                                ),
                                child: const Icon(
                                  Iconsax.user,
                                  size: 58,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 34,
                          height: 34,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: Colors.grey,
                          ),
                          child: const Icon(Iconsax.camera,
                              size: 20, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: nameKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Expanded(
                        child: CustomTextField(
                          hintText: 'First Name',
                          controller: nameController,
                          node: nameFocusNode,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name can\'t be empty!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Form(
                      key: surnameKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Expanded(
                        child: CustomTextField(
                          hintText: 'Last Name',
                          controller: surnameController,
                          node: surnameFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name can\'t be empty!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
                Form(
                  key: aboutKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: aboutController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (value) {
                      return null;
                    },
                    focusNode: aboutFocusNode,
                    maxLines: null,
                    minLines: 4,
                    decoration: InputDecoration(
                      labelText: 'About',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppTheme.primaryColor),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppTheme.primaryColor),
                          borderRadius: BorderRadius.circular(30)),
                      labelStyle: const TextStyle(color: AppTheme.primaryColor),
                    ),
                    onTapOutside: (e) {
                      aboutFocusNode.unfocus();
                    },
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                CustomButton(
                  onPressed: _onSaveChanges,
                  child: state.isLoading
                      ? const ButtonCircularProgressIndicator()
                      : const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
