%******************************************
% Name: UTC2GPST.m
% Function: convert utc to gpst.
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function [weekno,gpstime] = UTC2GPST(sT)
	year=sT.year;
	if(year<100)
		year=year+2000;
	end
	month=sT.month;
	day=sT.day;
	hour=sT.hour;
	minute=sT.minute;
	second=sT.second;
	dinmth=[31;28;31;30;31;30;31;31;30;31;30;31];
	%GPST starts 1980-01-06,00:00:00
	if (year< 1980 || month < 1 || month > 12 || day < 1 || day > 31)
		weekno = 0;
        gpstime=0;
        return;
	end
	if (month == 1)
		dayofy = day;
	else
		dayofy = 0;
		for m=1:month-1
			dayofy=dayofy+dinmth(m);
			if ( m==2 )
				if (mod(year,4)== 0 && mod(year,100)~= 0 || mod(year,400)== 0)
					dayofy=dayofy+1;
				end
			end
		end
		dayofy =dayofy+ day;
	end
	if (year==1980)
		ttlday=dayofy-6;
	else 
		ttlday = 360;
        if(year~=1981)
            for yr=1981:year-1
                ttlday  =ttlday+ 365;
                if (mod(yr,4)==0 && mod(yr,100)~=0 || mod(yr,400)==0)
                    ttlday  =ttlday+ 1;
                end
            end
        end
        ttlday =ttlday+ dayofy;
    end
	weekno= floor(ttlday/7);
	dayofw  = ttlday - 7 * weekno;
	gpstime =  hour * 3600 + minute * 60 + second + dayofw * 86400;
end

