function [fs,gs,runtime] = SLBFGS_experiment(x0,Y,func,gfun,alpha_strat,ng,nh,M,nsteps,nruns)
    fs = zeros(nruns,nsteps);
    gs = zeros(nruns,nsteps);
    runtime = zeros(nruns,1);
    for i = 1 : nruns
        [f,g,time] = SLBFGS(x0,Y,func,gfun,alpha_strat,ng,nh,M,nsteps);
        fs(i,:) = f;
        gs(i,:) = g;
        runtime(i) = time;
    end
    fs = sum(fs)/nruns;
    gs = sum(gs)/nruns;
    runtime = sum(runtime)/nruns;
end