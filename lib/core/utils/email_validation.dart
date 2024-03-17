bool validateEmail(String email) {
  // Regular expression pattern for email validation
  const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
  
  // Create a RegExp object with the pattern
  final regExp = RegExp(pattern);
  
  // Check if the email matches the pattern
  return regExp.hasMatch(email);
}
