

import 'dart:ffi';

import 'Pokemon.dart';

class Search {
  static bool compare(String dest, String given) { // function to find if given is prefix of dest
    if (given.length>dest.length) return false;
    else {
      return (given == dest.substring(0,given.length).toLowerCase());
    }
  }
}

class Trie {
  int trie_size = 0; // size of trie
  List<Map<int,int>> trie_edges = [{}]; // list of edges form trie tree
  List<List<Pokemon>> trie_value = [[]]; // value for node in trie tree, which store all string indexes that go through this node.

  Trie(List<Pokemon> pokedex) {
    for (int i = 0; i < pokedex.length; ++i) {
      this.add(pokedex[i]);
    }
  }

  void add(Pokemon poketmonster) { // adding new Pokemon to trie
    int root = 0; // pointer travel through node, start at root = 0
    String name = poketmonster.name.toLowerCase();
    List<int> edgeList = name.codeUnits; // list to perform a path on trie a string
    for (int i = 0; i < poketmonster.name.length; ++i) {
      int edge = edgeList[i];
      int? next; // next node from this edge
      if (trie_edges[root][edge] == null) {
         next = new_node();
         trie_edges[root][edge] = next;
      }
      else next = trie_edges[root][edge];
      trie_value[next!].add(poketmonster);
      root = next;
    }
  }

  int new_node() {
    trie_value.add([]);
    trie_edges.add({});
    return ++trie_size;
  }

  List<Pokemon> get(String name) {
    int root = 0;
    var _id = name.codeUnits;
    for (int i = 0; i < _id.length; ++i) {
      int edge = _id[i];
      int? next; // next node from this edge
      if (trie_edges[root][edge] == null) {
        return [];
      }
      else next = trie_edges[root][edge];
      root = next!;
    }
    return trie_value[root];
  }
}

class Pokedex {
  Pokedex(this.pokedex) {
    pokedexTrie = Trie(pokedex);
    POKEDEX_SIZE=pokedex.length;
  }
  List<Pokemon> pokedex = [];
  late final int POKEDEX_SIZE;
  late final Trie pokedexTrie;
  // basic search. Iterate all pokemon in pokedex and compare with the given name
  // Time complexity is O(N*M) where N is number of index, and M is the length of string
  Pokedex basicSearch(String name) {
    List<Pokemon> _result = [];
    for (int i = 0; i < POKEDEX_SIZE; ++i){
      if (Search.compare(pokedex[i].name,name)) {
        _result.add(pokedex[i]);
      }
    }
    return Pokedex(_result);
  }
  
  Pokedex trieSearch(String name) {
    if (name=="") return Pokedex(pokedex);
    return Pokedex(pokedexTrie.get(name));
  }
  // using Trie data structure to search
  // Time complexity is O(M*Log2(N)) where

}