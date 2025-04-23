import 'dart:io';

class NewPostState {
  final String? id;
  final String? title;
  final List<File> images;
  final List<String> imageUploads;
  final bool isLoading;

  NewPostState({
    this.id,
    this.title,
    this.images = const [],
    this.imageUploads = const [],
    this.isLoading = false,
  });

  NewPostState.initialState()
      : id = null,
        title = null,
        images = [],
        imageUploads = [],
        isLoading=false;

  NewPostState copyWith({
    String? id,
    String? title,
    List<File>? images,
    List<String>? imageUploads,
    bool? isLoading,
  }) {
    return NewPostState(
      id: id ?? this.id,
      title: title ?? this.title,
      images: images ?? this.images,
      imageUploads: imageUploads ?? this.imageUploads,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
