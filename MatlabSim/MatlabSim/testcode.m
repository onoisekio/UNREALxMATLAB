load('SimEnvironment.mat')
a = [Env.UnrealRiverPts,ones(size(Env.UnrealRiverPts,1),1)];
b1 = a*Env.UnrealToWorldTform;
b2 = b1./b1(:,3);
Env.RealWorldRiverPts = [b2(:,2),b2(:,1)];
save('SimEnvironment.mat','Env');
load('SimEnvironment.mat')
