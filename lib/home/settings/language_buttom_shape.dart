import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../providers/app_config_provider.dart';

class LanguageButtonShape extends StatefulWidget {
  const LanguageButtonShape({super.key});

  @override
  State<LanguageButtonShape> createState() => _LanguageButtonShapeState();
}

class _LanguageButtonShapeState extends State<LanguageButtonShape> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppConfigProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => provider.changeAppLanguage("en"),
              child: provider.appLanguage == 'en'
                  ? _getSelectedItemWidget(appLocalizations.english)
                  : _getUnSelectedItemWidget(appLocalizations.english),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => provider.changeAppLanguage("ar"),
              child: provider.appLanguage == 'ar'
                  ? _getSelectedItemWidget(appLocalizations.arabic)
                  : _getUnSelectedItemWidget(appLocalizations.arabic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        Icon(
          Icons.check,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _getUnSelectedItemWidget(String text) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall);
  }
}
