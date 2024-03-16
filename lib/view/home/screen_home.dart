import 'package:bloc_api_noteapp/controller/blocs/post_bloc.dart';
//import 'package:bloc_api_noteapp/view/add_post/screen_add_post.dart';
//import 'package:bloc_api_noteapp/view/home/widgets/delete_student.dart';
import 'package:bloc_api_noteapp/view/home/widgets/floating_button.dart';
import 'package:bloc_api_noteapp/view/view_post/screen_view_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    print('build() --> called');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<PostBloc>().add(FetchPostApiEvent());
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                context.read<PostBloc>().add(FetchPostApiEvent());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listenWhen: (previous, current) => current.status,
        listener: (context, state) {
          if (state.status) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'operation done successfully',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Unable to insert data',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          print('bloc() --> called');
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.postList.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ScreenViewPost(post: state.postList[index])));
                  },
                  leading: const CircleAvatar(),
                  title: Text(
                    state.postList[index].title,
                  ),
                
                 // trailing: SizedBox(
                   // width: MediaQuery.of(context).size.width * .250,
                    //child: Row(
                      //children: [
                        // IconButton(
                        //   onPressed: () {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => ScreenAddPost(
                        //             action: PostAction.edit,
                        //             post: state.postList[index])));
                        //   },
                        //   icon: const Icon(Icons.edit, color: Colors.black),
                        // ),
                        // IconButton(
                        //   onPressed: () async {
                        //     deleteStudent(context, state.postList[index].id);
                        //   },
                        //   icon: const Icon(Icons.delete, color: Colors.black),
                        // )
                     // ],
                   // ),
                  //),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.postList.length,
            );
          }
        },
      ),
      floatingActionButton: const FloatingButton(),
    );
  }
}
