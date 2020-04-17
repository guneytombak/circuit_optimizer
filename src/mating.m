function matingSel = mating(fr, hete, N)

noC = length(fr);
matingSel = zeros(N/2,1);

for k = 1:(N/2)
    
    %% Random Selection
    
    % candidates
    c1 = randi(noC,1);
    c2 = randi(noC,1);
    
    % should not be itself 
    while (c1 == c2)
        c2 = randi(noC,1);
    end
    
    %% Rivalry
    
%     if fr(c1) == fr(c2) % if the same front
%         if hete(c1) <= hete(c2) % select more homogeneous one
%             pS = c1;
%         else
%             pS = c2;
%         end
%     elseif fr(c1) < fr(c2) % select the lower front
%         pS = c1;
%     else
%         pS = c2;
%     end
    
    if rand > 0.5
        pS = c1;
    else
        pS = c2;
    end
    

    %% Check of Previous Parrents
    
    while any(matingSel == pS)
        pS = randi(noC,1);
    end
    
    matingSel(k,:) = pS;

end

end