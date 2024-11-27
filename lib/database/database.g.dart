// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Breed extends DataClass implements Insertable<Breed> {
  final String id;
  final String name;
  final String referenceImageId;
  final String temperament;
  final int intelligence;
  Breed(
      {required this.id,
      required this.name,
      required this.referenceImageId,
      required this.temperament,
      required this.intelligence});
  factory Breed.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Breed(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      referenceImageId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}referenceImageId'])!,
      temperament: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}temperament'])!,
      intelligence: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}intelligence'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['referenceImageId'] = Variable<String>(referenceImageId);
    map['temperament'] = Variable<String>(temperament);
    map['intelligence'] = Variable<int>(intelligence);
    return map;
  }

  BreedsCompanion toCompanion(bool nullToAbsent) {
    return BreedsCompanion(
      id: Value(id),
      name: Value(name),
      referenceImageId: Value(referenceImageId),
      temperament: Value(temperament),
      intelligence: Value(intelligence),
    );
  }

  factory Breed.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Breed(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      referenceImageId: serializer.fromJson<String>(json['referenceImageId']),
      temperament: serializer.fromJson<String>(json['temperament']),
      intelligence: serializer.fromJson<int>(json['intelligence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'referenceImageId': serializer.toJson<String>(referenceImageId),
      'temperament': serializer.toJson<String>(temperament),
      'intelligence': serializer.toJson<int>(intelligence),
    };
  }

  Breed copyWith(
          {String? id,
          String? name,
          String? referenceImageId,
          String? temperament,
          int? intelligence}) =>
      Breed(
        id: id ?? this.id,
        name: name ?? this.name,
        referenceImageId: referenceImageId ?? this.referenceImageId,
        temperament: temperament ?? this.temperament,
        intelligence: intelligence ?? this.intelligence,
      );
  @override
  String toString() {
    return (StringBuffer('Breed(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('referenceImageId: $referenceImageId, ')
          ..write('temperament: $temperament, ')
          ..write('intelligence: $intelligence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, referenceImageId, temperament, intelligence);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Breed &&
          other.id == this.id &&
          other.name == this.name &&
          other.referenceImageId == this.referenceImageId &&
          other.temperament == this.temperament &&
          other.intelligence == this.intelligence);
}

class BreedsCompanion extends UpdateCompanion<Breed> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> referenceImageId;
  final Value<String> temperament;
  final Value<int> intelligence;
  const BreedsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.referenceImageId = const Value.absent(),
    this.temperament = const Value.absent(),
    this.intelligence = const Value.absent(),
  });
  BreedsCompanion.insert({
    required String id,
    required String name,
    required String referenceImageId,
    required String temperament,
    required int intelligence,
  })  : id = Value(id),
        name = Value(name),
        referenceImageId = Value(referenceImageId),
        temperament = Value(temperament),
        intelligence = Value(intelligence);
  static Insertable<Breed> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? referenceImageId,
    Expression<String>? temperament,
    Expression<int>? intelligence,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (referenceImageId != null) 'referenceImageId': referenceImageId,
      if (temperament != null) 'temperament': temperament,
      if (intelligence != null) 'intelligence': intelligence,
    });
  }

  BreedsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? referenceImageId,
      Value<String>? temperament,
      Value<int>? intelligence}) {
    return BreedsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      referenceImageId: referenceImageId ?? this.referenceImageId,
      temperament: temperament ?? this.temperament,
      intelligence: intelligence ?? this.intelligence,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (referenceImageId.present) {
      map['referenceImageId'] = Variable<String>(referenceImageId.value);
    }
    if (temperament.present) {
      map['temperament'] = Variable<String>(temperament.value);
    }
    if (intelligence.present) {
      map['intelligence'] = Variable<int>(intelligence.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BreedsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('referenceImageId: $referenceImageId, ')
          ..write('temperament: $temperament, ')
          ..write('intelligence: $intelligence')
          ..write(')'))
        .toString();
  }
}

class $BreedsTable extends Breeds with TableInfo<$BreedsTable, Breed> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BreedsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _referenceImageIdMeta =
      const VerificationMeta('referenceImageId');
  @override
  late final GeneratedColumn<String?> referenceImageId =
      GeneratedColumn<String?>('referenceImageId', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _temperamentMeta =
      const VerificationMeta('temperament');
  @override
  late final GeneratedColumn<String?> temperament = GeneratedColumn<String?>(
      'temperament', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _intelligenceMeta =
      const VerificationMeta('intelligence');
  @override
  late final GeneratedColumn<int?> intelligence = GeneratedColumn<int?>(
      'intelligence', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, referenceImageId, temperament, intelligence];
  @override
  String get aliasedName => _alias ?? 'breeds';
  @override
  String get actualTableName => 'breeds';
  @override
  VerificationContext validateIntegrity(Insertable<Breed> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('referenceImageId')) {
      context.handle(
          _referenceImageIdMeta,
          referenceImageId.isAcceptableOrUnknown(
              data['referenceImageId']!, _referenceImageIdMeta));
    } else if (isInserting) {
      context.missing(_referenceImageIdMeta);
    }
    if (data.containsKey('temperament')) {
      context.handle(
          _temperamentMeta,
          temperament.isAcceptableOrUnknown(
              data['temperament']!, _temperamentMeta));
    } else if (isInserting) {
      context.missing(_temperamentMeta);
    }
    if (data.containsKey('intelligence')) {
      context.handle(
          _intelligenceMeta,
          intelligence.isAcceptableOrUnknown(
              data['intelligence']!, _intelligenceMeta));
    } else if (isInserting) {
      context.missing(_intelligenceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Breed map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Breed.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BreedsTable createAlias(String alias) {
    return $BreedsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $BreedsTable breeds = $BreedsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [breeds];
}
