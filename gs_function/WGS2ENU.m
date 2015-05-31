%******************************************
% Name: WGS2ENU.m
% Function: convert wgs 84 to enu.
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function [alpha,theta]= WGS2ENU(userPVA,satPVA)
    global CT;
    llaPVA=WGS2LLA(userPVA);
    pha=llaPVA.pos.first*CT.PI/180;
    la=llaPVA.pos.second*CT.PI/180;
    
    dx=satPVA.pos.first-userPVA.pos.first;
    dy=satPVA.pos.second-userPVA.pos.second;
    dz=satPVA.pos.third-userPVA.pos.third;
    s=[-sin(la) cos(la) 0;
        -sin(pha)*cos(la) -sin(pha)*sin(la) cos(pha);
        cos(pha)*cos(la) cos(pha)*sin(la) sin(pha)];
    denu=s*[dx,dy,dz]';
    de=denu(1);
    dn=denu(2);
    du=denu(3);
    alpha=atan2(de,dn)*180/CT.PI;
    theta=asin(du/sqrt(de^2+dn^2+du^2))*180/CT.PI;
end

