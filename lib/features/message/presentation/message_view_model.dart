import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/message_usecase.dart';
import 'message_state.dart';

final messageViewModelProvider =
StateNotifierProvider.autoDispose<MessageViewModel, MessageState>((ref) => MessageViewModel(
  ref.read(messageUseCaseProvider),
));

class MessageViewModel extends StateNotifier<MessageState> {
  final MessageUseCase _messageUseCase;

  MessageViewModel(
      this._messageUseCase,
      ) : super(
    MessageState.initial(),
  ) {
    getMessages();
  }

  Future resetState() async {
    state = MessageState.initial();
    getMessages();
  }

  Future getMessages() async {
    state = state.copyWith(isLoading: true);
    final result = await _messageUseCase.getMessages();
    result.fold((failure) => state = state.copyWith(isLoading: false), (data) {
      state = state.copyWith(
        messages: data,
        isLoading: false,
      );
    });
  }
}
