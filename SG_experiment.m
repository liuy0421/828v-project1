function [fs,gs,runtime] = SG_experiment(x0,Y,ffun,gfun,batch_size,alpha_strat,nsteps,nruns)
    fs = zeros(nruns,nsteps);
    gs = zeros(nruns,nsteps);
    runtime = zeros(nruns,1);
    for i = 1 : nruns
        [~,f,g,time] = SG(x0,Y,ffun,gfun,batch_size,alpha_strat,nsteps);
        fs(i,:) = f;
        gs(i,:) = g;
        runtime(i) = time;
    end
    fs = sum(fs)/nruns;
    gs = sum(gs)/nruns;
    runtime = sum(runtime)/nruns;
end