class TenorEntity {
  final String id;
  final String preview;
  final String url;

  TenorEntity({
    required this.id,
    required this.preview,
    required this.url,
  });

  factory TenorEntity.fromJson(Map<String, dynamic> json) {
    return TenorEntity(
      id: json['results'][0]['id'],
      preview: json['results'][0]['id'],
      url: json['results'][0]['media_formats']['tinygif']['url'],
    );
  }

  TenorEntity.empty()
      : id = '',
        preview = '',
        url = '';
}

class TenorAutoComplete {
  final List autoComplete;

  TenorAutoComplete({
    required this.autoComplete,
  });

  factory TenorAutoComplete.fromJson(Map<String, dynamic> json) {
    return TenorAutoComplete(
      autoComplete: json['results'],
    );
  }

  TenorAutoComplete.empty() : autoComplete = [];
}
