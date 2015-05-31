%******************************************
% Name: GetSatState.m
% Function: calculate the satellite's state(position, velocity and acceleration)
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function PVASat = GetSatState(t,ephdata)
    % constant
    global CT;
    %% calculate the position
        % calculate the observation time
        tk=t-ephdata.Toe;
        if(tk>302400)
            tk=tk-64800;
        elseif tk<-302400
            tk=tk+604800;
        end
        % corrected mean motion
        as=ephdata.Asqrt^2;
        n0=sqrt(CT.U/(as^3));
        n=n0+ephdata.dn;
        % mean anomaly
        Mk=ephdata.m0+n*tk;
        Mk=mod(Mk,2*CT.PI);
        % Eccentric anomaly
        E0=Mk;
        E1=Mk+ephdata.ecc*sin(E0);
        while (abs(E1-E0)>1e-10)
            E0=E1;
            E1=Mk+ephdata.ecc*sin(E0);
        end
        Ek=E1;
        % true anomaly
        cosvk=(cos(Ek)-ephdata.ecc)/(1-ephdata.ecc*cos(Ek));
        sinvk=sin(Ek)*sqrt(1-ephdata.ecc^2)/(1-ephdata.ecc*cos(Ek));
        vk=atan2(sinvk,cosvk);
        % argument of Latitude
        phak=vk+ephdata.w;
        % second Harmonic Perturbations
        duk=ephdata.Cus*sin(2*phak)+ephdata.Cuc*cos(2*phak);
        drk=ephdata.Crs*sin(2*phak)+ephdata.Crc*cos(2*phak);
        dik=ephdata.Cis*sin(2*phak)+ephdata.Cic*cos(2*phak);
        % corrected argument of Latitude,corrected radius and corrected Inclination
        uk=phak+duk;
        rk=as*(1-ephdata.ecc*cos(Ek))+drk;
        ik=ephdata.I0+ephdata.Idot*tk+dik;
        % position in orbital plane
        xk1=rk*cos(uk);
        yk1=rk*sin(uk);
        zk1=0;
        % corrected longitude of ascending node
        omk=ephdata.Omega0+(ephdata.Omegadot-CT.WE)*tk-CT.WE*ephdata.Toe;
        % position in WGS 84
        xk=xk1*cos(omk)-yk1*cos(ik)*sin(omk);
        yk=xk1*sin(omk)+yk1*cos(ik)*cos(omk);
        zk=yk1*sin(ik);
        PVASat.pos.first=xk;
        PVASat.pos.second=yk;
        PVASat.pos.third=zk;
    %% calculate the velocity
        % ekdt
        mkdt=n;
        ekdt=mkdt/(1-ephdata.ecc*cos(Ek));
        % phakdt
        vkdt=sqrt(1-ephdata.ecc^2)*ekdt/(1-ephdata.ecc*cos(Ek));
        phakdt=vkdt;
        % dukdt,drkdt,dikdt
        dukdt=2*phakdt*(ephdata.Cus*cos(2*phak)-ephdata.Cuc*sin(2*phak));
        drkdt=2*phakdt*(ephdata.Crs*cos(2*phak)-ephdata.Crc*sin(2*phak));
        dikdt=2*phakdt*(ephdata.Cis*cos(2*phak)-ephdata.Cic*sin(2*phak));
        % ukdt,rkdt,ikdt,omkdt
        ukdt=phakdt+dukdt;
        rkdt=as*ephdata.ecc*ekdt*sin(Ek)+drkdt;
        ikdt=ephdata.Idot+dikdt;
        omkdt=ephdata.Omegadot-CT.WE;
        % xk1dt,yk1dt
        xk1dt=rkdt*cos(uk)-rk*ukdt*sin(uk);
        yk1dt=rkdt*sin(uk)+rk*ukdt*cos(uk);
        % xkdt,ykdt,zkdt£¬the unit is m/s
        xkdt=-yk*omkdt-(yk1dt*cos(ik)-zk*ikdt)*sin(omk)+xk1dt*cos(omk);
        ykdt=xk*omkdt+(yk1dt*cos(ik)-zk*ikdt)*cos(omk)+xk1dt*sin(omk);
        zkdt=yk1dt*sin(ik)+ykdt*ikdt*cos(ik);
        PVASat.vel.first=xkdt;
        PVASat.vel.second=ykdt;
        PVASat.vel.third=zkdt;
    %% calculate the acceleration
        mkdt2=0;
        ekdt2=-(ekdt^2*ephdata.ecc*sin(Ek))/(1-ephdata.ecc*cos(Ek));
        vkdt2=2*vkdt*ekdt2/ekdt;
        phakdt2=vkdt2;
        dukdt2=phakdt2*dukdt/phakdt-4*phakdt^2*duk;
        drkdt2=phakdt2*drkdt/phakdt-4*phakdt^2*drk;
        dikdt2=phakdt2*dikdt/phakdt-4*phakdt^2*dik;
        omkdt2=0;
        ukdt2=phakdt2+dukdt2;
        rkdt2=as*ephdata.ecc*ekdt2*sin(Ek)+as*ephdata.ecc*ekdt^2*cos(Ek)+drkdt2;
        ikdt2=dikdt2;
        xk1dt2=rkdt2*cos(uk)-2*ukdt*rkdt*sin(uk)-ukdt^2*xk1-ukdt2*yk1;
        yk1dt2=rkdt2*sin(uk)+2*ukdt*rkdt*cos(uk)-ukdt^2*yk1+ukdt2*xk1;
        alphak=zkdt*ikdt+zk*ikdt2-xk1dt*omkdt+yk1dt*ikdt*sin(ik)-yk1dt2*cos(ik);
        betak=xk1dt2+zk*ikdt*omkdt-yk1dt*omkdt*cos(ik);
        xkdt2=-ykdt*omkdt+alphak*sin(omk)+betak*cos(omk);
        ykdt2=xkdt*omkdt-alphak*cos(omk)+betak*sin(omk);
        zkdt2=(yk1dt2-yk1dt*ikdt^2)*sin(ik)+(yk1*ikdt2+2*yk1dt*ikdt)*cos(ik);
        PVASat.acc.first=xkdt2;
        PVASat.acc.second=ykdt2;
        PVASat.acc.third=zkdt2;
end

