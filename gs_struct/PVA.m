classdef PVA
    properties
        pos;
        vel;
        acc;   
    end
    
    methods
        function a = PVA(varargin)
            a.pos=Coordinate(0);
            a.vel=Coordinate(0);
            a.acc=Coordinate(0);
        end
     end
end