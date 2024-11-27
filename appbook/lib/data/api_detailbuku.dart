class Detailbooks {
  final Identifiers? identifiers;
  final String? title;
  final List<Authors>? authors;
  final String? publishDate;
  final List<String>? publishers;
  final List<int>? covers;
  final List<String>? contributions;
  final List<Languages>? languages;
  final List<String>? sourceRecords;
  final List<String>? localId;
  final Type? type;
  final FirstSentence? firstSentence;
  final String? key;
  final int? numberOfPages;
  final List<Works>? works;
  final Classifications? classifications;
  final String? ocaid;
  final List<String>? isbn10;
  final List<String>? isbn13;
  final int? latestRevision;
  final int? revision;
  final Created? created;
  final LastModified? lastModified;

  Detailbooks({
    this.identifiers,
    this.title,
    this.authors,
    this.publishDate,
    this.publishers,
    this.covers,
    this.contributions,
    this.languages,
    this.sourceRecords,
    this.localId,
    this.type,
    this.firstSentence,
    this.key,
    this.numberOfPages,
    this.works,
    this.classifications,
    this.ocaid,
    this.isbn10,
    this.isbn13,
    this.latestRevision,
    this.revision,
    this.created,
    this.lastModified,
  });

  Detailbooks.fromJson(Map<String, dynamic> json)
      : identifiers = (json['identifiers'] as Map<String,dynamic>?) != null ? Identifiers.fromJson(json['identifiers'] as Map<String,dynamic>) : null,
        title = json['title'] as String?,
        authors = (json['authors'] as List?)?.map((dynamic e) => Authors.fromJson(e as Map<String,dynamic>)).toList(),
        publishDate = json['publish_date'] as String?,
        publishers = (json['publishers'] as List?)?.map((dynamic e) => e as String).toList(),
        covers = (json['covers'] as List?)?.map((dynamic e) => e as int).toList(),
        contributions = (json['contributions'] as List?)?.map((dynamic e) => e as String).toList(),
        languages = (json['languages'] as List?)?.map((dynamic e) => Languages.fromJson(e as Map<String,dynamic>)).toList(),
        sourceRecords = (json['source_records'] as List?)?.map((dynamic e) => e as String).toList(),
        localId = (json['local_id'] as List?)?.map((dynamic e) => e as String).toList(),
        type = (json['type'] as Map<String,dynamic>?) != null ? Type.fromJson(json['type'] as Map<String,dynamic>) : null,
        firstSentence = (json['first_sentence'] as Map<String,dynamic>?) != null ? FirstSentence.fromJson(json['first_sentence'] as Map<String,dynamic>) : null,
        key = json['key'] as String?,
        numberOfPages = json['number_of_pages'] as int?,
        works = (json['works'] as List?)?.map((dynamic e) => Works.fromJson(e as Map<String,dynamic>)).toList(),
        classifications = (json['classifications'] as Map<String,dynamic>?) != null ? Classifications.fromJson(json['classifications'] as Map<String,dynamic>) : null,
        ocaid = json['ocaid'] as String?,
        isbn10 = (json['isbn_10'] as List?)?.map((dynamic e) => e as String).toList(),
        isbn13 = (json['isbn_13'] as List?)?.map((dynamic e) => e as String).toList(),
        latestRevision = json['latest_revision'] as int?,
        revision = json['revision'] as int?,
        created = (json['created'] as Map<String,dynamic>?) != null ? Created.fromJson(json['created'] as Map<String,dynamic>) : null,
        lastModified = (json['last_modified'] as Map<String,dynamic>?) != null ? LastModified.fromJson(json['last_modified'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'identifiers' : identifiers?.toJson(),
    'title' : title,
    'authors' : authors?.map((e) => e.toJson()).toList(),
    'publish_date' : publishDate,
    'publishers' : publishers,
    'covers' : covers,
    'contributions' : contributions,
    'languages' : languages?.map((e) => e.toJson()).toList(),
    'source_records' : sourceRecords,
    'local_id' : localId,
    'type' : type?.toJson(),
    'first_sentence' : firstSentence?.toJson(),
    'key' : key,
    'number_of_pages' : numberOfPages,
    'works' : works?.map((e) => e.toJson()).toList(),
    'classifications' : classifications?.toJson(),
    'ocaid' : ocaid,
    'isbn_10' : isbn10,
    'isbn_13' : isbn13,
    'latest_revision' : latestRevision,
    'revision' : revision,
    'created' : created?.toJson(),
    'last_modified' : lastModified?.toJson()
  };
}

class Identifiers {
  final List<String>? goodreads;
  final List<String>? librarything;

  Identifiers({
    this.goodreads,
    this.librarything,
  });

  Identifiers.fromJson(Map<String, dynamic> json)
      : goodreads = (json['goodreads'] as List?)?.map((dynamic e) => e as String).toList(),
        librarything = (json['librarything'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'goodreads' : goodreads,
    'librarything' : librarything
  };
}

class Authors {
  final String? key;

  Authors({
    this.key,
  });

  Authors.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String?;

  Map<String, dynamic> toJson() => {
    'key' : key
  };
}

class Languages {
  final String? key;

  Languages({
    this.key,
  });

  Languages.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String?;

  Map<String, dynamic> toJson() => {
    'key' : key
  };
}

class Type {
  final String? key;

  Type({
    this.key,
  });

  Type.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String?;

  Map<String, dynamic> toJson() => {
    'key' : key
  };
}

class FirstSentence {
  final String? type;
  final String? value;

  FirstSentence({
    this.type,
    this.value,
  });

  FirstSentence.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        value = json['value'] as String?;

  Map<String, dynamic> toJson() => {
    'type' : type,
    'value' : value
  };
}

class Works {
  final String? key;

  Works({
    this.key,
  });

  Works.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String?;

  Map<String, dynamic> toJson() => {
    'key' : key
  };
}

class Classifications {


  Classifications(

);

Classifications.fromJson(Map<String, dynamic> json) ;

Map<String, dynamic> toJson() => {

};
}

class Created {
final String? type;
final String? value;

Created({
this.type,
this.value,
});

Created.fromJson(Map<String, dynamic> json)
    : type = json['type'] as String?,
value = json['value'] as String?;

Map<String, dynamic> toJson() => {
'type' : type,
'value' : value
};
}

class LastModified {
final String? type;
final String? value;

LastModified({
this.type,
this.value,
});

LastModified.fromJson(Map<String, dynamic> json)
    : type = json['type'] as String?,
value = json['value'] as String?;

Map<String, dynamic> toJson() => {
'type' : type,
'value' : value
};
}