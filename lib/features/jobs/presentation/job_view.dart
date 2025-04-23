import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/config/shimmers/job_shimmer.dart';
import 'package:yaallo/core/common/messages/show_snackbar.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/jobs/data/job_data_source.dart';
import 'package:yaallo/features/jobs/domain/job_entity.dart';
import 'package:yaallo/features/jobs/presentation/job_view_model.dart';
import 'package:yaallo/features/jobs/presentation/widget/custom_list_tile.dart';
import 'package:yaallo/features/jobs/presentation/widget/job_dialog.dart';
import 'package:yaallo/features/jobs/presentation/widget/new_job_page.dart';

import '../../../config/themes/app_theme.dart';

class JobView extends ConsumerWidget {
  const JobView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobState = ref.watch(jobViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        toolbarHeight: 70,
        elevation: 5,
        shadowColor: AppTheme.primaryColor.withOpacity(0.2),
        title: const Text(
          'Jobs',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: jobState.isLoading && jobState.jobs.isEmpty
          ? const JobShimmer(count: 2)
          : jobState.jobs.isEmpty
              ? RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    ref.read(jobViewModelProvider.notifier).resetState();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/no_jobs.png'),
                      const Text(
                        'Currently no jobs have been posted.\nPlease check back soon!',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    ref.read(jobViewModelProvider.notifier).resetState();
                  },
                  child: ListView.separated(
                    itemCount: jobState.jobs.length,
                    itemBuilder: (context, index) {
                      return CustomListTile(
                        title: Text(
                          jobState.jobs[index].ti ?? 'null',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jobState.jobs[index].des ?? 'null',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.pin_drop,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Site: ${jobState.jobs[index].loc ?? 'null'}',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  '|',
                                  style: TextStyle(color: Colors.grey),
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
                                  'Applicants: ${jobState.jobs[index].applicant?.length.toString() ?? 'null'}',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time_filled_rounded,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Date: 2 mon',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  '|',
                                  style: TextStyle(color: Colors.grey),
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
                                  'Perks: \$${jobState.jobs[index].sMin ?? 'null'}-${jobState.jobs[index].sMax ?? 'null'}/${jobState.jobs[index].dur ?? 'null'}',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: jobState.jobs[index].brid ==
                                ref.read(navViewModelProvider).userData!['hash']
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 42,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Applicants (${jobState.jobs[index].applicant?.length})'),
                                                content: SizedBox(
                                                  height: 200,
                                                  width: 300,
                                                  child: ListView.separated(
                                                    itemCount: jobState
                                                        .jobs[index]
                                                        .applicant!
                                                        .length,
                                                    itemBuilder: (context,
                                                        smallerIndex) {
                                                      return ListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        title: Text(
                                                          jobState.jobs[index]
                                                                          .applicant?[
                                                                      smallerIndex]
                                                                  ['name'] ??
                                                              'null',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        subtitle: Text(
                                                          jobState.jobs[index]
                                                                          .applicant?[
                                                                      smallerIndex]
                                                                  ['email'] ??
                                                              'null',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        trailing: IconButton(
                                                          onPressed: () async {
                                                            if (await canLaunchUrl(
                                                                Uri.parse(jobState
                                                                        .jobs[index]
                                                                        .applicant![smallerIndex]
                                                                    ['cv']!))) {
                                                              await launchUrl(Uri
                                                                  .parse(jobState
                                                                          .jobs[
                                                                              index]
                                                                          .applicant![smallerIndex]
                                                                      ['cv']!));
                                                              showSnackBar(ref: ref, message: 'Downloading File!');
                                                            } else {
                                                              throw 'Could not launch ${jobState.jobs[index].applicant![smallerIndex]['cv']!}';
                                                            }
                                                          },
                                                          icon: const Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text('CV'),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Icon(Iconsax
                                                                  .document_download),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return const Divider(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        height: 2,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppTheme.primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.zero),
                                      child: const Text(
                                        'Users',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            ref
                                                .read(navigationServiceProvider)
                                                .navigateTo(
                                                    page: NewJobPage(
                                                  entity: jobState.jobs[index],
                                                ));
                                          },
                                          child: const Icon(
                                            Iconsax.edit,
                                            size: 20,
                                          )),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            ref
                                                .read(jobViewModelProvider
                                                    .notifier)
                                                .job(jobState.jobs[index],
                                                    Method.deleteJob, ref);
                                          },
                                          child: const Icon(
                                            Iconsax.trash,
                                            color: Colors.red,
                                            size: 20,
                                          )),
                                    ],
                                  ),
                                ],
                              )
                            : !jobState.jobs[index].applicant!.any((e) =>
                                    e['uid'] ==
                                    ref
                                        .read(navViewModelProvider)
                                        .userData!['hash'])
                                ? ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return JobDialog(index: index);
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        padding: EdgeInsets.zero),
                                    child: const Text(
                                      'Apply',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  )
                                : Container(
                                    width: 70,
                                    height: 42,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    decoration: BoxDecoration(
                                        color: AppTheme.primaryColor
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Text(
                                      'Applied',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: AppTheme.primaryColor,
                        height: 2,
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(navigationServiceProvider).navigateTo(
                  page: NewJobPage(
                entity: JobEntity.empty(),
              ));
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
