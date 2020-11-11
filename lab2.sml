(* 
Jesse Calvert
1/4/2019
CS362 Lab 2

Quicksort
*)

fun nth(lst, ptr) =
    if (ptr = 0) then hd(lst)
    else nth(tl(lst), ptr - 1);

fun last(lst) = nth(lst, length(lst) - 1);

fun middle(lst) = nth(lst, length(lst) div 2);

fun median(a, b, c) = 
    if ( (a >= b andalso a <= c) orelse (a >= c andalso a <= b) ) then a
    else if ( (b >= a andalso b <= c) orelse ( b >= c andalso b <= a)) then b
    else c;

fun partition(lst, p) =
    if(lst = []) then ([],[])
    else
    let val head = hd(lst)
        val (smallerOrEqual, larger) = partition(tl(lst), p)
    in
        if (head > p) then (smallerOrEqual, [head] @ larger)
        else ([head] @ smallerOrEqual, larger)
    end;

(*True if all elements are equal, otherwise false*)
fun allEqual(lst) = 
    length(lst) < 2
    orelse ( hd(lst) = hd( tl(lst) ) andalso allEqual( tl(lst) ) );

(* Removes first occurance of a given element*)
fun remove(lst, ele) =
    if lst = [] then lst
    else if(hd(lst) = ele) then tl(lst)
    else hd(lst)::remove(tl(lst), ele);

fun quicksort(lst) =
    if (allEqual(lst)) then lst
    else
    let val piv = median(hd(lst), middle(lst), last(lst))
        val (smallerOrEqual, larger) =
            partition(remove(lst, piv), piv)
    in
        quicksort(smallerOrEqual) @ [piv] @ quicksort(larger)
    end;