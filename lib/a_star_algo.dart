import 'dart:math';
import 'package:tuple/tuple.dart';

import 'const.dart';
import 'map_path_set.dart';

typedef Pair = Tuple2<int, int>;
typedef pPair = Tuple2<double, Pair>;

int ROW = 9;
int COL = 10;

class Cell {
  int parent_i;
  int parent_j;
  double f;
  double g;
  double h;

  Cell(
      {this.parent_i = -1,
      this.parent_j = -1,
      this.f = double.infinity,
      this.g = double.infinity,
      this.h = double.infinity});
}

// A Utility Function to check whether given cell (row, col)
// is a valid cell or not.
bool isValid(int row, int col) {
  // Returns true if row number and column number
  // is in range
  return (row >= 0) && (row < ROW) && (col >= 0) && (col < COL);
}

// A Utility Function to check whether the given cell is
// blocked or not
bool isUnBlocked(List<List<int>> grid, int row, int col) {
  // Returns true if the cell is not blocked else false
  return grid[row][col] == 1 ? true : false;
}

// A Utility Function to check whether the destination cell has
// been reached or not
bool isDestination(int row, int col, Pair dest) {
  return row == dest.item1 && col == dest.item2 ? true : false;
}

// A Utility Function to calculate the 'h' heuristics.
double calculateHValue(int row, int col, Pair dest) {
  // Return using the distance formula
  return ((sqrt(
    (row - dest.item1) * (row - dest.item1) +
        (col - dest.item2) * (col - dest.item2),
  )));
}

// A Utility Function to trace the path from the source
// to destination
tracePath(List<List<Cell>> cellDetails, Pair dest) {
  print("\nThe Path is ");
  int row = dest.item1;
  int col = dest.item2;

  List<Pair> path = [];

  while (!(cellDetails[row][col].parent_i == row &&
      cellDetails[row][col].parent_j == col)) {
    path.add(Pair(row, col));
    int temp_row = cellDetails[row][col].parent_i;
    int temp_col = cellDetails[row][col].parent_j;
    row = temp_row;
    col = temp_col;
  }

  path.add(Pair(row, col));
  for (int i = 0; i < path.length; i++) {
    Pair p = path[i];
    print("-> (${p.item1},${p.item2}) ");
  }

  return path;
}

