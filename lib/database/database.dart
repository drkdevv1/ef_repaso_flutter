import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
part 'database.g.dart';

class Breeds extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
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
  AppDatabase() : super(abrirConexion());

  @override
  int get schemaVersion => 1;

  Future<int> insertBreed(BreedsCompanion breed) async {
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
