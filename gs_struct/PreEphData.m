classdef PreEphData
    properties
		sT;
        dsec;
        sCoorSatPos;
    end
    
    methods
        function a = PreEphData(varargin)
            if(nargin==1)
                a.sT=Time(0);
                a.dsec=0;
                a.sCoorSatPos=Coordinate(0);
            end
        end
     end
end