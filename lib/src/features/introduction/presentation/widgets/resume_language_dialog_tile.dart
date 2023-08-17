import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/src/common/data/language_repository.dart';
import 'package:portfolio/src/features/introduction/domain/resume.dart';
import 'package:portfolio/src/localization/generated/locale_keys.g.dart';

import 'package:url_launcher/url_launcher.dart';

class ResumeLanguageDialogTile extends ConsumerWidget {
  const ResumeLanguageDialogTile({super.key, required this.resume});
  final Resume resume;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        final resumeUrl = resume.url;
        if (resumeUrl == null) return;
        _onPressed(context, resumeUrl: resumeUrl);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: _buildResumeLanguageText(context, ref, resume: resume),
          ),
        ],
      ),
    );
  }
}

Text _buildResumeLanguageText(
  BuildContext context,
  WidgetRef ref, {
  required Resume resume,
}) {
  final languages = ref.watch(languageRepositoryProvider).getLanguages();
  final resumeLanguageCode = resume.languageCode;
  if (resumeLanguageCode != null) {
    final language = languages.firstWhere((language) {
      return language.code == resumeLanguageCode;
    });
    return Text(
      language.name ?? tr(LocaleKeys.unknownLanguageError),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
  return Text(
    tr(LocaleKeys.unknownLanguageError),
    style: Theme.of(context).textTheme.titleMedium,
  );
}

void _onPressed(BuildContext context, {required String resumeUrl}) async {
  try {
    await launchUrl(Uri.parse(resumeUrl));
  } catch (e) {
    final snackBar = SnackBar(
      content: Text(tr(LocaleKeys.openResumeError)),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}
