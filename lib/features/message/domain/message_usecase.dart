import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import 'message_repository.dart';

final messageUseCaseProvider = Provider<MessageUseCase>(
      (ref) => MessageUseCase(messageRepository: ref.read(messageRepositoryProvider)),
);

class MessageUseCase {
  final IMessageRepository messageRepository;

  MessageUseCase({required this.messageRepository});

  Future<Either<Failure, List<dynamic>>> getMessages() async {
    return await messageRepository.getMessages();
  }
}