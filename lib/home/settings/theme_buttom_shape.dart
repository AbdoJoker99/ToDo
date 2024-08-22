import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../providers/app_config_provider.dart';

class ThemeButtomShape extends StatefulWidget {
  const ThemeButtomShape({super.key});

  @override
  State<ThemeButtomShape> createState() => _ThemeButtomShapeState();
}

class _ThemeButtomShapeState extends State<ThemeButtomShape> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
        margin: EdgeInsets.all(10),
        //padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.light);
                },
                child: provider.appTheme == ThemeMode.light
                    ? getSelectedItemWidget(AppLocalizations.of(context)!.light)
                    : getUnSelectedItemWidget(
                        AppLocalizations.of(context)!.light),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.dark);
                },
                child: provider.isDarkMode()
                    ? getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                    : getUnSelectedItemWidget(
                        AppLocalizations.of(context)!.dark),
              ),
            ),
          ],
        ));
  }

  Widget getSelectedItemWidget(String text) {
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

  Widget getUnSelectedItemWidget(String text) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall);
  }
}
