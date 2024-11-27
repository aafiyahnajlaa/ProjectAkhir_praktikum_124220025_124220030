class book {
  final int? page;
  final int? numFound;
  final List<ReadingLogEntries>? readingLogEntries;

  book({
    this.page,
    this.numFound,
    this.readingLogEntries,
  });

  book.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        numFound = json['numFound'] as int?,
        readingLogEntries = (json['reading_log_entries'] as List?)?.map((dynamic e) => ReadingLogEntries.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'page' : page,
    'numFound' : numFound,
    'reading_log_entries' : readingLogEntries?.map((e) => e.toJson()).toList()
  };
}

class ReadingLogEntries {
  final Work? work;
  final String? loggedEdition;
  final String? loggedDate;

  ReadingLogEntries({
    this.work,
    this.loggedEdition,
    this.loggedDate,
  });

  ReadingLogEntries.fromJson(Map<String, dynamic> json)
      : work = (json['work'] as Map<String,dynamic>?) != null ? Work.fromJson(json['work'] as Map<String,dynamic>) : null,
        loggedEdition = json['logged_edition'] as String?,
        loggedDate = json['logged_date'] as String?;

  Map<String, dynamic> toJson() => {
    'work' : work?.toJson(),
    'logged_edition' : loggedEdition,
    'logged_date' : loggedDate
  };
}

class Work {
  final String? title;
  final String? key;
  final List<String>? authorKeys;
  final List<String>? authorNames;
  final int? firstPublishYear;
  final String? lendingEditionS;
  final List<String>? editionKey;
  final int? coverId;
  final String? coverEditionKey;

  Work({
    this.title,
    this.key,
    this.authorKeys,
    this.authorNames,
    this.firstPublishYear,
    this.lendingEditionS,
    this.editionKey,
    this.coverId,
    this.coverEditionKey,
  });

  Work.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        key = json['key'] as String?,
        authorKeys = (json['author_keys'] as List?)?.map((dynamic e) => e as String).toList(),
        authorNames = (json['author_names'] as List?)?.map((dynamic e) => e as String).toList(),
        firstPublishYear = json['first_publish_year'] as int?,
        lendingEditionS = json['lending_edition_s'] as String?,
        editionKey = (json['edition_key'] as List?)?.map((dynamic e) => e as String).toList(),
        coverId = json['cover_id'] as int?,
        coverEditionKey = json['cover_edition_key'] as String?;

  Map<String, dynamic> toJson() => {
    'title' : title,
    'key' : key,
    'author_keys' : authorKeys,
    'author_names' : authorNames,
    'first_publish_year' : firstPublishYear,
    'lending_edition_s' : lendingEditionS,
    'edition_key' : editionKey,
    'cover_id' : coverId,
    'cover_edition_key' : coverEditionKey
  };
}