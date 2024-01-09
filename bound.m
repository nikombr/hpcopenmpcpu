
function val = bound(r,s)

val = r.x*0 + 20;
tol = 10^(-6);

val((r.y+1) < tol) = 0;



end