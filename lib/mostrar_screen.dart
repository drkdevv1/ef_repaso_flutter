import 'package:drift/drift.dart' as drift;
import 'package:ef_repaso_flutter/api/Breed.dart' as api;
import 'package:ef_repaso_flutter/api/Service.dart';
import 'package:flutter/material.dart';
import 'package:ef_repaso_flutter/database/database.dart' as db;

class MostrarScreen extends StatefulWidget {
  const MostrarScreen({super.key});

  @override
  State<MostrarScreen> createState() => _MostrarScreenState();
}

class _MostrarScreenState extends State<MostrarScreen> {
  late Future<List<api.Breed>> futureBreeds;
  final Set<String> _favoriteBreeds = {};
  late db.AppDatabase _database;

  @override
  void initState() {
    super.initState();
    _database = db.AppDatabase();
    _loadFavorites();
    futureBreeds = Service.getAllBreeds();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _database.getListado();
    setState(() {
      _favoriteBreeds.addAll(favorites.map((breed) => breed.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breeds'),
      ),
      body: FutureBuilder<List<api.Breed>>(
        future: futureBreeds,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No breeds found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final breed = snapshot.data![index];
                final isFavorite = _favoriteBreeds.contains(breed.id);
                return Card(
                  child: Column(
                    children: [
                      breed.referenceImageId.isNotEmpty
                          ? Image.network(
                              'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg',
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
                      ListTile(
                        title: Text(breed.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(breed.description),
                            Slider(
                              value: breed.energyLevel.toDouble(),
                              min: 0,
                              max: 5,
                              divisions: 5,
                              label: breed.energyLevel.toString(),
                              onChanged: null, // Slider de solo lectura
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () async {
                            setState(() {
                              if (isFavorite) {
                                _favoriteBreeds.remove(breed.id);
                                _database.eliminarBreed(breed.id);
                              } else {
                                _favoriteBreeds.add(breed.id);
                                _database.insertBreed(db.BreedsCompanion(
                                  id: drift.Value(breed.id),
                                  name: drift.Value(breed.name),
                                  referenceImageId:
                                      drift.Value(breed.referenceImageId),
                                  temperament: drift.Value(breed.temperament),
                                  intelligence: drift.Value(breed.intelligence),
                                ));
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
