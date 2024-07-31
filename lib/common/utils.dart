/// Returns the initials of a given full name.
///
/// Takes a full name as input and returns the first character of the first
/// and last words concatenated together in uppercase. If there is only one
/// word, it returns the first character of that word.
///
/// Example:
/// ```
/// String initials = getInitials("John Doe"); // "JD"
/// String initials = getInitials("John"); // "J"
/// ```
String getInitials(String fullName) {
  List<String> names = fullName.split(" ");
  String initials = "";
  if (names.length > 1) {
    initials = names[0][0] + names[1][0];
  } else if (names.length == 1) {
    initials = names[0][0];
  }
  return initials.toUpperCase();
}
