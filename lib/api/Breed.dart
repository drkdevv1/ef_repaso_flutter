class Breed {
  final String id;
  final String name;
  final int energyLevel;
  final String description;
  final String referenceImageId;
  final String temperament;
  final int intelligence;

  Breed({
    required this.id,
    required this.name,
    required this.energyLevel,
    required this.description,
    required this.referenceImageId,
    required this.temperament,
    required this.intelligence,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      energyLevel: json['energy_level'] ?? 0,
      description: json['description'] ?? '',
      referenceImageId: json['reference_image_id'] ?? '',
      temperament: json['temperament'] ?? '',
      intelligence: json['intelligence'] ?? 0,
    );
  }
}
