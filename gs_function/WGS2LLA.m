%******************************************
% Name: WGS2LLA.m
% Function: convert wgs 84 to lla.
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function llaPVA = WGS2LLA(wgsPVA)
	global CT;
    ecc=sqrt(CT.F*(2-CT.F));
    x=wgsPVA.pos.first;
    y=wgsPVA.pos.second;
    z=wgsPVA.pos.third;
    la=atan2(y,x);
    p=sqrt(x^2+y^2);
    %µü´ú·¨Çópha£¬h
    pha0=0;
    N0=CT.A/sqrt(1-ecc*ecc*(sin(pha0)*sin(pha0)));
    h0=p/cos(pha0)-N0;
    while 1
        pha1=atan(z/p/(1-ecc^2*N0/(N0+h0)));
        N1=CT.A/sqrt(1-ecc*ecc*(sin(pha1)*sin(pha1))); 
        h1=p/cos(pha1)-N1;
        if((abs(pha1-pha0)<1e-7)&&(abs(N1-N0)<1e-7)&&(abs(h1-h0)<1e-7))
            break;
        else
            pha0=pha1;
            N0=N1;
            h0=h1;
        end;
    end;
    pha=pha1;
    h=h1;
    llaPVA.pos.first=pha*180/CT.PI;
    llaPVA.pos.second=la*180/CT.PI;
    llaPVA.pos.third=h;
end

