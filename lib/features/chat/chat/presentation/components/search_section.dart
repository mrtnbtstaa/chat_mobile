import '../../../../../core/common_widgets/common_text_field.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
const SearchSection({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonTextField(
      hintText: "Search conversations...",
      onChanged: (v) => {},
      controller: TextEditingController(),
    );
  }
}