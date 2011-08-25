function [y, t] = y_sim(C, b, w, t_end)
    frequency = 1000;
    K_p = 60;
    
    t = 0 : 1/frequency : t_end;
    r = 0.06 * sin(w * t);

    G = tf([b*K_p], [1 C b*K_p]);
    
    y = lsim(G, r, t)';
