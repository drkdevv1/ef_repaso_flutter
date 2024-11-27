import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
part 'database.g.dart';

class Breeds extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  IntColumn get energyLevel => integer().named('energyLevel')();
  TextColumn get description => text().named('description')();
  TextColumn get referenceImageId => text().named('referenceImageId')();
  TextColumn get temperament => text().named('temperament')();
  IntColumn get intelligence => integer().named('intelligence')();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase abrirConexion() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dbBreeds.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Breeds])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(abrirConexion());

  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;

  Future<int> insertBreed(BreedsCompanion breed) async {
    // Verificar si el Breed ya existe
    final existingBreed = await (select(breeds)
          ..where((tbl) => tbl.id.equals(breed.id.value)))
        .getSingleOrNull();
    if (existingBreed != null) {
      // Si ya existe, no realizar la inserción
      return 0;
    }
    return await into(breeds).insert(breed);
  }

  Future<List<Breed>> getListado() async {
    final breedList = await select(breeds).get();
    return breedList
        .map((breedData) => Breed(
              id: breedData.id,
              name: breedData.name,
              referenceImageId: breedData.referenceImageId,
              temperament: breedData.temperament,
              intelligence: breedData.intelligence,
            ))
        .toList();
  }

  Future<int> eliminarBreed(String id) async {
    return await (delete(breeds)..where((tbl) => tbl.id.equals(id))).go();
  }
}
