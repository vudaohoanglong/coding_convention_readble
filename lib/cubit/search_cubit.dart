import 'package:bloc/bloc.dart';

import '../model/Pokedex.dart';
part 'search_state.dart';

class searchCubit extends Cubit<state> {
  late final Pokedex pokedex;
  searchCubit(this.pokedex):super(searchInit());
  Future<void> searchPokemon(String name) async {
    emit(searchInit());
    emit(searchInit());
    Pokedex result = await pokedex.trieSearch(name); // using trie to search
    emit(searchState(result: result));
  }
}