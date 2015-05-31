%******************************************
% Name: main.m
% Function: main function. 
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
clear;clc;
global SimGlobal;
init;% Initialization
[SimGlobal.noeph,SimGlobal.aEphData]=readrinex('abpo0790.13n');% Load the ephemeris data
SimGlobal.aPreEphData=readsp3('igs17323.sp3');% Load the precision ephemeris data
SimGlobal.aSatData=selecteph;% Select the valid ephemeris for each satellite
satvisible;% Determine whether the satellite is visible
transtime;% Calculate the transfer time
genmessage;% Generate the nav message
genchannel;% Generate the channel data