class UserModel {
  String? id, email;
  String name, bannerImageUrl, profileImageUrl;

  UserModel ({
    this.id,
    this.bannerImageUrl = '',
    this.profileImageUrl = '',
    this.name = '',
    this.email
  });
}