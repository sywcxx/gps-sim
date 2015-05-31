classdef OrbitData
    properties
        sPVASat;
		sEphData;
		sAlmData;
		alpha;
		zenith;
		visflag;		
    end
    
    methods
        function a = OrbitData(varargin)
			a.sPVASat=PVA(0);
			a.sEphData=EphData;
			a.sAlmData=AlmData;
			a.alpha=0;
			a.zenith=0;
			a.visflag=0;
        end
     end
end