class ChangePasswordModel {
  final String currentPassword;
  final String newPassword;

  ChangePasswordModel({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'current_password': currentPassword,
        'new_password': newPassword,
      };
}
