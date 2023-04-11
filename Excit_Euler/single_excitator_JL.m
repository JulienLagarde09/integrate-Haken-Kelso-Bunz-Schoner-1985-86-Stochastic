function ydot = single_excitator_JL(t,y,a,b,c,gamma,dt1,dt2,dt3,...
                dt4,dt5,dt6,dt7,dt8,dt9,dt10,dt11,dt12)

    % one excitator
    % perturbation da1 is introduced when t = dt1 and for duration =
    % duration_pert (in number of samples)
    duration_pert = 1;% in number of samples
    
%     perturb = zeros(1,length(time));    
%     rankpert = 1:100:length(time);
%     for rr = 1:length(rankpert)        
%     if ii == rankpert(rr)
%         perturb(ii) = perturb(ii) + 0.5;
%     end
%     end
        
    da1 = block(t,dt1,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da2 = block(t,dt2,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da3 = block(t,dt3,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da4 = block(t,dt4,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da5 = block(t,dt5,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da6 = block(t,dt6,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da7 = block(t,dt7,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da8 = block(t,dt8,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da9 = block(t,dt9,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da10 = block(t,dt10,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da11 = block(t,dt11,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
    da12 = block(t,dt12,duration_pert);% da1 = 1 from time dt1 to duration specified, 0 othewise
%     
    da = da1 + da2 + da3 + da4 + da5 + da6 +da7...
        + da8 + da9 + da10 + da11 + da12;
    
    ydot(1) = c*(y(2)+gamma*y(1)-y(1)^3/3 ) ;  
        
    ydot(2) =  -(y(1)-a + da + b*y(2) )/c ;% perturb(ii) ;

    
    



