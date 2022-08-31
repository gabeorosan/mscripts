function fn_output_vpa(vpa2write,label_out_vpa)
%Text for xyz vmd file.
%HH = max(size(vpa_surf));
Mtot = vpa2write;
[N,x] = size(vpa2write);
name = strcat(char(label_out_vpa),'.xyz');

%label_out_vpa = char(vpa_name_list(i));% First file loaded and run.
fid1 = fopen(name,'w');
fprintf(fid1,'%d\n', N);
fprintf(fid1,'I am a comment \n');

fprintf(fid1,'C % 10.7f % 10.7f %10.7f \n', [Mtot(:,1)'; Mtot(:,2)'; Mtot(:,3)';]);
fclose(fid1);
name
movefile(name,'vpa_output')