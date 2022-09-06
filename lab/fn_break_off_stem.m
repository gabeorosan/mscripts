function [keep,drop,cutoff] = fn_break_off_stem(atoms)
    r_temp = calc_radii(atoms);
    n_temp = numel(r_temp);
    maxR = max(r_temp);
    minR = min(r_temp);
    aveR = mean(r_temp);
    top_range = maxR-aveR;
    bot_range = aveR-minR;
    stdR = std(r_temp);
    cutoff = aveR - stdR;

    keep = []; drop = [];
    for m = 1:n_temp
        if r_temp(m) >= cutoff
            keep = [keep;atoms(m,:)];
        else
            drop = [drop;atoms(m,:)];
        end
    end
end