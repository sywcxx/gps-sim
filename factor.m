function bin=factor(org,factor,i)
    t1=org*2^factor;
    t2=round(t1);
    q=quantizer([i,i-1]);
    [a,b]=range(q);
    aa=abs(a*2^(i-1));
    if t2>=aa
        t2=mod(t2,aa);
    end
    bin=num2bin(q,t2/2^(i-1));
end