%******************************************
% Name: genchannel.m
% Function: generate the channel data.
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function genchannel()
    global SimGlobal;
    global CT;
    ZeroChan=ChanData;
    chan1=SimGlobal.aChanData;
    for iChan=1:CT.MaxChanNum
        if(chan1(iChan).PRN==0&&chan1(iChan).ChannelState==3)
            chan1(iChan)=ZeroChan;
        end
    end
    for iSat=1:CT.MaxSatNum
        pS=SimGlobal.aSatData(iSat);
        pN=pS.sNavData;
        pO=pS.sOrbitData;
        pE=pO.sEphData;
        if(pS.chanflag==0)
            if(pO.visflag==1)
                SimGlobal.aSatData(iSat).chanflag=1;
                for iEmpChan=1:CT.MaxChanNum
                    if(chan1(iEmpChan).PRN==0&&chan1(iEmpChan).ChannelState==0)
                        break;
                    end
                end
                chan1(iEmpChan).ChannelState=2;
                chan1(iEmpChan).PRN=pE.PRN;
                SimGlobal.aSatData(iSat).chanindex=iEmpChan;
            end
        elseif(pS.chanflag==1)
            if(pO.visflag==1)
                chan1(pS.chanindex).ChannelState=1;
            else
                SimGlobal.aSatData(iSat).chanflag=0;
                chan1(pS.chanindex)=ZeroChan;
                chan1(pS.chanindex).ChannelState=3;
            end
        end
    end
end
    