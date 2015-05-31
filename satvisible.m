%******************************************
% Name: satvisible.m
% Function: determine whether the satellite is visible
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function satvisible()
    global SimGlobal;
    global CT;
    t=SimGlobal.t;
    userState=SimGlobal.userState;
    for i=1:CT.MaxSatNum
        clear tempsat;
        if (SimGlobal.aSatData(i).sOrbitData.sEphData.PRN~=-1)
            SimGlobal.aSatData(i).sOrbitData.sPVASat=GetSatState(t,SimGlobal.aSatData(i).sOrbitData.sEphData);
            tempPVA=GetSatState(t+6,SimGlobal.aSatData(i).sOrbitData.sEphData);
            [SimGlobal.aSatData(i).sOrbitData.alpha,SimGlobal.aSatData(i).sOrbitData.zenith]=WGS2ENU(userState,SimGlobal.aSatData(i).sOrbitData.sPVASat);
            [alpha,zenith]=WGS2ENU(userState,tempPVA);
            if(SimGlobal.aSatData(i).sOrbitData.zenith>5)
                SimGlobal.aSatData(i).sOrbitData.visflag=1;
            else
                SimGlobal.aSatData(i).sOrbitData.visflag=0;
            end
        end
    end
end