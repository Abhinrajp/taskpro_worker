class Customfunctions {
  String extractplace(String location) {
    List<String> parts = location.split(',');
    parts = parts.map((part) => part.trim()).toList();
    if (parts.length >= 4) {
      if (parts[parts.length - 3].isNotEmpty) {
        return parts[parts.length - 3];
      } else {
        return parts[parts.length - 4];
      }
    } else if (parts.length >= 3) {
      return parts[parts.length - 3];
    }
    return 'Unknown';
  }
}
