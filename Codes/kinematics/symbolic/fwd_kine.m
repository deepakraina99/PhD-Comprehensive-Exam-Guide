function fk = fwd_kine(b,th,a,alp)

T(:,:,1)=homo_trans(b(1),th(1),a(1),alp(1));
for i=2:size(th,2)
    i
    homo_trans(b(i),th(i),a(i),alp(i))
    T(:,:,i)=T(:,:,i-1)*homo_trans(b(i),th(i),a(i),alp(i));
fk = T;
end