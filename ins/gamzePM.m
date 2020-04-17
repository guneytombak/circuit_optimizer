function [pm] = gamzePM(hreal, himg)
    if(himg>0 && hreal>0)
        pm=(atan(himg/hreal)*180/pi);
    elseif(himg>0 && hreal<0)
        pm=0.1;%180-(atan(himg/hreal)*180/pi);
    elseif(himg<0 && hreal<0)
        pm=atan(himg/hreal)*180/pi;%180+(-1*(atan(himg/hreal)/pi*180));
    else
        pm=10;
    end
end

