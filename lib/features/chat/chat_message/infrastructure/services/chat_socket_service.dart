import 'package:chat/core/contracts/i_user_storage.dart';
import 'package:chat/features/chat/chat_message/infrastructure/datasources/web_sockent_client.dart';

class ChatSocketService {

  final WebSockentClient _client;
  final IUserStorage _userStorage;

  ChatSocketService(this._client, this._userStorage);

  String? _cachedUserId;
  String? _cachedUsername;

  Future<void> _prepareUerInfo() async {
    _cachedUserId ??= await _userStorage.getUserInfo("user_id");
    _cachedUsername ??= await _userStorage.getUserInfo("username");
  }

  void sendTypingStatus(bool isTyping) async {
    // Ensure we have the data
    await _prepareUerInfo();

    final data = {
      "type": "typing", // Keep this consistent with your Django "type" check
      "user_id": _cachedUserId,
      "username": _cachedUsername,
      "is_typing": isTyping
    };

    _client.sendMessage(data);
  }

  bool isNotMe(String? incomingId) => incomingId != _cachedUserId;

}