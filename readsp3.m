%******************************************
% Name: readsp3.m
% Funciton: load the precision ephemeris data
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function [preephdata]=readsp3(filename)
% open the sp3 file
fid=fopen(filename,'r');
% read the precision ephemeris data
frewind(fid);
for l=1:22
    line=fgetl(fid);
end;
for i=1:96  % 96 items for each satellite
    line=fgetl(fid);
	preephdata(i).sT.year=str2num(line(4:7));
	preephdata(i).sT.month=str2num(line(9:10));
	preephdata(i).sT.day=str2num(line(12:13));
	preephdata(i).sT.hour=str2num(line(15:16));
	preephdata(i).sT.minute=str2num(line(18:19));
	preephdata(i).sT.second=str2num(line(22:31));
	preephdata(i).dsec=preephdata(i).sT.second+preephdata(i).sT.minute*60+preephdata(i).sT.hour*3600;
    for j=1:32
        if(j~=27)
            line=fgetl(fid);
            PRN=str2num(line(3:4));
            preephdata(i).sCoorSatPos(j).first=str2num(line(6:18))*1000;
            preephdata(i).sCoorSatPos(j).second=str2num(line(20:32))*1000;
            preephdata(i).sCoorSatPos(j).third=str2num(line(34:47))*1000;
        end
    end
end;
fclose(fid);
end
    