class MessageState {
  final List<dynamic> messages;
  final bool isLoading;

  MessageState({
    required this.messages,
    required this.isLoading,
  });

  factory MessageState.initial() {
    return MessageState(
      messages: [],
      isLoading: false,
    );
  }

  MessageState copyWith({
    List<dynamic>? messages,
    bool? isLoading,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
