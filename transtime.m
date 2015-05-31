%******************************************
% Name: transtime.m
% Function: Calculate the transfer time. 
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function transtime()
    global SimGlobal;
    global CT;
    t=SimGlobal.t;
    userState=SimGlobal.userState;
    for i=1:CT.MaxSatNum
        if(SimGlobal.aSatData(i).sOrbitData.visflag==1)
            Tp=0.075;
            while 1
                Tp0=Tp;
                ts=t-Tp;
                tSatState=GetSatState(ts,SimGlobal.aSatData(i).sOrbitData.sEphData);
                rSatState=WGS2WGS(tSatState,Tp);
                dx=rSatState.pos.first-userState.pos.first;
                dy=rSatState.pos.second-userState.pos.second;
                dz=rSatState.pos.third-userState.pos.third;
                Tp=sqrt(dx^2+dy^2+dz^2)/CT.C;
                if(abs(Tp-Tp0)*CT.C<1e-6)
                    break;
                end
            end  
            SimGlobal.aSatData(i).sNavData.dTransTime=Tp;
        end
    end
   
end
    