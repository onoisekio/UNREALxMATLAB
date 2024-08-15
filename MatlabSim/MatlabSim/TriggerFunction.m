function y = TriggerFunction(start_HMSms,stop_M)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
y = 0;
start_ms = start_HMSms(1)*60*60*1000 + start_HMSms(2)*60*1000 + start_HMSms(3)*1000 + start_HMSms(4);    % starting ms
end_ms = start_ms + stop_M*60*1000;    % starting ms 
c = clock;
ctime = c(4)*60*60*1000 + c(5)*60*1000 + floor(c(6))*1000 + c(6)-floor(c(6));
if ctime >= start_ms && ctime < end_ms
    y = 1;
end

end