part of 'post_bloc.dart';

class PostEvent {}

class FetchPostApiEvent extends PostEvent {}

class AddPostEvent extends PostEvent {
  PostModel post;
  AddPostEvent({required this.post});
}

