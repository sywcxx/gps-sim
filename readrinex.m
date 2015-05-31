%******************************************
% Name: readrinex.m
% Function: load the ephemeris data
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function [noeph,ephdata]=readrinex(filename)
% open the rinex file
fid=fopen(filename,'r');
%find the string "END OF HEADER" line
head_lines=0;
while 1
    head_lines=head_lines+1;
    line=fgetl(fid);
    result=findstr(line,'END OF HEADER');
    if ~isempty(result)
        break;
    end;
end;
% calculate the total ephemeris items
noeph=-1;
while 1
    noeph=noeph+1;
    line=fgetl(fid);
    if line==-1
        break;
    end;
end;
noeph=noeph/8;
ephdata(noeph)=EphData(0);
% load the ephemeris data
frewind(fid);
for l=1:head_lines
    line=fgetl(fid);
end;
for i=1:noeph
    % first line
    line=fgetl(fid);
    ephdata(i).PRN=str2num(line(1:2));
    y=str2num(line(3:6));
    if y>79
        ephdata(i).sT.year=y+1900;
    else
        ephdata(i).sT.year=y+2000;
    end;
    ephdata(i).sT.month=str2num(line(7:9));
    ephdata(i).sT.day=str2num(line(10:12));
    ephdata(i).sT.hour=str2num(line(13:15));
    ephdata(i).sT.minute=str2num(line(16:18));
    ephdata(i).sT.second=str2num(line(19:22));
    ephdata(i).af0=str2num(line(23:41));
    ephdata(i).af1=str2num(line(42:60));
    ephdata(i).af2=str2num(line(61:79));
    % second line
    line=fgetl(fid);
    ephdata(i).Iode=str2num(line(4:22));
    ephdata(i).Crs=str2num(line(23:41));
    ephdata(i).dn=str2num(line(42:60));
    ephdata(i).m0=str2num(line(61:79));
    % third line
    line=fgetl(fid);
    ephdata(i).Cuc=str2num(line(4:22));
    ephdata(i).ecc=str2num(line(23:41));
    ephdata(i).Cus=str2num(line(42:60));
    ephdata(i).Asqrt=str2num(line(61:79));
    % fourth line
    line=fgetl(fid);
    ephdata(i).Toe=str2num(line(4:22));
    ephdata(i).Cic=str2num(line(23:41));
    ephdata(i).Omega0=str2num(line(42:60));
    ephdata(i).Cis=str2num(line(61:79));
    % fifth line
    line=fgetl(fid);
    ephdata(i).I0=str2num(line(4:22));
    ephdata(i).Crc=str2num(line(23:41));
    ephdata(i).w=str2num(line(42:60));
    ephdata(i).Omegadot=str2num(line(61:79));
    % sixth line
    line=fgetl(fid);
    ephdata(i).Idot=str2num(line(4:22));
    ephdata(i).L2Code=str2num(line(23:41));
    ephdata(i).ps=str2num(line(42:60));
    ephdata(i).L2P=str2num(line(61:79));
    % seventh line
    line=fgetl(fid);
    ephdata(i).Ura=str2num(line(4:22));
    ephdata(i).SV_health=str2num(line(23:41));
    ephdata(i).Tgd=str2num(line(42:60));
    ephdata(i).Iodc=str2num(line(61:79));
    % the last line
    line=fgetl(fid);
    ephdata(i).Ttime=str2num(line(4:22));
    ephdata(i).other=str2num(line(23:41));
    % convert utc to gpst
    [ephdata(i).weekno,ephdata(i).GPSTime]=UTC2GPST(ephdata(i).sT);
end;
fclose(fid);
end
    