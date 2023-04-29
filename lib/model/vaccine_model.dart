class Vaccine {
  final String title;
  final String vaccineTime;
  final List<String> vaccinesList;

  Vaccine(this.title, this.vaccineTime, this.vaccinesList);

}

class VaccinePackage {
  List<String> mainTitles = [];
  int totalPackages = 0;
  List<int> psubLen = [];
  List<List<dynamic>> pBodies = [];
}
