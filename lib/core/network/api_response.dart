sealed class ApiResponse {}

final String successStatus = "success";
final String errorStatus = "error";

class SuccessResponse extends ApiResponse{

  final String status;
  final String message;
  final dynamic data;

  SuccessResponse({
    required this.status,
    required this.message,
    required this.data
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json){
    return SuccessResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"]
    );
  }

}

class ErrorResponse extends ApiResponse{

  final String status;
  final ErrorData error;

  ErrorResponse({
    required this.status,
    required this.error
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json){
    return ErrorResponse(
      status: json["status"],
      error: ErrorData.fromJson(json["error"])
    );
  }

}

class ErrorData{

  final String code;
  final String message;
  final List<ErrorDetail> details;

  ErrorData({
    required this.code,
    required this.message,
    required this.details
  });

  factory ErrorData.fromJson(Map<String, dynamic> json){
    return ErrorData(
      code: json["code"],
      message: json["message"],
      details: json["details"] != null
        ? (json["details"] as List)
        .map((i) => ErrorDetail.fromJson(i))
        .toList()
        : []
    );
  }

}

class ErrorDetail{
  final String field;
  final String issue;

  const ErrorDetail({
    required this.field,
    required this.issue
  });

  factory ErrorDetail.fromJson(Map<String, dynamic> json){
    return ErrorDetail(field: json["field"], issue: json["issue"]);
  }

}

ApiResponse handleApiResponse(Map<String, dynamic> json){
  final status = json["status"];
  if(status == successStatus){
    return SuccessResponse.fromJson(json);
  }else if(status == errorStatus){
    return ErrorResponse.fromJson(json);
  }else{
    throw Exception("Unknown API Status");
  }

}