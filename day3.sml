signature SET = sig
  type Elem
  type Set
  val empty : Set
  val insert : Elem * Set -> Set
  val member : Elem * Set -> bool
  val size : Set -> int
end

signature ORDERED = sig
  type T
  val eq : T * T -> bool
  val lt : T * T -> bool
  val leq : T * T -> bool
end

structure StringOrdered: ORDERED = struct 
  type T = string 
  val eq = (op =)
  val lt = String.<
  val leq = String.<=
end

structure PairOrdered: ORDERED = struct
  type T = int * int 
  fun eq ((a,b),(c,d)) = (a = c) andalso (b = d)
  fun lt ((a,b),(c,d)) = a < c (*(a < c) orelse (b < d)*)
  fun leq (x,y) = lt (x,y) orelse eq (x,y)
end
structure IntOrdered: ORDERED = struct
  type T = int
  val eq = (op =)
  val lt = (op<)
  fun leq (a,b) = (a < b) orelse (a = b)
end
(*
structure WordOrdered: ORDERED = struct
  type T = word 
  val eq = (op =)
  val lt = (op<)
  fun leq (a,b) = (a < b) orelse (a = b)
end
*)


functor UnbalancedSet(Element : ORDERED): SET = struct
  type Elem = Element.T
  datatype Tree = E | T of Tree * Elem * Tree
  type Set = Tree

  val empty = E
  fun member(x, E) = false
    | member (x, T (a, y, b)) = 
        if Element.lt (x,y) then member (x,a)
        else if Element.lt (y,x) then member(x,b)
        else true
  
  fun insert (x, E) = T(E, x, E) 
    | insert (x, s as T(a, y, b)) =
        if Element.lt (x, y) then T (insert (x, a), y, b)
        else if Element.lt (y, x) then T (a, y, insert (x ,b))
        else s
  
  fun size (E) = 0
    | size (T (l, _, r)) = size l + size r + 1 
end

structure Set = UnbalancedSet(IntOrdered);

(*structure Set = IntBinarySet;*)

exception Unrecognized;

val instream = TextIO.openIn("inputs/day03.txt")
val inputstring = TextIO.inputAll(instream);
val input = String.explode inputstring;

fun encode (x,y) =
  Word.toIntX (HashString.hashString (Int.toString x ^ ", " ^ Int.toString y));

fun char_handler (c, (set, x, y)) =
  let val (nx, ny) =
    case c of
        #"^" => (x, y+1)
    |   #">" => (x+1, y)
    |   #"v" => (x, y-1)
    |   #"<" => (x-1, y)
    |   _ => raise Unrecognized
  in
    print "(";
    print (Int.toString nx);
    print ", ";
    print (Int.toString ny);
    print "), ";
    (Set.insert(encode (nx, ny), set), nx, ny)
    (*

    (Set.add(Int.fromString(Int.toString(nx) ^ Int.toString(ny))), nx, ny)*)
  end;

val initial = Set.insert(encode (0,0), Set.empty);

fun solve (input) =
  let 
    val (final,_,_) = List.foldl char_handler (initial, 0, 0) input
  in 
    (final, Set.size(final))
  end;


val (final, solution) = solve (input);
print(Int.toString solution);

