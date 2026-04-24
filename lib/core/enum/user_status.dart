enum UserStatus {

  _online("Online"),
  _offline("Offline");

  final String _status;

  static String get onlineStatus => UserStatus._online._status;
  static String get offlineStatus => UserStatus._offline._status;
  
  const UserStatus(this._status);

}