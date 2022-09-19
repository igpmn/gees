function p = baselineArea(p)

    try, p; catch, p = struct(); end

    p.ss_ar = 1;
    p.ss_nr = 1;

    p.ss_nw_to_nn = 0.65;
    p.ss_nf_to_nw = 0.70;

    p.beta = 0.95;
    p.ss_zk = 0.90;
    p.ss_zy = 1;
    p.delta = 0.15;
    p.eta = 0;
    p.eta0 = 1;

    p.nu_0 = 0;
    p.nu_1 = 0.07;
    p.ss_zh_aut = 0;

    p.rho_nr = 0.9;
    p.rho_nw = 0.9;
    p.rho_nf = 0.5;

    p.rho_w = 0.50;
    p.rho_zk = 0.90;
    p.rho_zy = 0.90;

    p.chi = 1;
    p.chi_curr = 0.10;
    p.chi_ch = 0.30;

    p.rho_zh_aut = 0.70;
    p.theta_1 = 0.10;
    p.theta_2 = 1;

    p.mu_y3 = 1.30;

    p.gamma_n0 = 1/3;
    p.gamma_m = 0.15;
    p.gamma_q = 0.05;
    p.gamma_uk = 0.30;
    p.gamma_yz = 0.60;
    p.gamma_xx = 0.50;

    p.alpha = 0.4;

    p.upsilon_0 = 1;
    p.upsilon_1 = 1/0.2;

    p.xi_y3 = 0.85;
    p.xi_y2 = 0.5;
    p.xi_y1 = 2;

    p.xi_k = 0.5;
    p.xi_ih1 = 0;
    p.xi_ih2 = 0.8;

    p.rho_ar = 0.5;

    p.zeta_e = 0.5;

    % Price setting
    p.mu_py = 1.10;
    p.xi_py = 25;
    p.zeta_py = 0;

    % Monetary policy
    p.rho_r = 0.50;
    p.psi_pc = 2.5;
    p.psi_e = 0;
    p.psi_nh = 0;
    p.floor = 1;

    % Fiscal policy
    p.ss_ncg_to_ngdp = 0.20;
    p.ss_dg_to_ngdp = 0.40;
    p.rho_cg = 0.5;
    p.rho_txls1 = 0.5;
    p.tau_txls1 = 2.5;
    p.tau_cg = 0;
    p.rho_txls2 = 0.5;
    p.ss_trm = 0;
    p.rho_trm = 0;

    % Commodity sector
    p.lambda = 1;
    p.gg_iota_1 = 0.2;
    p.gg_rho_qq = 0.8;

    % p.gg_rho_aqq = 0.7;
    % p.gg_ss_aq = 1;

    p.theta_3 = 0;

end%

