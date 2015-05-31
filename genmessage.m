%******************************************
% Name: genmessage.m
% Function: generate the nav message. 
% Author: Liwei Jia
% Date: 2015-05-31
% Email: liweij2008@gmail.com
%******************************************
function genmessage()
    global SimGlobal;
    global CT;
    t=SimGlobal.t;
    tongbuma='10001011';
    yaocema=repmat('0',1,14);
    for i=1:10
        ZeroSub.w(i)=cellstr('0');
    end
	ZeroWord=repmat('0',1,30);
    znum=floor(mod(t/6+1,100800));
    for i=1:CT.MaxSatNum
        pO=SimGlobal.aSatData(i).sOrbitData;
        pN=SimGlobal.aSatData(i).sNavData;
		pE=SimGlobal.aSatData(i).sOrbitData.sEphData;
        if(pO.visflag==1)
            switch pN.msgflag
                case 1 % subframe 1
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(1)=ZeroSub;
                    %word1
                    w1p=[tongbuma yaocema '00'];
                    w1=ParityCheck(ZeroWord,w1p);
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(1)=cellstr(w1);
					%word2
					znumc=factor(znum,0,17);
					zizhenma=1;
					zizhenmac=factor(zizhenma,0,3);
					w2p=noni(w1,[znumc '00' zizhenmac]);
					w2=ParityCheck(w1,w2p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(2)=cellstr(w2);
					%word3
					wn=factor(pE.weekno,0,10);
					caorp=factor(1,0,2);
					ura=factor(pE.Ura,0,4);
					sv=factor(pE.SV_health,0,6);
					iodc=factor(pE.Iodc,0,10);
					w3p=[wn caorp ura sv iodc(1:2)];
					w3=ParityCheck(w2,w3p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(3)=cellstr(w3);
					%word4
					w4p=repmat('0',1,24);
					w4=ParityCheck(w3,w4p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(4)=cellstr(w4);	
					%word5
					w5p=repmat('0',1,24);
					w5=ParityCheck(w4,w5p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(5)=cellstr(w5);%word6
					w6p=repmat('0',1,24);
					w6=ParityCheck(w5,w6p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(6)=cellstr(w6);
					%word7
					tgd=factor(pE.Tgd,31,8);
					w7p=[repmat('0',1,16) tgd];
					w7=ParityCheck(w6,w7p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(7)=cellstr(w7);
					%word8
					toc=factor(pE.Toe,-4,16);
					w8p=[iodc(3:10) toc];
					w8=ParityCheck(w7,w8p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(8)=cellstr(w8);
					%word9
					af2=factor(pE.af2,55,8);
					af1=factor(pE.af1,43,16);
					w9p=[af2 af1];
					w9=ParityCheck(w8,w9p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(9)=cellstr(w9);
					%word10
					af0=factor(pE.af0,31,22);
					w10p=noni(w9,af0);
					w10=ParityCheck(w9,w10p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(1).w(10)=cellstr(w10);
                case 2
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(2)=ZeroSub;
                    %word1
                    w1p=[tongbuma yaocema '00'];
                    w1=ParityCheck(ZeroWord,w1p);
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(1)=cellstr(w1);
					%word2
					znumc=factor(znum,0,17);
					zizhenma=2;
					zizhenmac=factor(zizhenma,0,3);
					w2p=noni(w1,[znumc '00' zizhenmac]);
					w2=ParityCheck(w1,w2p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(2)=cellstr(w2);
					%word3
					iode=factor(pE.iode,0,8);
					crs=factor(pE.Crs,5,16);
					w3p=[iode crs];
					w3=ParityCheck(w2,w3p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(3)=cellstr(w3);
					%word4
					dn=factor(pE.dn/CT.PI,43,16);
					m0=factor(pE.m0/CT.PI,31,32);
					w4p=[dn m0(1:8)];
					w4=ParityCheck(w3,w4p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(4)=cellstr(w4);	
					%word5
					w5p=m0(9:32);
					w5=ParityCheck(w4,w5p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(5)=cellstr(w5);%word6
					cuc=factor(pE.Cuc,29,16);
					ecc=factor(pE.ecc,33,32);
					w6p=[cuc ecc(1:8)];
					w6=ParityCheck(w5,w6p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(6)=cellstr(w6);
					%word7
					w7p=ecc(9:32);
					w7=ParityCheck(w6,w7p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(7)=cellstr(w7);
					%word8
					cus=factor(pE.Cus,29,16);
					Asqrt=factor(pE.Asqrt,19,32);
					w8p=[cus Asqrt(1:8)];
					w8=ParityCheck(w7,w8p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(8)=cellstr(w8);
					%word9
					w9p=Asqrt(9:32);
					w9=ParityCheck(w8,w9p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(9)=cellstr(w9);
					%word10
					toe=factor(pE.Toe,-4,16);
					w10p=noni(w9,[toe repmat('0',1,6)]);
					w10=ParityCheck(w9,w10p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(2).w(10)=cellstr(w10);				   
                case 3
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(3)=ZeroSub;
                    %word1
                    w1p=[tongbuma yaocema '00'];
                    w1=ParityCheck(ZeroWord,w1p);
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(1)=cellstr(w1);
					%word2
					znumc=factor(znum,0,17);
					zizhenma=3;
					zizhenmac=factor(zizhenma,0,3);
					w2p=noni(w1,[znumc '00' zizhenmac]);
					w2=ParityCheck(w1,w2p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(2)=cellstr(w2);
					%word3
					cic=factor(pE.Cic,29,16);
					Omega0=factor(pE.Omega0/CT.PI,31,32);
					w3p=[cic Omega0(1:8)];
					w3=ParityCheck(w2,w3p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(3)=cellstr(w3);
					%word4
					w4p=Omega0(9:32);
					w4=ParityCheck(w3,w4p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(4)=cellstr(w4);	
					%word5
					cis=factor(pE.Cis,29,16);
					i0=factor(pE.I0/CT.PI,31,32);
					w5p=[cis i0(1:8)];
					w5=ParityCheck(w4,w5p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(5)=cellstr(w5);
                    %word6
					w6p=i0(9:32);
					w6=ParityCheck(w5,w6p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(6)=cellstr(w6);
					%word7
					crc=factor(pE.Crc,5,16);
					w=factor(pE.w/CT.PI,31,32);
					w7p=[crc w(1:8)];
					w7=ParityCheck(w6,w7p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(7)=cellstr(w7);
					%word8
					w8p=w(9:32);
					w8=ParityCheck(w7,w8p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(8)=cellstr(w8);
					%word9
					Omegadot=factor(pE.Omegadot/CT.PI,43,24);
					w9p=Omegadot;
					w9=ParityCheck(w8,w9p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(9)=cellstr(w9);
					%word10
					iode=factor(pE.Iode,0,8);
					idot=factor(pE.Idot/CT.PI,43,14);
					w10p=noni(w9,[iode idot]);
					w10=ParityCheck(w9,w10p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(3).w(10)=cellstr(w10);
                case 4
				    SimGlobal.aSatData(i).sNavData.sFrame.sub(4)=ZeroSub;
                    %word1
                    w1p=[tongbuma yaocema '00'];
                    w1=ParityCheck(ZeroWord,w1p);
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(1)=cellstr(w1);
					%word2
					znumc=factor(znum,0,17);
					zizhenma=4;
					zizhenmac=factor(zizhenma,0,3);
					w2p=noni(w1,[znumc '00' zizhenmac]);
					w2=ParityCheck(w1,w2p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(2)=cellstr(w2);
					%word3
					w3p=repmat('0',1,24);
					w3=ParityCheck(w2,w3p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(3)=cellstr(w3);
					%word4
					w4p=repmat('0',1,24);
					w4=ParityCheck(w3,w4p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(4)=cellstr(w4);	
					%word5
					w5p=repmat('0',1,24);
					w5=ParityCheck(w4,w5p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(5)=cellstr(w5);
					%word6
					w6p=repmat('0',1,24);
					w6=ParityCheck(w5,w6p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(6)=cellstr(w6);
					%word7
					w7p=repmat('0',1,24);
					w7=ParityCheck(w6,w7p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(7)=cellstr(w7);
					%word8
					w8p=repmat('0',1,24);
					w8=ParityCheck(w7,w8p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(8)=cellstr(w8);
					%word9
					w9p=repmat('0',1,24);
					w9=ParityCheck(w8,w9p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(9)=cellstr(w9);
					%word10
					w10p=noni(w9,repmat('0',1,22));
					w10=ParityCheck(w9,w10p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(4).w(10)=cellstr(w10);
                case 5
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(5)=ZeroSub;
                    %word1
                    w1p=[tongbuma yaocema '00'];
                    w1=ParityCheck(ZeroWord,w1p);
                    SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(1)=cellstr(w1);
					%word2
					znumc=factor(znum,0,17);
					zizhenma=5;
					zizhenmac=factor(zizhenma,0,3);
					w2p=noni(w1,[znumc '00' zizhenmac]);
					w2=ParityCheck(w1,w2p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(2)=cellstr(w2);
					%word3
					w3p=repmat('0',1,24);
					w3=ParityCheck(w2,w3p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(3)=cellstr(w3);
					%word4
					w4p=repmat('0',1,24);
					w4=ParityCheck(w3,w4p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(4)=cellstr(w4);	
					%word5
					w5p=repmat('0',1,24);
					w5=ParityCheck(w4,w5p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(5)=cellstr(w5);
					%word6
					w6p=repmat('0',1,24);
					w6=ParityCheck(w5,w6p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(6)=cellstr(w6);
					%word7
					w7p=repmat('0',1,24);
					w7=ParityCheck(w6,w7p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(7)=cellstr(w7);
					%word8
					w8p=repmat('0',1,24);
					w8=ParityCheck(w7,w8p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(8)=cellstr(w8);
					%word9
					w9p=repmat('0',1,24);
					w9=ParityCheck(w8,w9p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(9)=cellstr(w9);
					%word10
					w10p=noni(w9,repmat('0',1,22));
					w10=ParityCheck(w9,w10p);
					SimGlobal.aSatData(i).sNavData.sFrame.sub(5).w(10)=cellstr(w10);				
            end
        end        
    end
end  