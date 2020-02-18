import 'package:flutter/material.dart';
import 'package:firestore_basic/models/brew.dart';
import 'package:provider/provider.dart';
import 'brew_tile.dart';




class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brew = Provider.of<List<Brew>>(context) ?? [];
    
    return ListView.builder(
      itemCount: brew.length,
      itemBuilder: (context,index){
        return BrewTile(brew :brew[index]);
      },
    );
  }
}