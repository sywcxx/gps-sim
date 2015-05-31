classdef NavData
    properties
        dTransTime;
        dRelVel;
        dRelAcc;
        msgflag;
        sFrame;
    end
    
    methods
        function a = NavData(varargin)
            a.dTransTime=0;
            a.dRelVel=0;
            a.dRelAcc=0;
            a.msgflag=0;
            a.sFrame=Frame;
        end
     end
end