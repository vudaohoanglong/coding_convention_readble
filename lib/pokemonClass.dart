class Pokemon {
  final List type;
  final int id;
  final String name;

  const Pokemon({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        id: json['id'],
        name: json['name']['english'],
        type: json['type']
    );
  }
}