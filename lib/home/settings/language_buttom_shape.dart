import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../providers/app_config_provider.dart';

class LanguageButtomShape extends StatefulWidget {
  const LanguageButtomShape({super.key});

  @override
  State<LanguageButtomShape> createState() => _LanguageButtomShapeState();
}

class _LanguageButtomShapeState extends State<LanguageButtomShape> {
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
                  provider.changeLanguage("en");
                },
                child: provider.appLanguage == 'en'
                    ? getSelectedItemWidget(
                        AppLocalizations.of(context)!.english)
                    : getUnSelectedItemWidget(
                        AppLocalizations.of(context)!.english),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  provider.changeLanguage("ar");
                },
                child: provider.appLanguage == 'ar'
                    ? getSelectedItemWidget(
                        AppLocalizations.of(context)!.arabic)
                    : getUnSelectedItemWidget(
                        AppLocalizations.of(context)!.arabic),
              ),
            )
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
