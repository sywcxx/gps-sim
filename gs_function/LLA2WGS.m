%******************************************
% Name: LLA2WGS.m
% Function: convert lla to wgs 84.
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function wgsPVA = LLA2WGS(llaPVA)
	global CT;
    ecc=sqrt(CT.F*(2-CT.F));
    pha=llaPVA.pos.first*CT.PI/180;
    la=llaPVA.pos.second*CT.PI/180;
    h=llaPVA.pos.third;
    N=CT.A/sqrt(1-ecc*ecc*(sin(pha)*sin(pha)));
    x=(N+h)*cos(pha)*cos(la);
    y=(N+h)*cos(pha)*sin(la);
    z=(N*(1-ecc^2)+h)*sin(pha);
    wgsPVA.pos.first=x;
    wgsPVA.pos.second=y;
    wgsPVA.pos.third=z;
    wgsPVA.vel=Coordinate(0,0,0);
    wgsPVA.acc=Coordinate(0,0,0);
end

