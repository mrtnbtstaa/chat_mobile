import 'theme_button_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/bloc/theme_bloc.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../../application/bloc/settings_bloc.dart';
import '../../constants/settings_ui_constant.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.h32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppSizes.size24.height(),
          CommonText(text: "VISUAL STYLE", fontColor: context.textTheme.bodySmall?.color,),
          CommonText(
            text: "Choose Theme",
            fontWeight: FontWeight.w700,
            fontSize: AppSizes.size24,
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return Row(
                spacing: AppSizes.spacing16,
                children: [
                  for(final option in themeOptions)
                  ThemeButtonContent(
                    value: state.appTheme == option.theme,
                    text: option.label,
                    onTap: (){
                      context.read<ThemeBloc>().add(ThemeChanged(currentTheme: option.theme));
                      context.read<SettingsBloc>().add(ThemeClicked(appTheme: option.theme));
                    }
                  )
                ]
              );
            }
          )
        ]
      )
    );
  }
}

