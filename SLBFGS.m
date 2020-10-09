function [fs,gnorm,time] = SLBFGS(x0,Y,func,gfun,alpha_strat,ng,nh,M,nsteps)

    [n,dim] = size(Y);
    m = 5; % the number of steps to keep in memory
    s = zeros(dim,m); y = zeros(dim,m); rho = zeros(1,m);
    gnorm = zeros(1,nsteps);
    fs = zeros(1,nsteps);
    x = x0;
    
    % specifying step size decrease strategy
    if strcmp(alpha_strat, "constant")
        alpha = @(k)0.001;
    elseif strcmp(alpha_strat, "slow")
        alpha = @(k)0.1/k;
    elseif strcmp(alpha_strat, "exponential")
        alpha = @(k)0.1/(1.1^(k-1));
    else
        alpha = @(k)0.001;
    end

    % initializing P = {(s,y)}
    Ih = randperm(n,nh); 
    g = gfun(Ih,Y,x);
    s(:,1) = alpha(1)*g;
    y(:,1) = gfun(Ih,Y,x+s(:,1)) - gfun(Ih,Y,x);
    rho(1) = 1/(s(:,1)'*y(:,1));
    
    tStart = tic;
    for k = 1:nsteps
        % compute stochastic gradient
        Ig = randperm(n,ng); 
        g = gfun(Ig,Y,x); 
        gnorm(k) = norm(g);
        fs(k) = func(1:n,Y,x);
        if k < m
            I = 1 : k;
            p = finddirection(g,s(:,I),y(:,I),rho(I));
        else
            p = finddirection(g,s,y,rho);
        end
        
        a = alpha(k);
        x_new = x + a * p;
        
        % update pairs
        if mod(k,M) == 0
            Ih = randperm(n,nh);
            h = gfun(Ih,Y,x);
            pk = finddirection(h,s,y,rho);
            sk = a*pk;
            yk = gfun(Ih,Y,x+sk)-gfun(Ih,Y,x);
            
            s = circshift(s,[0,1]); 
            y = circshift(y,[0,1]);
            rho = circshift(rho,[0,1]);
            s(:,1) = sk;
            y(:,1) = yk;
            rho(1) = 1/(sk'*yk);
        end       
        x = x_new;
    end
    time = toc(tStart);
end
