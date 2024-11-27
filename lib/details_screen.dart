import 'package:flutter/material.dart';
import 'package:ef_repaso_flutter/api/Breed.dart';
import 'package:ef_repaso_flutter/database/database.dart' as db;
import 'package:drift/drift.dart' as drift;

class DetailsScreen extends StatefulWidget {
  final Breed breed;

  const DetailsScreen({Key? key, required this.breed}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late db.AppDatabase _database;
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _database = db.AppDatabase();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final favorites = await _database.getListado();
    setState(() {
      isFavorite = favorites.any((breed) => breed.id == widget.breed.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.breed.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.breed.referenceImageId.isNotEmpty
                ? Image.network(
                    'https://cdn2.thecatapi.com/images/${widget.breed.referenceImageId}.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      );
                    },
                  )
                : const Icon(
                    Icons.image_not_supported,
                    size: 100,
                    color: Colors.grey,
                  ),
            Text(
              'Intelligence: ${widget.breed.intelligence}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Temperament: ${widget.breed.temperament}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () async {
                    setState(() {
                      if (isFavorite) {
                        _database.eliminarBreed(widget.breed.id);
                      } else {
                        _database.insertBreed(db.BreedsCompanion(
                          id: drift.Value(widget.breed.id),
                          name: drift.Value(widget.breed.name),
                          referenceImageId:
                              drift.Value(widget.breed.referenceImageId),
                          temperament: drift.Value(widget.breed.temperament),
                          intelligence: drift.Value(widget.breed.intelligence),
                        ));
                      }
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
