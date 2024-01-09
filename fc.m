
function val = fc(r,s)

val = r.x*0;

val(-1 <= r.x & -1 <= r.y & -2/3 <= r.z & r.x <= -3/8 & r.y <= -1/2 & r.z <= 0) = 200;

end