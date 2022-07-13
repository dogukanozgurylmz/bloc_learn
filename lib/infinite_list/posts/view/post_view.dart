import 'package:bloc_learn/infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (BuildContext context, state) {
          if (state.status == PostStatus.failure) {
            return const Center(child: Text("Bir hata var"));
          }
          if (state.status == PostStatus.success) {
            if (state.posts.isEmpty) {
              return const Center(child: Text("Post yok"));
            }
            return ListView.builder(
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return index >= state.posts.length
                    ? Center(
                        child: Column(
                          children: const [
                            CircularProgressIndicator(),
                            Text('Postlar yükleniyor'),
                          ],
                        ),
                      )
                    : ListTile(
                        leading: Text('${state.posts[index].id}'),
                        title: Text('${state.posts[index].title}'),
                        subtitle: Text('${state.posts[index].body}'),
                      );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
