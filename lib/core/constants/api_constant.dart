class ApiConstant {

  // -------------- Authentication API ------------------
  static const String _baseAuthApi = "api/v1/auth/";
  static const String loginApi = "${_baseAuthApi}login/";
  static const String registerApi = "${_baseAuthApi}register/";
  static const String logoutApi = "${_baseAuthApi}logout/";
  static const String refreshApi = "${_baseAuthApi}refresh/";
  static const String verifyTokenApi = "${_baseAuthApi}verify-token/";
  static const String changePasswordApi = "${_baseAuthApi}passwords/";
  // -------------- Authentication API ------------------


  // -------------- Chat API ------------------
  static const String _baseChatApi = "api/v1/chats/";
  static const String listChatApi = _baseChatApi;
  static const String listChatUserApi = "${_baseChatApi}users/";
  static const String chatMessageApi = "${_baseChatApi}messages/";
  static const String listChatMessagesApi = "${_baseChatApi}messages/";
  static const String listGroupChatApi = "${_baseChatApi}group/";
  // -------------- Chat API ------------------

  // -------------- Profile API ------------------
  static const String updateProfileApi = "${_baseAuthApi}profile/";
  // -------------- Profile API ------------------

  // -------------- WS API ------------------
  static const String directChatWs = "ws/chat/direct/";
  static const String chatInboxWs = "ws/chat/inbox/";
  // -------------- WS API ------------------

}