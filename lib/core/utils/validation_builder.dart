class ValidationBuilder {

  final String? _value;
  final String _fieldName;
  String? _error;

  ValidationBuilder(this._value, this._fieldName);
  
  ValidationBuilder required({String? message}){
    if(_error != null) return this; // If error already exists
    if((_value == null || _value.isEmpty) && message == null){_error = "$_fieldName is required";}
    else if((_value == null || _value.isEmpty) && message != null) {_error = "$_fieldName $message";}
    return this;
  }

  ValidationBuilder minLength(int min){
    if(_error != null) return this; // If error already exists
    if(_value!.length <= min){
      _error = "$_fieldName must be atleast $min characters";
    }
    return this;
  }

  ValidationBuilder maxLength(int max){
    if(_error != null) return this; // If error already exists
    if(_value!.length > max){
      _error = "$_fieldName cannot exceed $max characters.";
    }
    return this;
  }

  ValidationBuilder passwordMatch(String? otherPassword, {String? message}){
    if(_error != null) return this; // If error already exists
    if(_value != null && otherPassword != null){
      if(_value != otherPassword){
        _error = message ?? "Password do not match";
      }
    }
    return this;
  }

  ValidationBuilder isAlphanumeric({String? message}){
    if(_error != null) return this; // If error already exists
    final RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
    if(!regex.hasMatch(_value ?? "")){
      _error = message ?? "Only letters and numbers are allowed";
    }
    return this;
  }

  ValidationBuilder strongPassword({String? message}){
    if(_error != null) return this; // If error already exists
    final RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])');
    if(!regex.hasMatch(_value ?? "")){
      _error = message ?? "Password Must include upper, lower, number, and symbol";
    }
    return this;
  }

  String build() => _error ?? "";

}