// A Function to find the shortest path between
// a given source cell to a destination cell according
// to A* Search Algorithm
aStarSearch(List<List<int>> grid, Pair src, Pair dest) {
  // If the source is out of range
  if (!isValid(src.item1, src.item2)) {
    print("Source is invalid 1");
    return;
  }

  // If the destination is out of range
  if (!isValid(dest.item1, dest.item2)) {
    print("Destination is invalid");
    return;
  }

  // Either the source or the destination is blocked
  if (!isUnBlocked(grid, src.item1, src.item2) ||
      !isUnBlocked(grid, dest.item1, dest.item2)) {
    print("Source or the destination is blocked");
    return;
  }

  // If the destination cell is the same as the source cell
  if (isDestination(src.item1, src.item2, dest)) {
    print("We are already at the destination");
    return;
  }

  // Create a closed list and initialise it to false which
  // means that no cell has been included yet. This closed
  // list is implemented as a boolean 2D array.
  List<List<bool>> closedList = List.generate(
    ROW,
    (i) => List.generate(COL, (j) => false),
  );

  // Declare a 2D array of structure to hold the details
  // of that cell
  List<List<Cell>> cellDetails = List.generate(
    ROW,
    (i) => List.generate(
      COL,
      (j) => Cell(
        parent_i: -1,
        parent_j: -1,
        f: double.infinity,
        g: double.infinity,
        h: double.infinity,
      ),
    ),
  );

  int i, j;

  for (i = 0; i < ROW; i++) {
    for (j = 0; j < COL; j++) {
      cellDetails[i][j].f = double.infinity;
      cellDetails[i][j].g = double.infinity;
      cellDetails[i][j].h = double.infinity;
      cellDetails[i][j].parent_i = -1;
      cellDetails[i][j].parent_j = -1;
    }
  }

  // Initializing the parameters of the starting node
  i = src.item1;
  j = src.item2;
  cellDetails[i][j].f = 0.0;
  cellDetails[i][j].g = 0.0;
  cellDetails[i][j].h = 0.0;
  cellDetails[i][j].parent_i = i;
  cellDetails[i][j].parent_j = j;

  // Create an open list having information as-
  // <f, <i, j>>
  // where f = g + h,
  // and i, j are the row and column index of that cell
  // Note that 0 <= i <= ROW-1 & 0 <= j <= COL-1
  // This open list is implemented as a set of pair of pair.
  var openList = <pPair>{};

  // Put the starting cell on the open list and set its 'f' as 0
  openList.add(pPair(0.0, Pair(i, j)));

  // We set this boolean value as false as initially
  // the destination is not reached.
  var foundDest = false;

  while (openList.isNotEmpty) {
    pPair p = openList.first;

    // Remove this vertex from the open list
    openList.remove(p);

    // Add this vertex to the closed list
    i = p.item2.item1;
    j = p.item2.item2;
    closedList[i][j] = true;

    /*
         Generating all the 8 successor of this cell
 
             N.W   N   N.E
               \   |   /
                \  |  /
             W----Cell----E
                  / | \
                /   |  \
             S.W    S   S.E
 
         Cell-->Popped Cell (i, j)
         N -->  North       (i-1, j)
         S -->  South       (i+1, j)
         E -->  East        (i, j+1)
         W -->  West        (i, j-1)
         N.E--> North-East  (i-1, j+1)
         N.W--> North-West  (i-1, j-1)
         S.E--> South-East  (i+1, j+1)
         S.W--> South-West  (i+1, j-1)*/

    // To store the 'g', 'h', and 'f' of the 8 successors
    double gNew, hNew, fNew;

    //----------- 1st Successor (North) ------------

    // Only process this cell if this is a valid one
    if (isValid(i - 1, j) == true) {
      // If the destination cell is the same as the
      // current successor
      if (isDestination(i - 1, j, dest) == true) {
        // Set the Parent of the destination cell
        cellDetails[i - 1][j].parent_i = i;
        cellDetails[i - 1][j].parent_j = j;
        print("The destination cell is found");

        foundDest = true;
        return tracePath(cellDetails, dest);
      }
      // If the successor is already on the closed
      // list or if it is blocked, then ignore it.
      // Else do the following
      else if (closedList[i - 1][j] == false &&
          isUnBlocked(grid, i - 1, j) == true) {
        gNew = cellDetails[i][j].g + 1.0;
        hNew = calculateHValue(i - 1, j, dest);
        fNew = gNew + hNew;

        // If it isn't on the open list, add it to
        // the open list. Make the current square
        // the parent of this square. Record the
        // f, g, and h costs of the square cell
        //                OR
        // If it is on the open list already, check
        // to see if this path to that square is
        // better, using 'f' cost as the measure.
        if (cellDetails[i - 1][j].f == double.infinity ||
            cellDetails[i - 1][j].f > fNew) {
          openList.add(pPair(fNew, Pair(i - 1, j)));

          // Update the details of this cell
          cellDetails[i - 1][j].f = fNew;
          cellDetails[i - 1][j].g = gNew;
          cellDetails[i - 1][j].h = hNew;
          cellDetails[i - 1][j].parent_i = i;
          cellDetails[i - 1][j].parent_j = j;
        }
      }
    }

    //----------- 2nd Successor (South) ------------

    // Only process this cell if this is a valid one
    if (isValid(i + 1, j) == true) {
      // If the destination cell is the same as the
      // current successor
      if (isDestination(i + 1, j, dest) == true) {
        // Set the Parent of the destination cell
        cellDetails[i + 1][j].parent_i = i;
        cellDetails[i + 1][j].parent_j = j;
        print("The destination cell is found");

        foundDest = true;
        return tracePath(cellDetails, dest);
      }
      // If the successor is already on the closed
      // list or if it is blocked, then ignore it.
      // Else do the following
      else if (closedList[i + 1][j] == false &&
          isUnBlocked(grid, i + 1, j) == true) {
        gNew = cellDetails[i][j].g + 1.0;
        hNew = calculateHValue(i + 1, j, dest);
        fNew = gNew + hNew;

        // If it isn't on the open list, add it to
        // the open list. Make the current square
        // the parent of this square. Record the
        // f, g, and h costs of the square cell
        //                OR
        // If it is on the open list already, check
        // to see if this path to that square is
        // better, using 'f' cost as the measure.
        if (cellDetails[i + 1][j].f == double.infinity ||
            cellDetails[i + 1][j].f > fNew) {
          openList.add(pPair(fNew, Pair(i + 1, j)));

          // Update the details of this cell
          cellDetails[i + 1][j].f = fNew;
          cellDetails[i + 1][j].g = gNew;
          cellDetails[i + 1][j].h = hNew;
          cellDetails[i + 1][j].parent_i = i;
          cellDetails[i + 1][j].parent_j = j;
        }
      }
    }

    //----------- 3rd Successor (East) ------------

    // Only process this cell if this is a valid one
    if (isValid(i, j + 1) == true) {
      // If the destination cell is the same as the
      // current successor
      if (isDestination(i, j + 1, dest) == true) {
        // Set the Parent of the destination cell
        cellDetails[i][j + 1].parent_i = i;
        cellDetails[i][j + 1].parent_j = j;
        print("The destination cell is found");

        foundDest = true;
        return tracePath(cellDetails, dest);
      }

      // If the successor is already on the closed
      // list or if it is blocked, then ignore it.
      // Else do the following
      else if (closedList[i][j + 1] == false &&
          isUnBlocked(grid, i, j + 1) == true) {
        gNew = cellDetails[i][j].g + 1.0;
        hNew = calculateHValue(i, j + 1, dest);
        fNew = gNew + hNew;

        // If it isn't on the open list, add it to
        // the open list. Make the current square
        // the parent of this square. Record the
        // f, g, and h costs of the square cell
        //                OR
        // If it is on the open list already, check
        // to see if this path to that square is
        // better, using 'f' cost as the measure.
        if (cellDetails[i][j + 1].f == double.infinity ||
            cellDetails[i][j + 1].f > fNew) {
          openList.add(pPair(fNew, Pair(i, j + 1)));

          // Update the details of this cell
          cellDetails[i][j + 1].f = fNew;
          cellDetails[i][j + 1].g = gNew;
          cellDetails[i][j + 1].h = hNew;
          cellDetails[i][j + 1].parent_i = i;
          cellDetails[i][j + 1].parent_j = j;
        }
      }
    }

    //----------- 4th Successor (West) ------------

    // Only process this cell if this is a valid one
    if (isValid(i, j - 1) == true) {
      // If the destination cell is the same as the
      // current successor
      if (isDestination(i, j - 1, dest) == true) {
        // Set the Parent of the destination cell
        cellDetails[i][j - 1].parent_i = i;
        cellDetails[i][j - 1].parent_j = j;
        print("The destination cell is found");

        foundDest = true;
        return tracePath(cellDetails, dest);
      }

      // If the successor is already on the closed
      // list or if it is blocked, then ignore it.
      // Else do the following
      else if (closedList[i][j - 1] == false &&
          isUnBlocked(grid, i, j - 1) == true) {
        gNew = cellDetails[i][j].g + 1.0;
        hNew = calculateHValue(i, j - 1, dest);
        fNew = gNew + hNew;

        // If it isn't on the open list, add it to
        // the open list. Make the current square
        // the parent of this square. Record the
        // f, g, and h costs of the square cell
        //                OR
        // If it is on the open list already, check
        // to see if this path to that square is
        // better, using 'f' cost as the measure.
        if (cellDetails[i][j - 1].f == double.infinity ||
            cellDetails[i][j - 1].f > fNew) {
          openList.add(pPair(fNew, Pair(i, j - 1)));

          // Update the details of this cell
          cellDetails[i][j - 1].f = fNew;
          cellDetails[i][j - 1].g = gNew;
          cellDetails[i][j - 1].h = hNew;
          cellDetails[i][j - 1].parent_i = i;
          cellDetails[i][j - 1].parent_j = j;
        }
      }
    }

    //----------- 5th Successor (North-East) ------------

    // Only process this cell if this is a valid one
    if (isValid(i - 1, j + 1) == true) {
      // If the destination cell is the same as the
      // current successor
      if (isDestination(i - 1, j + 1, dest) == true) {
        // Set the Parent of the destination cell
        cellDetails[i - 1][j + 1].parent_i = i;
        cellDetails[i - 1][j + 1].parent_j = j;
        print("The destination cell is found");

        foundDest = true;
        return tracePath(cellDetails, dest);
      }

      // If the successor is already on the closed
      // list or if it is blocked, then ignore it.
      // Else do the following
      else if (closedList[i - 1][j + 1] == false &&
          isUnBlocked(grid, i - 1, j + 1) == true) {
        gNew = cellDetails[i][j].g + 1.414;
        hNew = calculateHValue(i - 1, j + 1, dest);
        fNew = gNew + hNew;

        // If it isn't on the open list, add it to
        // the open list. Make the current square
        // the parent of this square. Record the
        // f, g, and h costs of the square cell
        //                OR
        // If it is on the open list already, check
        // to see if this path to that square is
        // better, using 'f' cost as the measure.
        if (cellDetails[i - 1][j + 1].f == double.infinity ||
            cellDetails[i - 1][j + 1].f > fNew) {
          openList.add(pPair(fNew, Pair(i - 1, j + 1)));

          // Update the details of this cell
          cellDetails[i - 1][j + 1].f = fNew;
          cellDetails[i - 1][j + 1].g = gNew;
          cellDetails[i - 1][j + 1].h = hNew;
          cellDetails[i - 1][j + 1].parent_i = i;
          cellDetails[i - 1][j + 1].parent_j = j;
        }
      }
    }

    //----------- 6th Successor (North-West) ------------

    // Only process this cell if this is a valid one
    if (isValid(i - 1, j - 1) == true) {
      // If the destination cell is the same as the
      // current successor
      if (isDestination(i - 1, j - 1, dest) == true) {
        // Set the Parent of the destination cell
        cellDetails[i - 1][j - 1].parent_i = i;
        cellDetails[i - 1][j - 1].parent_j = j;
        print("The destination cell is found");

        foundDest = true;
        return tracePath(cellDetails, dest);
      }

      // If the successor is already on the closed
      // list or if it is blocked, then ignore it.
      // Else do the following
      else if (closedList[i - 1][j - 1] == false &&
          isUnBlocked(grid, i - 1, j - 1) == true) {
        gNew = cellDetails[i][j].g + 1.414;
        hNew = calculateHValue(i - 1, j - 1, dest);
        fNew = gNew + hNew;

        // If it isn't on the open list, add it to
        // the open list. Make the current square
        // the parent of this square. Record the
        // f, g, and h costs of the square cell
        //                OR
        // If it is on the open list already, check
        // to see if this path to that square is
        // better, using 'f' cost as the measure.
        if (cellDetails[i - 1][j - 1].f == double.infinity ||
            cellDetails[i - 1][j - 1].f > fNew) {
          openList.add(pPair(fNew, Pair(i - 1, j - 1)));

          // Update the details of this cell
          cellDetails[i - 1][j - 1].f = fNew;
          cellDetails[i - 1][j - 1].g = gNew;
          cellDetails[i - 1][j - 1].h = hNew;
          cellDetails[i - 1][j - 1].parent_i = i;
          cellDetails[i - 1][j - 1].parent_j = j;
        }
      }
    }
  }

  // When the destination cell is not found and the open
  // list is empty, then we conclude that we failed to
  // reach the destination cell. This may happen when the
  // there is no way to the destination cell (due to
  // blockages)
  if (foundDest == false) {
    print("Failed to find the Destination Cell");
  }
  return;
}

void aStarTemp() {
  /* Description of the Grid-
   1--> The cell is not blocked
   0--> The cell is blocked    */
  List<List<int>> grid = [
    [1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
    [1, 1, 1, 0, 1, 1, 1, 0, 1, 1],
    [1, 1, 1, 0, 1, 1, 0, 1, 0, 1],
    [0, 0, 1, 0, 1, 0, 0, 0, 0, 1],
    [1, 1, 1, 0, 1, 1, 1, 0, 1, 0],
    [1, 0, 1, 1, 1, 1, 0, 1, 0, 0],
    [1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
    [1, 1, 1, 0, 0, 0, 1, 0, 0, 1],
  ];

  // Source is the left-most bottom-most corner
  Pair src = Pair(8, 0);

  // Destination is the left-most top-most corner
  Pair dest = Pair(0, 0);

  aStarSearch(grid, src, dest);
}

aStarTry() async {
  List<List<int>> grid = await setMapList(Const.pT2L1r);

  return grid;
}
