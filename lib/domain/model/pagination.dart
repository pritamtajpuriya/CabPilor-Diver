class Pagination {
  int? currentPage;
  int? lastPage;

  Pagination({this.currentPage, this.lastPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  // empty constructor

  Pagination.empty() {
    currentPage = 0;
    lastPage = 0;
  }
}
