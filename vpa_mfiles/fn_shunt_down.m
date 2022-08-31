function [ntpa_sweep,scale_sweep,allprots_sweep,rmsd_sweep,length_sweep,proxy,t,DIVE] = fn_shunt_down(sift,below,length,maxR_vpa,ntpa_gauge,tpa,atoms,natoms_prot,nprot,pcutoff,ipp,vmult,vdw,Tnum,use_pmult,topsid,qz)
                                                                                 
        t = 1;        
        stop_down = 0;
        for h = 0:(-sift):(-below)
            scale_sweep(t)   = (length+h)/maxR_vpa;
            ntpa_sweep(t)      = ntpa_gauge;
            tpa_sweep          = tpa*scale_sweep(t);
            [vpa_d2p,d2p_sort,pcount_sweep,pn_index,vpa_i2a] = fn_min_dist2prot(atoms,natoms_prot,nprot,tpa_sweep,ntpa_sweep(t),pcutoff);
            d2p_sort = round(100*d2p_sort)/100;
            [surf_rmsd_temp,div]  = fn_rmsd_surf_au_pcounts(d2p_sort,pcount_sweep,vmult,use_pmult,vdw,ntpa_sweep(t));
            [allprots_sweep(t),dmat_sweep,prot_nums_sweep]  = fn_all_proteins_included(d2p_sort,ipp,ntpa_sweep(t),nprot,pcount_sweep,Tnum,vpa_i2a);
            DIVE(t) = div;
            if allprots_sweep(t) == 0
                %rmsd_sweep(t)       = 999;
                rmsd_sweep(t)       = surf_rmsd_temp;
            else
                rmsd_sweep(t)       = surf_rmsd_temp;
            end
            if t ~= 1
                if ((rmsd_sweep(t) > rmsd_sweep(t-1)) && (rmsd_sweep(t) ~= 999) && (rmsd_sweep(t-1) ~= 999))
                    stop_down = stop_down + 1;
                elseif (rmsd_sweep(t-1) ~= 999)
                    stop_down = 0;
                end
            end
            length_sweep(t)  = length + h;
            %levels_sweep(t)  = levels_temp;
            proxy(t).pcount  = pcount_sweep;
            proxy(t).d2p_sort = d2p_sort;
            proxy(t).dmat_sweep = dmat_sweep;
            proxy(t).prot_nums_sweep = prot_nums_sweep;
            proxy(t).tpa_sweep = tpa_sweep;
            t = t + 1;
            if d2p_sort(1,1) == vdw
                disp(['Gauge Point AT surface at qz = ',num2str(qz)])
                disp(['Shunt step h = ',num2str(h)])
                break
            elseif d2p_sort(1,1) < vdw
                disp(['Gauge Point penetrated surface at qz = ',num2str(qz)])
                disp(['Shunt step h = ',num2str(h)])
                break
            end
            r_gp = calc_radii(tpa_sweep(:,1)');
            if r_gp <= topsid
                disp(['Gauge point below top of capsid at qz = ',num2str(qz)])
                disp(['Shunt step h = ',num2str(h)])
                break
            end
            if stop_down == 5
                disp('stop down')
                break
            end
        end
        ntpa_sweep      = fliplr(ntpa_sweep);
        scale_sweep     = fliplr(scale_sweep);
        allprots_sweep  = fliplr(allprots_sweep);
        rmsd_sweep      = fliplr(rmsd_sweep);
        length_sweep    = fliplr(length_sweep);
        proxy           = fliplr(proxy);