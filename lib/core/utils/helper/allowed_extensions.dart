// these are supposed to come from the api

abstract class AllowedExtensions {
  static List<String> imagesTypes = [
    "png",
    "jpg",
    "jpeg",
    "svg",
  ];

  static List<String> documentsTypes = [
    "pdf",
  ];

  static List<String> archivesTypes = [
    "rar",
    "zip",
  ];

  static List<String> executablesTypes = [
    "pe32",
    "exe",
    "pe32+",
  ];

  static Map<String, List<String>> categories = {
    "Images": imagesTypes,
    "Documents": documentsTypes,
    "Archives": archivesTypes,
    "Executables": executablesTypes,
  };
}
