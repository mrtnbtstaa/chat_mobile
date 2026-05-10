import 'package:chat/core/contracts/i_user_storage.dart';
import 'package:chat/features/chat/chat_message/infrastructure/datasources/web_sockent_client.dart';

class ChatSocketService {

  final WebSockentClient _client;
  final IUserStorage _userStorage;

  ChatSocketService(this._client, this._userStorage);

  String? _cachedUserId;
  String? _cachedEmail;

  Future<void> _prepareUerInfo() async {
    _cachedUserId ??= await _userStorage.getUserInfo("user_id");
    _cachedEmail ??= await _userStorage.getUserInfo("email");
  }

  void sendTypingStatus(bool isTyping) async {
    // Ensure we have the data
    await _prepareUerInfo();

    final data = {
      "type": "typing",
      "user_id": _cachedUserId,
      "email": _cachedEmail,
      "is_typing": isTyping
    };

    _client.sendMessage(data);
  }

  bool isNotMe(String? incomingId) => incomingId != _cachedUserId;

}