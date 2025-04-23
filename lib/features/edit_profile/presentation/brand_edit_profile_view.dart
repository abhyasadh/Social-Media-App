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

class BrandEditProfileView extends ConsumerStatefulWidget {
  const BrandEditProfileView({super.key});

  @override
  ConsumerState createState() => _BrandEditProfileViewState();
}

class _BrandEditProfileViewState extends ConsumerState<BrandEditProfileView> {
  final brandNameKey = GlobalKey<FormState>();
  late TextEditingController brandNameController;
  final brandNameFocusNode = FocusNode();

  final nameKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  final nameFocusNode = FocusNode();

  final titleKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  final titleFocusNode = FocusNode();

  final aboutKey = GlobalKey<FormState>();
  late TextEditingController aboutController;
  final aboutFocusNode = FocusNode();

  final websiteKey = GlobalKey<FormState>();
  late TextEditingController websiteController;
  final websiteFocusNode = FocusNode();

  final telephoneKey = GlobalKey<FormState>();
  late TextEditingController telephoneController;
  final telephoneFocusNode = FocusNode();

  final addressKey = GlobalKey<FormState>();
  late TextEditingController addressController;
  final addressFocusNode = FocusNode();

  Either<File?, String?>? _img;

  @override
  void initState() {
    super.initState();
    final state = ref.read(navViewModelProvider);

    brandNameController =
        TextEditingController(text: state.userData?['brname'] ?? '');
    nameController =
        TextEditingController(text: state.userData?['fname'] ?? '');
    titleController =
        TextEditingController(text: state.userData?['title'] ?? '');
    aboutController =
        TextEditingController(text: state.userData?['info'] ?? '');
    websiteController =
        TextEditingController(text: state.userData?['web'] ?? '');
    telephoneController =
        TextEditingController(text: state.userData?['tel'] ?? '');
    addressController =
        TextEditingController(text: state.userData?['address'] ?? '');

    if (state.userData?['profile_img'] != null) {
      _img = Right(state.userData?['profile_img']);
    }
  }

  @override
  void dispose() {
    brandNameController.dispose();
    nameController.dispose();
    titleController.dispose();
    aboutController.dispose();
    websiteController.dispose();
    telephoneController.dispose();
    addressController.dispose();

    brandNameFocusNode.dispose();
    nameFocusNode.dispose();
    titleFocusNode.dispose();
    aboutFocusNode.dispose();
    websiteFocusNode.dispose();
    telephoneFocusNode.dispose();
    addressFocusNode.dispose();

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
    if (!brandNameKey.currentState!.validate()) {
      validated = false;
    }
    if (!nameKey.currentState!.validate()) {
      validated = false;
    }
    if (!titleKey.currentState!.validate()) {
      validated = false;
    }
    if (!aboutKey.currentState!.validate()) {
      validated = false;
    }
    if (!websiteKey.currentState!.validate()) {
      validated = false;
    }
    if (!telephoneKey.currentState!.validate()) {
      validated = false;
    }
    if (!addressKey.currentState!.validate()) {
      validated = false;
    }

    if (validated) {
      ref.read(editProfileViewModelProvider.notifier).updateBrand(
          image: _img,
          brandName: brandNameController.text,
          firstName: nameController.text,
          title: titleController.text,
          info: aboutController.text,
          website: websiteController.text,
          telephone: telephoneController.text,
          address: addressController.text,
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
                      ref
                          .read(editProfileViewModelProvider.notifier)
                          .deleteAccount(ref);
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
                Form(
                  key: brandNameKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomTextField(
                    hintText: 'Brand Name',
                    controller: brandNameController,
                    node: brandNameFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Brand Name can\'t be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Form(
                  key: nameKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomTextField(
                    hintText: 'Name',
                    controller: nameController,
                    node: nameFocusNode,
                    obscureText: false,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Form(
                  key: titleKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomTextField(
                    hintText: 'Title',
                    controller: titleController,
                    node: titleFocusNode,
                    validator: (value) {
                      return null;
                    },
                  ),
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
                  height: 22,
                ),
                Form(
                  key: websiteKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomTextField(
                    hintText: 'Website',
                    keyBoardType: TextInputType.emailAddress,
                    controller: websiteController,
                    node: websiteFocusNode,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Form(
                  key: telephoneKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomTextField(
                    hintText: 'Telephone',
                    controller: telephoneController,
                    keyBoardType: TextInputType.phone,
                    node: telephoneFocusNode,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Form(
                  key: addressKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomTextField(
                    hintText: 'Address',
                    controller: addressController,
                    node: addressFocusNode,
                    validator: (value) {
                      return null;
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
