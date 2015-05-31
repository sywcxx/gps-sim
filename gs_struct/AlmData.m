classdef AlmData
    properties
        PRN;
		Health;
		ecc;
		Toa;
		delta_i;
		Omegadot;
		Asqrt;
		Omega0;
		w;
		m0;
		af0;
		af1;
		week;
    end
    
    methods
        function a = AlmData(varargin)
			a.PRN=0;
			a.Health=0;
			a.ecc=0;
			a.Toa=0;
			a.delta_i=0;
			a.Omegadot=0;
			a.Asqrt=0;
			a.Omega0=0;
			a.w=0;
			a.m0=0;
			a.af0=0;
			a.af1=0;
			a.week=0;
        end
     end
end