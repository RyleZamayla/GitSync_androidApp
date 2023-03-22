class UserModel {
  String? id, email;
  String name, profileImageUrl;

  UserModel ({
    this.id,
    this.profileImageUrl = '',
    this.name = '',
    this.email
  });
}