import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;
  String name;
  int gamesWonvsComputer;
  int gamesWonvsPlayer;
  int gamesPlayedvsComputer;
  int gamesPlayedvsPlayer;
  int consectiveWins;

  User( { this.id = 0 , required this.name , required this.gamesPlayedvsComputer , required this.gamesPlayedvsPlayer, required this.gamesWonvsComputer ,required this.gamesWonvsPlayer , required this.consectiveWins } );
}
