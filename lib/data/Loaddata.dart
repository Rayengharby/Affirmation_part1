import '../../domain/affirmation.dart';
import 'AppConstant.dart';

List<Affirmation> loaddata() {
  // Assurez-vous que les listes ont la même longueur
  final length = affirmations.length < photos.length ? affirmations.length : photos.length;

  return List.generate(
    length,
    (index) => Affirmation(
      image: photos[index],
      desc: affirmations[index],
    ),
  );
}
