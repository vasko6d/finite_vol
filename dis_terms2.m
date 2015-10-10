function [dphi,dmhi,dphj,dmhj] = dis_terms2(u,v,c,p,N,err)
%Declare Grid Size
    dim = size(u);
    grid_res = (dim(2)-2)/40;
    IL = 40*grid_res+2; 
    JL = 20*grid_res+2;
    a = 2:JL-1; b = 2:IL-1;
%Get velocity in normal direction at bounderies
    u1 = abs(u.*N(:,:,1,1)+v.*N(:,:,2,1));
    u2 = abs(u.*N(:,:,1,2)+v.*N(:,:,2,2));
    u3 = abs(u.*N(:,:,1,3)+v.*N(:,:,2,3));
    u4 = abs(u.*N(:,:,1,4)+v.*N(:,:,2,4));
%Do the artificail viscosity stuff
        u_c_phi = u2(a,b)+c(a,b);
        abs_p_term = abs(p(a,3:IL)-2*p(a,b)+p(a,1:IL-2));
        p_term = p(a,3:IL)+2*p(a,b)+p(a,1:IL-2);
    dphi = err*u_c_phi.*(abs_p_term./p_term);
        u_c_mhi = u4(a,b)+c(a,b);
        abs_p_term(:,2:end) = abs(p(a,3:IL-1)-2*p(a,2:IL-2)+p(a,1:IL-3));
        abs_p_term(:,1) = zeros(size(abs_p_term(:,1)));
        p_term(:,2:end) = p(a,3:IL-1)+2*p(a,2:IL-2)+p(a,1:IL-3);
    dmhi = err*u_c_mhi.*(abs_p_term./p_term);
        u_c_phj = u3(a,b)+c(a,b);
        abs_p_term = abs(p(3:JL,b)-2*p(a,b)+p(1:JL-2,b));
        p_term = p(3:JL,b)+2*p(a,b)+p(1:JL-2,b);
    dphj = err*u_c_phj.*(abs_p_term./p_term);   
        u_c_mhj = u1(a,b)+c(a,b);
        abs_p_term(2:end,:) = abs(p(3:JL-1,b)-2*p(2:JL-2,b)+p(1:JL-3,b));
        abs_p_term(1,:) = zeros(size(abs_p_term(1,:)));
        p_term(2:end,:) = p(3:JL-1,b)+2*p(2:JL-2,b)+p(1:JL-3,b);
    dmhj = err*u_c_mhj.*(abs_p_term./p_term);
end