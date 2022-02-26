abstract class Listable {
  String? trailing() => null;

  const Listable();
  String title();
  String searchTerm() {
    return toString();
  }

  String? leading() => null;
}
