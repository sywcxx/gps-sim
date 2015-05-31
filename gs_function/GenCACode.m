%******************************************
% Name: GenCACode.m
% Function: generate the CA code. 
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function cacode = GenCACode(PRN)
g2s = [  5,   6,   7,   8,  17,  18, 139, 140, 141, 251, ...
       252, 254, 255, 256, 257, 258, 469, 470, 471, 472, ...
       473, 474, 509, 512, 513, 514, 515, 516, 859, 860, ...
       861, 862];
g2shift = g2s(PRN);

% generate the G1 sequence
g1 = zeros(1, 1023);
reg = -1*ones(1, 10);

for i=1:1023
    g1(i)       = reg(10);
    tempBit     = reg(3)*reg(10);
    reg(2:10)   = reg(1:9);
    reg(1)      = tempBit;
end

% generate the G2 sequence
g2 = zeros(1, 1023);
reg = -1*ones(1, 10);

for i=1:1023
    g2(i)       = reg(10);
    tempBit     = reg(2)*reg(3)*reg(6)*reg(8)*reg(9)*reg(10);
    reg(2:10)   = reg(1:9);
    reg(1)      = tempBit;
end

% shift the G2 sequency
g2 = [g2(1023-g2shift+1 : 1023), g2(1 : 1023-g2shift)];

% generate the CA code
cacode = g1 .* g2;
