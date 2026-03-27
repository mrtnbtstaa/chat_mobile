import 'package:chat/core/network/api_response.dart';

String? getFieldError(List<ErrorDetail>? errors, String fieldName){
  
  if(errors == null || errors.isEmpty) return null;

  // Find the error field that matches
  for(var error in errors){
    if(error.field == fieldName) return error.issue;
  }

  // If it goes here means there is no field found return null
  return null; 

}