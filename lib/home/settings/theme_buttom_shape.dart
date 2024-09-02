import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../providers/app_config_provider.dart';

class ThemeButtonShape extends StatefulWidget {
  const ThemeButtonShape({super.key});

  @override
  State<ThemeButtonShape> createState() => _ThemeButtonShapeState();
}

class _ThemeButtonShapeState extends State<ThemeButtonShape> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppConfigProvider>(context);
    final appLocalizations = AppLocalizations.of(context);

    if (appLocalizations == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => provider.toggleAppThemeMode(ThemeMode.light),
              child: provider.appTheme == ThemeMode.light
                  ? _getSelectedItemWidget(
                      appLocalizations.light, provider.appTheme)
                  : _getUnSelectedItemWidget(
                      appLocalizations.light, provider.appTheme),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => provider.toggleAppThemeMode(ThemeMode.dark),
              child: provider.appTheme == ThemeMode.dark
                  ? _getSelectedItemWidget(
                      appLocalizations.dark, provider.appTheme)
                  : _getUnSelectedItemWidget(
                      appLocalizations.dark, provider.appTheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSelectedItemWidget(String text, ThemeMode themeMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: themeMode == ThemeMode.light
              ? TextStyle(color: AppColors.primaryColor)
              : TextStyle(color: AppColors.primaryColor),
        ),
        Icon(
          Icons.check,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _getUnSelectedItemWidget(String text, ThemeMode themeMode) {
    return Text(
      text,
      style: themeMode == ThemeMode.light
          ? TextStyle(color: Colors.black)
          : TextStyle(color: Colors.white),
    );
  }
}
