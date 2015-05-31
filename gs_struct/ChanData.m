classdef ChanData
    properties
        PRN;
        sSubFrame;
        ChannelState;
    end
    
    methods
        function a = ChanData(varargin)
            a.PRN=0;
            a.sSubFrame=SubFrame;
            a.ChannelState=0;
        end
     end
end