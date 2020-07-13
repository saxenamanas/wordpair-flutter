import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class WordGenerator extends StatefulWidget{
  @override
  WordGeneratorState createState() => WordGeneratorState();
}

class WordGeneratorState extends State<WordGenerator>{
      final savedWords = Set<WordPair>();
      final _randomWordPairs = <WordPair>[];

  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item){
        if(item.isOdd)  return Divider();

        final index = item ~/2;

        if(index >= _randomWordPairs.length){
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = savedWords.contains(pair);
    return ListTile(
      onTap: (){
        setState(() {
        if(alreadySaved){
          savedWords.remove(pair);
        }else{
          savedWords.add(pair);
          print(savedWords);
        }
        });
      },
      title: Text(pair.asPascalCase,
      style: TextStyle(
        fontSize: 18.0
        ),
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,color: alreadySaved ? Colors.red : null),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('Word Pair Generator')),
      body:_buildList(),
      );
  }
}