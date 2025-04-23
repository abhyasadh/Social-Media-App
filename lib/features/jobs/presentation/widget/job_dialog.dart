import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/core/common/messages/show_snackbar.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/jobs/presentation/job_view_model.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';

class JobDialog extends ConsumerStatefulWidget {
  final int index;

  const JobDialog({super.key, required this.index});

  @override
  ConsumerState createState() => _JobDialogState();
}

class _JobDialogState extends ConsumerState<JobDialog> {

  final nameKey = GlobalKey<FormState>();
  final nameController =
  TextEditingController(text: '');
  final nameFocusNode = FocusNode();

  final emailKey = GlobalKey<FormState>();
  final emailController =
  TextEditingController(text: '');
  final emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final jobState = ref.watch(jobViewModelProvider);

    return AlertDialog(
      title: Text(
        jobState.jobs[widget.index].ti ?? 'null',
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                  size: 18,
                  color: Colors.grey,
                ),
                Text(
                  'Site: ${jobState.jobs[widget.index].loc ?? 'null'}',
                  style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '|',
                  style: TextStyle(
                      color: Colors.grey),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.file_open_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Applicants: ${jobState.jobs[widget.index].applicant?.length.toString() ?? 'null'}',
                  style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Icon(
                  Icons
                      .access_time_filled_rounded,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  'Date: 2 mon',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '|',
                  style: TextStyle(
                      color: Colors.grey),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.credit_card,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Perks: \$${jobState.jobs[widget.index].sMin ?? 'null'}-${jobState.jobs[widget.index].sMax ?? 'null'}/${jobState.jobs[widget.index].dur ?? 'null'}',
                  style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              jobState.jobs[widget.index].des ??
                  'null',
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Apply Form',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: nameKey,
              autovalidateMode: AutovalidateMode
                  .onUserInteraction,
              child: CustomTextField(
                hintText: 'Name',
                controller: nameController,
                node: nameFocusNode,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Name can\'t be empty!';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: emailKey,
              autovalidateMode: AutovalidateMode
                  .onUserInteraction,
              child: CustomTextField(
                hintText: 'Email',
                controller: emailController,
                keyBoardType:
                TextInputType.emailAddress,
                node: emailFocusNode,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Email can\'t be empty!';
                  } else {
                    RegExp regex = RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!regex
                        .hasMatch(value)) {
                      return 'Invalid email address!';
                    }
                  }
                  return null;
                },
              ),
            ),
            InkWell(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null) {
                  String? extension = result.files.first.extension;
                  if (extension == 'pdf') {
                    ref.read(jobViewModelProvider.notifier).uploadFile(result.files.first);
                  } else {
                    showSnackBar(ref: ref, message: 'Only PDF files are supported!', error: true);
                  }
                }
              },
              child: Container(
                height: 55,
                margin: const EdgeInsets.only(
                    top: 20),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      14),
                  border: Border.all(
                      color: AppTheme
                          .primaryColor),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.attach_file,
                      color: AppTheme
                          .primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        jobState.file == null ? 'Attach CV' : jobState.file!.name,
                        style: const TextStyle(
                          color: AppTheme
                              .primaryColor,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        CustomButton(
          onPressed: () async {
            if (nameKey.currentState!.validate() && emailKey.currentState!.validate() && jobState.file != null) {
              FormData formData = FormData();
              formData.files.add(MapEntry(
                'cvFile',
                MultipartFile.fromFileSync(
                  jobState.file!.path!,
                ),
              ));

              final data = {
                'jobId': jobState.jobs[widget.index].id,
                'name': nameController.text,
                'email': emailController.text,
                'uid': ref.read(navViewModelProvider).userData!['hash'],
              };

              data.forEach((key, value) {
                formData.fields.add(MapEntry(key, value.toString()));
              });

              ref.read(jobViewModelProvider.notifier).applyJob(formData, ref);
            } else {
              showSnackBar(ref: ref, message: 'Please fill all fields!', error: true);
            }
          },
          child: jobState.applyLoading
              ? const ButtonCircularProgressIndicator()
              : Text(
            'Submit',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .colorScheme
                  .secondary,
            ),
          ),
        )
      ],
    );
  }
}
