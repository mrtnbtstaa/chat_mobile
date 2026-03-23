class ApiConstant {

  // -------------- Authentication API ------------------
  static const String _baseAuthApi = "api/v1/auth/";
  static const String loginApi = "${_baseAuthApi}login/";
  static const String registerApi = "${_baseAuthApi}register/";
  static const String logoutApi = "${_baseAuthApi}logout/";
  static const String refreshApi = "${_baseAuthApi}refresh/";
  static const String verifyTokenApi = "${_baseAuthApi}verify-token/";
  // -------------- Authentication API ------------------


  // -------------- Chat API ------------------
  static const String _baseChatApi = "api/v1/chats/";
  static const listChatApi = _baseChatApi;
  // -------------- Chat API ------------------

  // -------------- WS API ------------------
  static const String directChatWs = "ws/chat/direct/";
  // -------------- WS API ------------------

}