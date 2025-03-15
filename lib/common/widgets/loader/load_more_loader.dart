import 'package:flutter/material.dart';

class LoadMoreLoader extends StatefulWidget {
  const LoadMoreLoader({required this.onLoadMore, super.key});

  final VoidCallback onLoadMore;

  @override
  State<LoadMoreLoader> createState() => _LoadMoreLoaderState();
}

class _LoadMoreLoaderState extends State<LoadMoreLoader> {
  @override
  void initState() {
    super.initState();
    widget.onLoadMore();
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
