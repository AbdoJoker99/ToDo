class MyUser {
  static const String collectionName = 'users';
  String id;
  String name;
  String email;

  MyUser({required this.id, required this.name, required this.email});

  MyUser.fromFirestore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String,
          name: data['name'],
          email: data['email'],
        );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
