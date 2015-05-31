classdef SatData
    properties
        sOrbitData;
        sNavData;
		chanflag;
		chanindex;
    end
    
    methods
        function a = SatData(varargin)
			a.sOrbitData=OrbitData;
            a.sNavData=NavData;
			a.chanflag=0;
			a.chanindex=0;
        end
     end
end