classdef Coordinate
    properties
        first;
		second;
		third;   
    end
    
    methods
        function a = Coordinate(varargin)
            if(nargin==1)    
                a.first=0;
                a.second=0;
                a.third=0;
            else
                a.first=cell2mat(varargin(1));
                a.second=cell2mat(varargin(2));
                a.third=cell2mat(varargin(3));
            end
        end
     end
end