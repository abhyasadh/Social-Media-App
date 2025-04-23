import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../domain/message_repository.dart';
import 'message_data_source.dart';


final messageRemoteRepositoryProvider = Provider<IMessageRepository>(
      (ref) => MessageRepositoryImpl(
    messageDataSource: ref.read(messageDataSourceProvider),
  ),
);

class MessageRepositoryImpl implements IMessageRepository {
  final MessageDataSource messageDataSource;

  MessageRepositoryImpl({required this.messageDataSource});

  @override
  Future<Either<Failure, List<dynamic>>> getMessages() {
    return messageDataSource.getMessages();
  }
}
