import 'package:flutter/material.dart';
import 'package:paniyaal/screens/jobTypeScreen/carpenter_screen.dart';

class FavoriteButton extends StatefulWidget {
  final String itemId;
  final Function onFavoriteChanged;

  FavoriteButton({required this.itemId, required this.onFavoriteChanged,});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    widget.onFavoriteChanged(widget.itemId, _isFavorited);
  }

  CarpenterScreen carpenter = CarpenterScreen();
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: (_isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
      label: Text('Save'),
      onPressed: (){
      },
    );
  }
}

