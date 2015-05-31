classdef Time
    properties
		year,month,day,hour,minute,second;
    end
    
    methods
        function a = Time(varargin)
            if(nargin==1)
                a.year=0;
                a.month=0;
                a.day=0;
				a.hour=0;
				a.minute=0;
				a.second=0;
            else
                a.year=cell2mat(varargin(1));
                a.month=cell2mat(varargin(2));
                a.day=cell2mat(varargin(3));
				a.hour=cell2mat(varargin(4));
				a.minute=cell2mat(varargin(5));
				a.second=cell2mat(varargin(6));
            end                
        end
     end
end