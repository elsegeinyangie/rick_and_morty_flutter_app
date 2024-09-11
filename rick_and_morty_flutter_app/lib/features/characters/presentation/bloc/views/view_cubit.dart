import 'package:bloc/bloc.dart';

enum ViewType { list, grid }

class ViewCubit extends Cubit<ViewType> {
  ViewCubit() : super(ViewType.list);

  void toggleView() {
    if (state == ViewType.list) {
      emit(ViewType.grid);
    } else {
      emit(ViewType.list);
    }
  }
}
