%******************************************
% Name: WGS2WGS.m
% Function: coordinate rotation
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function wgsPVA2 = WGS2WGS(wgsPVA1,Tp)
	global CT;
    s=[cos(CT.WE*Tp),sin(CT.WE*Tp),0;
        -sin(CT.WE*Tp),cos(CT.WE*Tp),0;
        0,0,1];
    temp=s*[wgsPVA1.pos.first,wgsPVA1.pos.second,wgsPVA1.pos.third]';
    wgsPVA2.pos.first=temp(1);
    wgsPVA2.pos.second=temp(2);
    wgsPVA2.pos.third=temp(3);    
end

