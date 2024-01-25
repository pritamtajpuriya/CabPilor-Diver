bool isFullNameValid(String fullName) {
  if (fullName.isEmpty) {
    return false; // Name is empty
  }

  List<String> nameParts = fullName.trim().split(' ');

  if (nameParts.length < 2) {
    return false; // First and last name required
  }

  return true; // Full name is valid
}

String formatTimeDifference(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'Just now';
  }
}
