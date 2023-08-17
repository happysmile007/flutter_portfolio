import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/features/introduction/data/introduction_repository.dart';
import 'package:portfolio/src/features/introduction/domain/resume.dart';
import 'package:portfolio/src/features/introduction/presentation/widgets/contact_bar.dart';
import 'package:portfolio/src/features/introduction/presentation/widgets/favorite_icon.dart';
import 'package:portfolio/src/features/introduction/presentation/widgets/magic_icon.dart';
import 'package:portfolio/src/features/introduction/presentation/widgets/resume_button.dart';
import 'package:portfolio/src/localization/generated/locale_keys.g.dart';

class IntroductionDesktop extends ConsumerWidget {
  const IntroductionDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumes = ref.watch(introductionRepositoryProvider).getResumes();
    final contacts = ref.watch(introductionRepositoryProvider).getContacts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(LocaleKeys.name),
          style: Theme.of(context).textTheme.displayLarge,
        ),
        gapH4,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${tr(LocaleKeys.description)} ",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const MagicIcon(),
          ],
        ),
        gapH8,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${tr(LocaleKeys.subDescription)} ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const FavoriteIcon(),
          ],
        ),
        _buildResumeButton(ref, resumes: resumes.toList()),
        const Spacer(),
        gapH8,
        ContactBar(contacts: contacts.toList()),
      ],
    );
  }

  Widget _buildResumeButton(WidgetRef ref, {required List<Resume> resumes}) {
    if (resumes.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        gapH40,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ResumeButton(resumes: resumes),
        ),
      ],
    );
  }
}
