import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/home/settings/theme_buttom_shape.dart';

import 'language_buttom_shape.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            appLocalizations.language,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 15),
          _buildSettingButton(
            context,
            appLocalizations.english,
            () => showLanguageButtonShape(context),
          ),
          const SizedBox(height: 15),
          Text(
            appLocalizations.mode,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 15),
          _buildSettingButton(
            context,
            appLocalizations.light,
            () => showThemeButtonShape(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingButton(
    BuildContext context,
    String text,
    VoidCallback onTap,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void showLanguageButtonShape(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageButtonShape(),
    );
  }

  void showThemeButtonShape(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeButtonShape(),
    );
  }
}
