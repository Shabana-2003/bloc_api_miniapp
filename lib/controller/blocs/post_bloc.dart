import 'package:bloc/bloc.dart';
import 'package:bloc_api_noteapp/controller/api_services/api_calls.dart';
import 'package:bloc_api_noteapp/model/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {// called main page
  PostBloc() : super(PostInitial()) {
    final api = ApiCalls();

    on<FetchPostApiEvent>((event, emit) async {
      emit(PostState(postList: [], isLoading: true));
      final posts = await api.fetchAllPost();
      emit(PostState(postList: posts, isLoading: false));
    });

    on<AddPostEvent>((event, emit) async {
      emit(PostState(postList: [], isLoading: true, isAdding: true));
      final bool success = await api.addPost(event.post);
      final List<PostModel> posts = await api.fetchAllPost();
      emit(PostState(
          postList: posts, isLoading: false, isAdding: false, status: success));
    });
  }
}
