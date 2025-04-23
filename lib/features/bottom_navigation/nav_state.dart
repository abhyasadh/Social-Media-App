import 'package:flutter/material.dart';
import 'package:yaallo/features/home/presentation/home_view.dart';
import 'package:yaallo/features/jobs/presentation/job_view.dart';
import 'package:yaallo/features/menu/presentation/menu_view.dart';
import 'package:yaallo/features/message/presentation/message_view.dart';
import 'package:yaallo/features/search/presentation/search_view.dart';

class NavState {
  final Map<String, dynamic>? userData;
  final int index;
  final List<Widget> listWidgets;

  NavState({
    this.userData,
    required this.index,
    required this.listWidgets,
  });

  NavState.initialState()
      : userData = {},
        index = 0,
        listWidgets = [
          const HomeView(),
          const SearchView(),
          const MessageView(),
          const JobView(),
          const MenuView(),
        ];

  NavState copyWith({
    Map<String, dynamic>? userData,
    int? index,
  }) {
    return NavState(
      userData: userData ?? this.userData,
      index: index ?? this.index,
      listWidgets: listWidgets,
    );
  }
}
