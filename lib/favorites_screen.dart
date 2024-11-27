import 'package:flutter/material.dart';
import 'package:ef_repaso_flutter/database/database.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late AppDatabase _database;
  late Future<List<Breed>> futureFavorites;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
    futureFavorites = _database.getListado();
  }

  Future<void> _refreshFavorites() async {
    setState(() {
      futureFavorites = _database.getListado();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder<List<Breed>>(
        future: futureFavorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final breed = snapshot.data![index];
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
                            Text(breed.temperament),
                            Text(breed.intelligence.toString()),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await _database.eliminarBreed(breed.id);
                            _refreshFavorites();
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
