import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:yaallo/core/common/widgets/custom_dropdown_field.dart';
import 'package:yaallo/core/common/widgets/custom_text_field.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/jobs/data/job_data_source.dart';
import 'package:yaallo/features/jobs/domain/job_entity.dart';
import 'package:yaallo/features/jobs/presentation/job_view_model.dart';

import '../../../../config/themes/app_theme.dart';

class NewJobPage extends ConsumerStatefulWidget {
  final JobEntity entity;

  const NewJobPage({super.key, required this.entity});

  @override
  ConsumerState createState() => _NewJobPageState();
}

class _NewJobPageState extends ConsumerState<NewJobPage> {
  final jobTitleController = TextEditingController(text: '');
  final jobTitleNode = FocusNode();
  final jobTitleKey = GlobalKey<FormState>();

  final addressController = TextEditingController(text: '');
  final addressNode = FocusNode();
  final addressKey = GlobalKey<FormState>();

  final minSalaryController = TextEditingController(text: '0');
  final minSalaryNode = FocusNode();
  final minSalaryKey = GlobalKey<FormState>();

  final maxSalaryController = TextEditingController(text: '0');
  final maxSalaryNode = FocusNode();
  final maxSalaryKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController(text: '');
  final descriptionNode = FocusNode();
  final descriptionKey = GlobalKey<FormState>();

  late String dur;
  late String ind;
  late String type;

  @override
  void initState() {
    jobTitleController.text = widget.entity.ti ?? '';
    addressController.text = widget.entity.loc ?? '';
    minSalaryController.text = widget.entity.sMin.toString();
    maxSalaryController.text = widget.entity.sMax.toString();
    descriptionController.text = widget.entity.des ?? '';
    dur = widget.entity.dur ?? 'Per Month';
    ind = widget.entity.ind ?? 'Fashion';
    type = widget.entity.type ?? 'Full-time';
    super.initState();
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
            'Create New Job',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: jobTitleKey,
                  child: CustomTextField(
                    controller: jobTitleController,
                    hintText: 'Job Title',
                    node: jobTitleNode,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: addressKey,
                  child: CustomTextField(
                    controller: addressController,
                    hintText: 'Job Location',
                    node: addressNode,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: minSalaryKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Expanded(
                        child: CustomTextField(
                          hintText: 'Minimum Salary',
                          controller: minSalaryController,
                          node: minSalaryNode,
                          keyBoardType: TextInputType.number,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value == '') return null;
                            try {
                              int.parse(value);
                              return null;
                            } catch (e) {
                              return 'Invalid number';
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Form(
                      key: maxSalaryKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Expanded(
                        child: CustomTextField(
                          hintText: 'Maximum Salary',
                          controller: maxSalaryController,
                          node: maxSalaryNode,
                          keyBoardType: TextInputType.number,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value == '') return null;
                            try {
                              int.parse(value);
                              return null;
                            } catch (e) {
                              return 'Invalid number';
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomDropdownField(
                  items: const ['Per Month', 'Per Task'],
                  width: MediaQuery.of(context).size.width - 28,
                  initiallySelected: 'Per Month',
                  hintText: '',
                  onChanged: (value) {
                    setState(() {
                      dur = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomDropdownField(
                  items: const [
                    'Fashion',
                    'Beauty',
                    'Luxury',
                    'Hotels & Resorts',
                    'Tourism',
                    'Food & Beverage',
                    'Wellness',
                    'Leisure',
                    'Technology',
                    'Others'
                  ],
                  width: MediaQuery.of(context).size.width - 28,
                  hintText: 'Job Industry',
                  initiallySelected: 'Fashion',
                  onChanged: (value) {
                    setState(() {
                      dur = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomDropdownField(
                  items: const [
                    'Full-time',
                    'Part-time',
                    'Education',
                    'Internship',
                    'Volunteer'
                  ],
                  width: MediaQuery.of(context).size.width - 28,
                  hintText: 'Job Type',
                  initiallySelected: 'Full-time',
                  onChanged: (value) {
                    setState(() {
                      dur = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: descriptionKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (value) {
                      return null;
                    },
                    focusNode: descriptionNode,
                    maxLines: null,
                    minLines: 8,
                    decoration: InputDecoration(
                      labelText: 'Description',
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
                      descriptionNode.unfocus();
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: () {
                    final JobEntity jobEntity = JobEntity(
                      id: widget.entity.id,
                      ti: jobTitleController.text,
                      loc: addressController.text,
                      sMax: double.parse(maxSalaryController.text.toString())
                          .ceil(),
                      sMin: double.parse(minSalaryController.text.toString())
                          .ceil(),
                      dur: dur,
                      type: type,
                      ind: ind,
                      des: descriptionController.text,
                      brid: ref.read(navViewModelProvider).userData!['hash'],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      applicant: const [],
                    );
                    ref.read(jobViewModelProvider.notifier).job(
                        jobEntity,
                        widget.entity.id != null
                            ? Method.editJob
                            : Method.newJob,
                        ref);
                  },
                  child: ref.watch(jobViewModelProvider).createLoading
                      ? const ButtonCircularProgressIndicator()
                      : Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
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
