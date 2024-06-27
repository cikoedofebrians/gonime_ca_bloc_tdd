import 'package:equatable/equatable.dart';

class Manga extends Equatable {
  const Manga({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.title,
    required this.score,
    required this.synopsis,
  });

  final int? malId;
  final String? url;
  final String? imageUrl;
  final String? title;
  final num? score;
  final String? synopsis;

  @override
  List<Object?> get props => [malId];

  const Manga.dummy()
      : this(
          malId: 1,
          imageUrl: 'https://cdn.myanimelist.net/images/manga/3/258224.jpg',
          score: 9.16,
          synopsis:
              "Kenzou Tenma, a renowned Japanese neurosurgeon working in post-war Germany, faces a difficult choice: to operate on Johan Liebert, an orphan boy on the verge of death, or on the mayor of Düsseldorf. In the end, Tenma decides to gamble his reputation by saving Johan, effectively leaving the mayor for dead. As a consequence of his actions, hospital director Heinemann strips Tenma of his position, and Heinemann's daughter Eva breaks off their engagement. Disgraced and shunned by his colleagues, Tenma loses all hope of a successful career—that is, until the mysterious killing of Heinemann gives him another chance. Nine years later, Tenma is the head of the surgical department and close to becoming the director himself. Although all seems well for him at first, he soon becomes entangled in a chain of gruesome murders that have taken place throughout Germany. The culprit is a monster—the same one that Tenma saved on that fateful day nine years ago. [Written by MAL Rewrite]",
          title: 'Monster',
          url: 'https://myanimelist.net/manga/1/Monster',
        );
}
