(* 
Jesse Calvert
1/3/2019
CS362 Lab 1

Seive of Eratosthenes
*)

fun makeLst(n) = 
    if (n < 1) then []
    else makeLst(n-1)@[n];

fun removeMult(nums, mult) =
    if (nums = []) then []
    else if (hd(nums) mod mult = 0) then removeMult(tl(nums), mult)
    else [hd(nums)] @ removeMult(tl(nums), mult);
    

fun nth(lst, ptr) =
    if (ptr = 0) then hd(lst)
    else nth(tl(lst), ptr - 1);

fun primes(n) =
    let
        val A = tl(makeLst(n))
        fun seiveRound(lst, ptr) =
            if (ptr >= length(lst)) then lst
            else nth(lst, ptr)::seiveRound(removeMult(lst, nth(lst, ptr)), ptr + 1);
    in
        seiveRound(A, 1)
    end;
