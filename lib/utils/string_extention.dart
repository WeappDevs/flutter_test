extension StringExtension on String {
  String get maskedEmail {
    // Check if the email is valid
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(this)) {
      return 'Invalid email address';
    }

    // Split the email address into username and domain
    List<String> parts = split('@');
    String username = parts[0];
    String domain = parts[1];

    // Keep the first two characters of the username unchanged
    String maskedUsername = '${username.substring(0, 3)}${'*' * (username.length - 2)}';

    // Construct the masked email address
    return '$maskedUsername@$domain';
  }
}
