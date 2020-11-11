(* 
Jesse Calvert
1/8/2019
CS362 Lab 3

BST in SML demo
*)

(*START OF PROVIDED CODE*)
(* left subtree, right subtree, key, value *)
datatype BST = Empty | Node of BST * BST * int * int;

fun parsePost [] = Empty
|   parsePost lst =
    let
        fun pP (stack, (0,k,v)::str) = pP(Node(Empty, Empty, k, v)::stack, str)
        |   pP (L::stack, (1,k,v)::str) = pP(Node(L, Empty, k, v)::stack, str)
        |   pP (R::stack, (2,k,v)::str) = pP(Node(Empty, R, k, v)::stack, str)
        |   pP (R::L::stack, (3,k,v)::str) = pP(Node(L, R, k, v)::stack, str)
        |   pP (T::stack, []) = T;
    in
        pP([],lst)
    end;

val exTree0 = []
val exTree1 = [(0,1,1),(0,3,3),(3,2,2)];
val exTree2 = [(0,2,2),(2,1,1),(0,4,4),(3,3,3),(0,6,6),(1,7,7),(3,5,5)];
val exTree3 = [(0,1,1),(0,4,4),(1,5,5),(3,2,2),(0,8,8),(0,15,15),(2,14,14),(3,11,11)];
(*END OF PROVIDED CODE*)

fun insert(Empty, key, value) = Node(Empty, Empty, key, value)
|   insert(Node(l, r, k, v), key, value) =
    if (k = key) then Node(l, r, k, value)
    else if (k > key) then Node(insert(l, key, value), r, k, v)
    else Node(l, insert(r, key, value), k, v);

fun find(Empty, key) = []
|   find(Node(l, r, k, v), key) =
    if (k = key) then [v]
    else if (k > key) then find(l, key)
    else find(r, key);

fun successor(Node(l, r, k, v)) =
    if (l = Empty) then (k, v)
    else successor(l);

fun delete(Empty, key) = Empty
|   delete(Node(l, r, k, v), key) =
    if (k = key) then
        if (l = Empty andalso r = Empty) then Empty
        else if (l <> Empty andalso r = Empty) then l
        else if (l = Empty andalso r <> Empty) then r 
        else 
            let val (newKey, newVal) = successor(r)
            in Node(l, delete(r, newKey), newKey, newVal)
            end
    else if (k > key) then Node(delete(l, key), r, k, v)
    else Node(l, delete(r, key), k, v);

fun postorder(Empty) = []
|   postorder(Node(l, r, k, v)) = 
    let 
        val children =
            if (l = Empty andalso r = Empty) then 0
            else if (l <> Empty andalso r = Empty) then 1
            else if (l = Empty andalso r <> Empty) then 2
            else 3
    in
        postorder(l) @ postorder(r) @ [(children, k, v)]
    end;

fun subtree(Empty, minKey, maxKey) = Empty
|   subtree(Node(l, r, k, v), minKey, maxKey) =
    if (k > maxKey) then subtree(l, minKey, maxKey) 
    else if (k < minKey) then subtree(r, minKey, maxKey)
    else Node(subtree(l, minKey, maxKey), subtree(r, minKey, maxKey), k, v);

val tree3 = parsePost exTree3;