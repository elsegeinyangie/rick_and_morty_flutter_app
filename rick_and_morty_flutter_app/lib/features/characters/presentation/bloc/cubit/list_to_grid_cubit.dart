import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_to_grid_state.dart';

class ListToGridCubit extends Cubit<ListToGridState> {
  ListToGridCubit() : super(ListToGridInitial());
}
