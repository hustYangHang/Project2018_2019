function [pearson_tx1, pearson_tx2] =  csi_pearson(csi_tx1, csi_tx2)

    csi_temp = csi_tx1;    
    pearson_tx1 = corr(csi_temp(1,:)',csi_temp(2,:)','type','pearson');
    pearson_tx1 = pearson_tx1 + corr(csi_temp(2,:)',csi_temp(3,:)','type','Pearson');
    pearson_tx1 = pearson_tx1 + corr(csi_temp(1,:)',csi_temp(3,:)','type','Pearson');    
    
    csi_temp = csi_tx2;    
    pearson_tx2 = corr(csi_temp(1,:)',csi_temp(2,:)','type','pearson');
    pearson_tx2 = pearson_tx2 + corr(csi_temp(2,:)',csi_temp(3,:)','type','Pearson');
    pearson_tx2 = pearson_tx2 + corr(csi_temp(1,:)',csi_temp(3,:)','type','Pearson');    
    
    
%     csi_tx2 = abs(squeeze(csi_entry(:,2,:))); 

end