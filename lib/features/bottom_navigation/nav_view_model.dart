import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'nav_state.dart';

final navViewModelProvider = StateNotifierProvider<NavViewModel, NavState>(
  (ref) => NavViewModel(),
);

class NavViewModel extends StateNotifier<NavState> {
  NavViewModel() : super(NavState.initialState());

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }

  Future<void> updateUser({Map<String, dynamic>? data}) async {
    if (data != null){
      state = state.copyWith(userData: data);
      return;
    }
  }
}
