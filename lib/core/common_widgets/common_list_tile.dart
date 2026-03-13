import 'package:flutter/material.dart';
import 'common_icon.dart';
import 'common_text.dart';

class CommonListTile extends StatelessWidget {

  const CommonListTile({ 
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
    this.withTrailing = false,
    this.trailing
   });

  final IconData iconData;
  final Widget? trailing;
  final String text;
  final bool withTrailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context){

    if(withTrailing){
      return ListTile(
        onTap: onTap,
        leading: CommonIcon(
          iconData: iconData,
        ),
        title: CommonText(text: text),
        trailing: trailing,
      );
    }

    return ListTile(
      onTap: onTap,
      leading: CommonIcon(
        iconData: iconData,
      ),
      title: CommonText(text: text),
    );
    
  }
}