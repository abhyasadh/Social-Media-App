class EditProfileState {
  final bool isLoading;
  final String? imageName;

  EditProfileState({
    required this.isLoading,
    this.imageName,
  });

  factory EditProfileState.initialState() =>
      EditProfileState(isLoading: false, imageName: null);

  EditProfileState copyWith({
    bool? isLoading,
    String? imageName,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      imageName: imageName ?? this.imageName,
    );
  }
}