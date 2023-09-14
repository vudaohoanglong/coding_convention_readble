import 'package:bloc/bloc.dart';

import '../Pokedex.dart';
part 'search_state.dart';

class searchCubit extends Cubit<state>{
  late final Pokedex pokedex;
  searchCubit(this.pokedex):super(searchInit());
  Future<void> searchPokemon(String name) async {
    emit(searchInit());
    emit(searchInit());
    Pokedex result = await pokedex.search(name);
    emit(searchState(result: result));
  }
}