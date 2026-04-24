import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecases/base_usecase.dart';
import '../../domain/params/chat_message_param.dart';
import '../../domain/repositories/i_chat_message_repository.dart';

class SendMessageUsecase extends BaseUsecase<Unit, ChatMessageParam>{

  final IChatMessageRepository _chatMessageRepository;

  SendMessageUsecase(this._chatMessageRepository);

  @override
  Future<Either<Failure, Unit>> call(ChatMessageParam param) async => await _chatMessageRepository.sendMessage(param.content, param.recipientId);

}