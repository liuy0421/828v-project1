function [x_k,fs,gs,runtime] = SG(x0,Y,ffun,gfun,batch_size,alpha_strat,nsteps)
    [n,~] = size(Y);
    fs = zeros(1,nsteps);
    gs = zeros(1,nsteps);
    x_k = x0;
    tStart = tic;
    alpha = 0.1;
    for k = 1: nsteps
        I = randperm(n,batch_size); 
        g = gfun(I,Y,x_k);
        gs(k) = norm(g);
        fs(k) = ffun(1:n,Y,x_k);
        if strcmp(alpha_strat, "constant")
            alpha = 0.001;
        elseif strcmp(alpha_strat, "slow")
            alpha = 0.1/k;
        elseif strcmp(alpha_strat, "exponential")
            alpha = alpha/1.1;
        else
            alpha = 0.001;
        end
        x_k = x_k  -alpha*g;
    end
    runtime = toc(tStart);
end