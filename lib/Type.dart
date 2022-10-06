import 'package:flutter/material.dart';
Widget typeTag(dynamic e){
  if (e=='Poison'){
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.purple,
      ),
      child: Text(
        e,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }
  if (e=='Grass'){
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.lightGreen,
      ),
      child: Text(
        e,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }
  if (e=='Bug'){
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.green,
      ),
      child: Text(
        e,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }
  if (e=='Fairy'){
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.pink[100],
      ),
      child: Text(
        e,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }
  if (e=='Fire'){
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.deepOrange,
      ),
      child: Text(
        e,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }
  if (e=='Ghost'){
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.deepPurple[400],
      ),
      child: Text(
        e,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }
  if (e=='Ghost'){
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.deepPurple[400],
      ),
      child: Text(
        e,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }
  if (e=='Dragon'){
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.deepPurple[400],
      ),
      child: Text(
        e,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }
  return Container();
}