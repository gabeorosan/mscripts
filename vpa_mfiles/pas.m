list = [53 132 319]; N = numel(list);

for mm = 1:N

    m = list(mm);

    paN3 = results(m).tpa_shunt';

    [class_pa] = fn_output_pa2pdb(paN3,m,pdbid,'pa');

end