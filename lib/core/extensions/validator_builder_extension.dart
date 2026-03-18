import 'package:chat/core/utils/validation_builder.dart';

extension ValidatorBuilderExtension on String? {
  ValidationBuilder validate(String fieldName){
    return ValidationBuilder(this, fieldName);
  }
}