//I'm thinking I'll have a "game" class that will have one or more boards
//depending on whether the player is playing regular chess, 3D chess, or 4D
//chess.  I want to have an option for the player to switch game type.
class Game {
  Board Board = new Board();
  
  Square selected_square;
  Square null_square;
  Piece null_piece;
  
  // an array of type Piece; the array's named Pieces
  Piece[] Pieces;
  
  color white_player_color = color(0, 0, 150);
  color black_player_color = color(150, 0, 0);
  
  void ProcessSquareClick() {
    Square[] Squares = Board.Squares; //making a shorter name for Board.Squares
    for (int i=0; i < Squares.length; i++) {
      float square_side = Board.square_side;
      if ( overRect(Squares[i].screen_location[0], Squares[i].screen_location[1],
           square_side, square_side) ) {
        //deselect the square if it was already selected
        if (Squares[i].selected == true) {
          Board.Squares[i].selected = false;
          selected_square = null_square;
        //select the square if it wasn't selected
        } else if ((selected_square == null_square) &&
                   (Squares[i].selected == false)) {
          selected_square = Squares[i];
          Squares[i].selected = true;
        //if a piece is selected already, move it to the current square
        } else if ((selected_square.occupying_piece != null_piece) && 
                   (MoveAllowed(i))) {
          MovePiece(i);
        }
      }
    }
  } //end of ProcessSquareClick()
  
  boolean MoveAllowed(int destination_square_index) {
    //I need to fill this out.
    return true;
  }
  
  void MovePiece(int destination_square_index) {
    int i = destination_square_index; //renaming it to be shorter
    Square destination_square = Board.Squares[i];
    if (destination_square.occupying_piece == null_piece) {
      //I need to find a better way to set one array equal to another...(below)
      selected_square.occupying_piece.location[0] = 
                                           destination_square.board_location[0];
      selected_square.occupying_piece.location[1] = 
                                           destination_square.board_location[1];
      destination_square.occupying_piece = selected_square.occupying_piece;
      selected_square.occupying_piece = null_piece;
    //if there's an opponent's piece there already, then
      //remove the opponent's piece, set it to "captured"
      //move the selected piece to that square
    } else {
      
    }
    //deselect the selected square automatically\
    selected_square.selected = false;
    Square null_square = Chess.null_square;
    selected_square = null_square;
  } // end of MovePiece()

} //end of the Game class

//if the player is playing 3D/4D chess there will be multiple boards, each with
//their own x and y coordinates.
class Board {
  int board_x;
  int board_y;
  float board_width = 300;
  float board_height = 300;
  float square_side = board_width / 8;
  Square[] Squares;
  
  color black_square_color = color(0, 110, 0);
  color white_square_color = color(255, 255, 255);
  color square_selected_color = color(243, 255, 0);
  color square_border_color = color(0, 0, 0);
  
  Board() {
    board_x = int(screen_width * 0.25);
    board_y = int(screen_height * 0.1);
  }
}

class Piece {
  char side = 'W'; //white or black piece
  char type = 'P'; //every piece has a type (eg pawn, queen)
  int[] location = new int[] {0, 0}; //every piece has a location (eg h4, g7)
  
  Piece(char _side, char _type, int[] _location) {
    side = _side;
    type = _type;
    location = _location;
  }
}
class Square {
  String name; //the name of the square (eg h4, g7)
  //board_location is used for calculating moves of pieces; range: 0,0 to 8,8
  int[] board_location = new int[] {0, 0};
  //screen_location holds the pixel coordinates for drawing the square
  float[] screen_location = new float[] {0, 0};
  color square_color;
  Piece occupying_piece; //i may end up not using this
  boolean hovered_over; //tracks whether the mouse is hovering over the square
  boolean selected = false;
  int glow_loop_progress = 1; //an int from 1 to 100 used to make the square
                              //glow brighter and darker.
  
  Square(String _name, int[] _board_location,
         float[] _screen_location, color _square_color ) {
    name = _name;
    board_location = _board_location;
    screen_location = _screen_location;
    square_color = _square_color;
    //the loop below checks to see if any pieces are on the square.
    Piece[] Pieces = Chess.Pieces;
    for (int p = 0; p < Pieces.length; p++) {
      if ((Pieces[p].location[0] == board_location[0]) &&
          (Pieces[p].location[1] == board_location[1])) {
            occupying_piece = Pieces[p];
      }
    }
    Piece null_piece = Chess.null_piece;
    if (name == "null_square") { occupying_piece = null_piece; }
  }
} //end of class Square