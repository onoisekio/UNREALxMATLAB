% Define the travel path for the UAV
load('SimEnvironment.mat');
%1. Locate rectangle centres
len = size(Env.SurveyTable,1);
pts = zeros(1,2);
k = 1;
for i = 1:len
    pts(k,:) = [Env.SurveyTable.UnrealStartX(i),Env.SurveyTable.UnrealStartY(i)];
    k = k + 1;
    pts(k,:) = [Env.SurveyTable.UnrealStopX(i),Env.SurveyTable.UnrealStopY(i)];
    k = k+1;
end
pts1 = unique(pts,'rows');

p = polyfit(pts1(:,1),pts1(:,2),3);
minx = min(pts1(:,1));
maxx = max(pts1(:,1));
x = minx:1:maxx;
x = x';
y = p(1)*x.^3 + p(2)*x.^2 + p(3)*x + p(4);


figure,plot(pts1(:,1),pts1(:,2),'*-b')
hold on
plot(x,y,'+-r')
hold off 

len = size(Env.RiverRegions,1);
centres = zeros(len,2);  % x and y coordinates of the rectangle centres

for i = 1:len
    A = [Env.UnrealRiverPts(Env.RiverRegions(i,1),1) Env.UnrealRiverPts(Env.RiverRegions(i,1),2)];
    B = [Env.UnrealRiverPts(Env.RiverRegions(i,2),1) Env.UnrealRiverPts(Env.RiverRegions(i,2),2)];
    C = [Env.UnrealRiverPts(Env.RiverRegions(i,3),1) Env.UnrealRiverPts(Env.RiverRegions(i,3),2)];
    D = [Env.UnrealRiverPts(Env.RiverRegions(i,4),1) Env.UnrealRiverPts(Env.RiverRegions(i,4),2)];
    centres(i,:) = [(A(1)+B(1))/2, (B(2)+C(2))/2];

    x = [A(1);B(1);C(1);D(1);A(1)];
    y = [A(2);B(2);C(2);D(2);A(2)];
    plot(x,y);
    hold on
    plot(centres(i,1),centres(i,2),'*');
end
p = polyfit(centres(:,1),centres(:,2),3);
minx = -410;
maxx = 500;
xPoly = minx:1:maxx;
xPoly = xPoly';
yPoly = p(1)*xPoly.^3 + p(2)*xPoly.^2 + p(3)*xPoly + p(4);
grad = 180/pi*atan(3*p(1)*xPoly.^2 + 2*p(2)*xPoly + p(3));


plot(xPoly, yPoly);
hold off
xlabel('X');
ylabel('Y');

v = 2;  % speed
ft = 1/30;  % frame period
k = 1;
len = length(xPoly);
DronePosN = zeros(1,3);
for j = 1:len-1
    ds = sqrt((xPoly(j+1)-xPoly(j))^2 + (yPoly(j+1)-yPoly(j))^2); % st line distance between start and end points
    dt = ds/v; % time to travel the line
    N = dt/ft; % distance travelled
    dx = (xPoly(j+1) - xPoly(j))/N;
    dy = (yPoly(j+1) - yPoly(j))/N;
    dTh = (grad(j+1) - grad(j))/N; % rotation change
    x = xPoly(j);
    y = yPoly(j);
    Th = grad(j);
    DronePosN(k,:) = [xPoly(j), yPoly(j) grad(j)];
    x = x + dx;
    y = y + dy;
    Th = Th + dTh;
    k = k + 1;

    if dx < 0  % x2 < x1
        while x > xPoly(j+1)
            y = ((yPoly(j+1)-yPoly(j))/(xPoly(j+1)-xPoly(j)))*(x-xPoly(j)) + yPoly(j);
            DronePosN(k,:) = [x,y,Th];
            k = k + 1;
            x = x + dx;
            Th = Th + dTh;
        end
    elseif dx > 0
        while x < xPoly(j+1)
            y = ((yPoly(j+1)-yPoly(j))/(xPoly(j+1)-xPoly(j)))*(x-xPoly(j)) + yPoly(j);
            DronePosN(k,:) = [x,y,Th];
            k = k + 1;
            x = x + dx;
            Th = Th + dTh;
        end
    else
        if dy < 0
            while y > yPoly(j+1)
                DronePosN(k,:) = [x,y,Th];
                y = y + dy;
                Th = Th + dTh;
                k = k + 1;
            end
        else
            while y < yPoly(j+1)
                DronePosN(k,:) = [x,y,Th];
                y = y + dy;
                Th = Th + dTh;
                k = k + 1;
            end
        end
    end
    %ShipPosN(k,:) = [ShipPos(j+1,1:3)];
    %k = k + 1;
end
DronePosN(k,:) = [xPoly(j), yPoly(j) grad(j)];
