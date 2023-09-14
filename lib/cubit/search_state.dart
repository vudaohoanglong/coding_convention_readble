part of 'search_cubit.dart';


abstract class state {
  state();
}

class searchInit extends state {
  searchInit();
}

class searchState extends state {
  late final Pokedex result;
  searchState({required this.result});
}