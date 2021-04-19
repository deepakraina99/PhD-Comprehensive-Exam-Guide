function HTM = homo_trans(b,th,a,alp)

HTM=[cos(th) -sin(th)*round(cos(alp)) sin(th)*round(sin(alp)) a*cos(th);
     sin(th) cos(th)*round(cos(alp)) -cos(th)*round(sin(alp)) a*sin(th);
     0 round(sin(alp)) round(cos(alp)) b;
     0 0 0 1];
 
% HTM = round(HTM);
end