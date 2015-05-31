%******************************************
% Name: selecteph.m
% Function: Select the valid ephemeris for each satellite 
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function satdata=selecteph()
    global SimGlobal;
    global CT;
    t=SimGlobal.t;
    ephflag=zeros(1,CT.MaxSatNum);
    satdata(32)=SatData;
    for i=1:SimGlobal.noeph
        clear tempeph;
        tempeph=SimGlobal.aEphData(i);
        if(ephflag(tempeph.PRN)==0)
            ephflag(tempeph.PRN)=1;
            satdata(tempeph.PRN).sOrbitData.sEphData=tempeph;
        elseif (ephflag(tempeph.PRN)==1)
            if(abs(tempeph.GPSTime-t)<abs(satdata(tempeph.PRN).sOrbitData.sEphData.GPSTime-t))
                satdata(tempeph.PRN).sOrbitData.sEphData=tempeph;
            end
        end
    end
    for i=1:CT.MaxSatNum
        if(ephflag(i)==0)
            satdata(i).sOrbitData.sEphData.PRN=-1;
        end
    end
end
    