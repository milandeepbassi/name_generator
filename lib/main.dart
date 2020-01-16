// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {/*
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          //child: Text('Hello World'),
          child: RandomWords(),
        ),
      ),
    );*/
    return MaterialApp(
      title: "Start up Name Generator",
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  @override
  final Set<WordPair> _saved = Set<WordPair>();   // Create a set to store saved words.
  final List<WordPair> _suggestions = <WordPair>[]; // Create a list to hold all items.
  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // Set font size.
  Widget build(BuildContext context) {
    //final WordPair wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);
    return Scaffold ( // Return the layout instead of just text.
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider(); // If the row is odd will add spacing.
          }
          final int index = i ~/ 2; // Converts row to inndex.
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); // Adds 10 items to list.
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);  // Checks for duplicated.
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border, // Adds the favorite icon with only a border
        color: alreadySaved ? Colors.red : null, // Makes it red if alreadySaved.
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          } else{
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
