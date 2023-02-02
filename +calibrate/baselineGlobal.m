function p = baselineGlobal(p)

    try, p; catch, p = struct(); end

    p.gg_ss_roc_a = 1.02; 
    p.gg_ss_roc_nt = 1.01;

    p.gg_ss_zk = 0.90;
    p.gg_ss_zy = 1;
    p.gg_ss_dmm = 1;
    p.gg_nu = 0;

    p.gg_rho_a = 0.5;
    p.gg_rho_nt = 0.9;
    p.gg_rho_zk = 0.90;
    p.gg_rho_zy = 0.90;
    p.gg_rho_dmm = 0.50;

end%

