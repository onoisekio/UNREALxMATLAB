function [Uout, Wout] = BlockSegmentation(width,height,xmin,ymin,minD,UWTform)
% Block Segmentation
% out is an array or structure of rectangular vertices
% 1. divide width and height into hw and hh number of divisions
% respectively

yh = minD; % + ceil(minD*rand(1,1))-1;  % height divisions
dy = height/yh; %
y = 0;  %  coordinate of first horizontal line
pt = struct('A',[],'B',[],'C',[],'D',[],'E',[]);

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
        pt.A =  [x + xmin,y + ymin];
        pt.B = [x + dx + xmin,y + ymin];
        pt.C = [x + dx + xmin, y + dy + ymin];
        pt.D = [x + xmin, y + dy + ymin];
        pt.E = [(pt.A(1)+pt.B(1))/2, (pt.B(2)+pt.C(2))/2];
        Uout(i,1) = pt;

        %Unreal to World Transform
        W1 = [pt.A 1;pt.B 1;pt.C 1;pt.D 1;pt.E 1]*UWTform;
        W2 = W1./W1(:,3);
        pt.A = W2(1,1:2);
        pt.B = W2(2,1:2);
        pt.C = W2(3,1:2);
        pt.D = W2(4,1:2);
        pt.E = W2(5,1:2);
        Wout(i,1) = pt;

        i = i + 1;
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