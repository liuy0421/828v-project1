function [fs,gs,runtime] = SINewton_experiment(w,fun,gfun,Hvec,Y,bsz,nsteps,nruns)
    fs = zeros(nruns,nsteps+1);
    gs = zeros(nruns,nsteps);
    runtime = zeros(nruns,1);
    for i = 1 : nruns
        [~,f,g,time] = SINewton_mod(fun,gfun,Hvec,Y,w,bsz);
        fs(i,:) = f';
        gs(i,:) = g';
        runtime(i) = time;
    end
    fs = sum(fs)/nruns;
    gs = sum(gs)/nruns;
    runtime = sum(runtime)/nruns;
end