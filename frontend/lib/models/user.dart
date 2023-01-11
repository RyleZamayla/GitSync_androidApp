class UserModel {
  final String id;
  String? bannerImageUrl, profileImageUrl, name, email;

  UserModel ({
    required this.id,
    this.bannerImageUrl,
    this.profileImageUrl,
    this.name,
    this.email
  });
}