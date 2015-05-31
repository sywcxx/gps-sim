%******************************************
% Name: init.m
% Function: initialize the system
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function init()
    global SimGlobal;
    global CT;
    %***********define the constant********************
    CT.PI=3.14159265358979;% pi
    CT.U=3.986005e14;% value of Earth's universal gravitationl parameters,the unit is m^3/s^2
    CT.WE=7.2921151467e-5;% WGS 84 value of the earth's rotation rate,the unit is rad/s
    CT.C=2.99792458e8;% speed of light,the unit is m/s
    CT.A=6378137;% the earth's Semi-Major Axis
    CT.F=1/298.257223563;% flattening
    CT.MaxSatNum=32;% the total number of satellites
    CT.MaxChanNum=12;% the total number of channels
    %***********define the global data ***************
    SimGlobal.freq=1575.42e6;% the L1 frequency
    SimGlobal.userState=PVA;% the user's state( position,velocity and accceleration)
    SimGlobal.userState.pos.first=40;
    SimGlobal.userState.pos.second=116;
    SimGlobal.userState.pos.third=1000;
    SimGlobal.aSatData(CT.MaxSatNum)=SatData;
    SimGlobal.aChanData(CT.MaxChanNum)=ChanData;
    sT=Time(2013,3,20,12,30,0);
    [SimGlobal.weekno,SimGlobal.t]=UTC2GPST(sT);% the simulation time
end