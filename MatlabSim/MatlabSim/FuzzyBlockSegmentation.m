function [Uout, Wout] = FuzzyBlockSegmentation(width,height,xmin,ymin,minD,UWTform)
% Block Segmentation
% out is an array or structure of rectangular vertices
% 1. divide width and height into hw and hh number of divisions
% respectively
% Segment a region and generate random ice pieces.
subDiv = 5;  % # of subpoints per line
iceWater = [0,0,1,1,1];  % 0 = water, 1 = ice
sn = [-1,1];
dev = 0.01;
f = 0.05;

yDiv = [2,3,4,3,2,2,2,3,3,4];  % distribution of number of divisions along y
z = zeros(80,1);
ang = (1:1:350)';
d = [z;ang];
angdev = d(ceil(rand(length(d),1)*length(d)));

ld = [z;(-20:0.5:20)'];
ldev = ld(ceil(rand(length(ld),1)*length(ld)));



yh = yDiv(ceil(length(yDiv)*rand(1,1)));%minD; % + ceil(minD*rand(1,1))-1;  % height divisions
dy = height/yh; %
y = 0;  %  coordinate of first horizontal line
pt = struct('PatchPts',[]);

i = 1;
Uout(i,1) = pt;
Wout(i,1) = pt;
while y < height
    % 1. Divide width into hw parts
    xh = minD;% + ceil(minD*rand(1,1))-1;  % width divisions
    x = 0;
    if y >= height
        y = height;
    end
    dx = width/xh;
    while x < width
        if x >= width
            x = width;
        end
        worice = iceWater(ceil(rand(1,1)*length(iceWater)));    % water or ice
        if worice == 1   % ice
            minx = x + xmin;
            maxx = minx + dx;
            miny = y + ymin;
            maxy = miny + dy;

            nx = 0:dev:f*dx;    % deviation added
            nx = nx';
            ny = 0:dev:f*dy;    % deviation added
            ny = ny';

            ptsAB = zeros(subDiv,2);
            ptsBC = ptsAB;
            ptsCD = ptsAB;
            ptsDA = ptsAB;

            ptsAB(:,2) = linspace(miny,maxy,subDiv);
            ptsAB(:,1) = minx;
            sns = sn(ceil(rand(subDiv,1)*length(sn)));    % signs
            devx = sns'.*nx(ceil(rand(subDiv,1)*length(nx)));
            ptsAB(:,1) = ptsAB(:,1) + devx;     % deviations

            ptsBC(:,1) = linspace(minx,maxx,subDiv);
            ptsBC(:,2) = maxy;
            sns = sn(ceil(rand(subDiv,1)*length(sn)));    % signs
            devy = sns'.*ny(ceil(rand(subDiv,1)*length(ny)));
            ptsBC(:,2) = ptsBC(:,2) + devy;     % deviations

            ptsCD(:,2) = linspace(maxy,miny,subDiv);
            ptsCD(:,1) = maxx;
            sns = sn(ceil(rand(subDiv,1)*length(sn)));    % signs
            devx = sns'.*nx(ceil(rand(subDiv,1)*length(nx)));
            ptsCD(:,1) = ptsCD(:,1) + devx;     % deviations

            ptsDA(:,1) = linspace(maxx,minx,subDiv);
            ptsDA(:,2) = miny;
            devy = sns'.*ny(ceil(rand(subDiv,1)*length(ny)));
            ptsDA(:,2) = ptsDA(:,2) + devy;     % deviations
            pts = [ptsAB(1:end-1,:);ptsBC(1:end-1,:);ptsCD(1:end-1,:);ptsDA(1:end-1,:)];

            %rotate points
%             a = angdev(ceil(rand(1,1)*length(angdev)));    % rotation angle
%             xd = ld(ceil(rand(1,1)*length(ld)));
%             yd = ld(ceil(rand(1,1)*length(ld)));
% 
%             pts = ([cosd(a) -sind(a);sind(a) cosd(a)]*pts')';
%             pts(:,1) = pts(:,1) + xd;
%             pts(:,2) = pts(:,2) + yd;
            w1 = [pts ones(size(pts,1),1)]*UWTform;
            w2 = w1./w1(:,3);
            pt.PatchPts = pts;
            Uout(i,1) = pt;
            pt.PatchPts = w2;
            Wout(i,1) = pt;
            i = i + 1;
        end        
        x = x + dx;
    end
    y = y + dy; 
end
% figure,
% for i = 1:size(out,1)
%     x = [out(i).A(1);out(i).B(1);out(i).C(1);out(i).D(1);out(i).A(1)];
%     y = [out(i).A(2);out(i).B(2);out(i).C(2);out(i).D(2);out(i).A(2)];
%     plot(x,y);
%     hold on
%     plot(out(i).E(1),out(i).E(2),'*');
% end
% hold off
% xlabel('X');
% ylabel('Y');
    



% 2. divide
end

% p = [0 0 0 0 1 1 2 2 3 3 4 4 5 6 7];
% gp = zeros(400,1);
% k = 1;
% 
% count = [0 0;1 0;2 0;3 0;4 0;5 0;6 0;7 0];
% while k <= length(gp)
%     s = ceil(length(p)*rand(1,1));
%     gp(k,1) = p(s);
%     switch(p(s))
%         case 0
%             count(1,2) = count(1,2) + 1;
%         case 1
%             count(2,2) = count(2,2) + 1;
%         case 2
%             count(3,2) = count(3,2) + 1;
%         case 3
%             count(4,2) = count(4,2) + 1;
%         case 4
%             count(5,2) = count(5,2) + 1;
%         case 5
%             count(6,2) = count(6,2) + 1;
%         case 6
%             count(7,2) = count(7,2) + 1;
%         otherwise
%             count(8,2) = count(8,2) + 1;
%     end
% 
%     k = k+1;
% end