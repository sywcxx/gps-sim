function wpc=noni(pwc,cwc)
    for i=1:22
        cw(i)=num2str(cwc(i));
    end
    for i=1:30
        pw(i)=num2str(pwc(i));
    end
    c=1-2*cw;
    p=1-2*pw;
    c(24)=1*p(30)*c(1)*c(3)*c(5)*c(6)*c(7)*c(9)*c(10)*c(14)*c(15)*c(16)*c(17)*c(18)*c(21)*c(22);
    c(23)=1*p(29)*c(3)*c(5)*c(6)*c(8)*c(9)*c(10)*c(11)*c(13)*c(15)*c(19)*c(22)*c(24);
    wp=(1-c)/2;
    for i=1:24
        wpc(i)=num2str(wp(i));
    end    
end