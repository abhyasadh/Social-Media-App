import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/new_post/presentation/new_post_view_model.dart';
import 'package:yaallo/features/new_post/presentation/widgets/dashed_border_container/dashed_border_container.dart';

import '../../../config/themes/app_theme.dart';
import '../../../core/common/provider/image_picker_util.dart';
import '../../../core/common/widgets/custom_button.dart';
import '../../../core/common/widgets/custom_text_field.dart';

class NewPostView extends ConsumerStatefulWidget {
  const NewPostView({super.key});

  @override
  ConsumerState createState() => _NewPostViewState();
}

class _NewPostViewState extends ConsumerState<NewPostView> {
  final titleController = TextEditingController();
  final titleNode = FocusNode();
  final titleKey = GlobalKey<FormState>();

  final contentController = TextEditingController();
  final contentNode = FocusNode();
  final contentKey = GlobalKey<FormState>();

  bool flagged = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage(BuildContext context) async {
    ImagePickerUtil.showImagePickerOptions(
      context: context,
      ref: ref,
      onImagePicked: (image) {
        ref.read(newPostViewModelProvider.notifier).addImage(image!, ref);
      },
    );
  }

  Future<void> _post() async {
    if (titleKey.currentState!.validate() && contentController.text.isNotEmpty) {
      try {
        await ref.read(newPostViewModelProvider.notifier).postNewPost(
          title: titleController.text,
          content: contentController.text,
          ref: ref,
        );
        // Optionally navigate away or reset form after successful post
      } catch (e) {
        setState(() {
          flagged = true;
        });
      }
    } else if (titleController.text.isEmpty || contentController.text.isEmpty) {
      setState(() {
        flagged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(newPostViewModelProvider).images;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          title: const Text(
            'New Post',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: titleKey,
                  child: CustomTextField(
                    controller: titleController,
                    node: titleNode,
                    hintText: 'Title',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title can\'t be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: contentKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: contentController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (value) {
                      return null;
                    },
                    focusNode: contentNode,
                    maxLines: null,
                    minLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppTheme.primaryColor),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppTheme.primaryColor),
                          borderRadius: BorderRadius.circular(30)),
                      labelStyle: const TextStyle(color: AppTheme.primaryColor),
                    ),
                    onTapOutside: (e) {
                      contentNode.unfocus();
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ...images.map((imagePath) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          children: [
                            Image.file(
                              imagePath,
                              width: MediaQuery.of(context).size.width / 3 - 14,
                              height: (MediaQuery.of(context).size.width / 3 - 14) * 3 / 4,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: InkWell(
                                onTap: () {
                                  ref.read(newPostViewModelProvider.notifier).removeImage(imagePath);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.black54,
                                  ),
                                  child: const Icon(Icons.close, color: Colors.white, size: 16,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    if (images.length < 10)
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        height: (MediaQuery.of(context).size.width / 3 - 20) * 3 / 4,
                        child: InkWell(
                          onTap: () => _pickImage(context),
                          child: DashedBorderContainer(
                            borderColor: Colors.grey,
                            borderWidth: 2.0,
                            dashWidth: 6.0,
                            dashSpace: 5.0,
                            child: Column(
                              children: [
                                const Expanded(
                                    child: Icon(Icons.add_rounded, color: Colors.grey, size: 30,)
                                ),
                                Text(
                                  "${images.length + 1} of 10 Images",
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Visibility(
                  visible: flagged && (images.isEmpty),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 14),
                    child: Text('Minimum of 1 image is required!', style: TextStyle(fontSize: 12, color: AppTheme.errorColor),),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  onPressed: _post,
                  child: const Text(
                    'Post Now',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

