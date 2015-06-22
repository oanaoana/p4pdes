function N = getiterest(rtol,lamBIG,lamSMALL)

kap = lamBIG/lamSMALL
gam = (sqrt(kap) - 1) / (sqrt(kap) + 1)

for k=1:100
   if 2 * sqrt(kap) / ( gam^k + gam^(-k) )  < rtol  % factor of sqrt(kap) from converting |e|_A to |r|_2
      break;
   end
end
N=k;
