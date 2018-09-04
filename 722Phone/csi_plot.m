function csi_plot(csi_entry, nc, nr)
%     hold on
    
    if nc > 1
        csi_temp = squeeze(csi_entry(:,1,:));
%         subplot(2, 1, 1);
%       set(gca,'position',[0.2,0.2,0.5,0.5])
%         p1 = plot(abs(csi_temp)');
%         xlabel('Subcarrier index');
%         ylabel('Amplitude');
%         legend('Rx 1', 'Rx 2', 'Rx 3');
%         title('Tx 1');
        
%         subplot(2, 2, 3);
%         relative_temp(1,:) = unwrap(angle(csi_temp(2,:).') - angle(csi_temp(1,:).'));
%         relative_temp(2,:) = unwrap(angle(csi_temp(3,:).') - angle(csi_temp(2,:).'));
%         relative_temp(3,:) = unwrap(angle(csi_temp(3,:).') - angle(csi_temp(1,:).'));
%         p4 = plot((relative_temp).');
%         xlabel('Subcarrier index');
%         ylabel('Relative phase');
%         legend('Rx 2 - Rx 1', 'Rx 3 - Rx 2', 'Rx 3 - Rx 1');
%         title('Tx 1');
%               
        csi_temp = squeeze(csi_entry(:,2,:));
%         subplot(2, 1, 2);
%         p2 = plot(abs(csi_temp)');
%         xlabel('Subcarrier index');
%         ylabel('Amplitude');
%         legend('Rx 1', 'Rx 2', 'Rx 3');
%         title('Tx 2');
        
%         subplot(2, 2, 4);
%         relative_temp(1,:) = unwrap(angle(csi_temp(2,:).') - angle(csi_temp(1,:).'));
%         relative_temp(2,:) = unwrap(angle(csi_temp(3,:).') - angle(csi_temp(2,:).'));
%         relative_temp(3,:) = unwrap(angle(csi_temp(3,:).') - angle(csi_temp(1,:).'));
%         p5 = plot((relative_temp).');
%         xlabel('Subcarrier index');
%         ylabel('Relative phase');
%         legend('Rx 2 - Rx 1', 'Rx 3 - Rx 2', 'Rx 3 - Rx 1');
%         title('Tx 2');
        
    end
    
    if nc > 2
        csi_temp = squeeze(csi_entry(:,3,:));
%         subplot(2, 3, 3);
%         p3 = plot(abs(csi_temp)');
%         xlabel('Subcarrier index');
%         ylabel('Amplitude');
%         legend('Rx 1', 'Rx 2', 'Rx 3');
%         title('Tx 3');
        
%         subplot(2, 3, 6);
%         relative_temp(1,:) = unwrap(angle(csi_temp(2,:).') - angle(csi_temp(1,:).'));
%         relative_temp(2,:) = unwrap(angle(csi_temp(3,:).') - angle(csi_temp(2,:).'));
%         relative_temp(3,:) = unwrap(angle(csi_temp(3,:).') - angle(csi_temp(1,:).'));
%         p6 = plot((relative_temp).');
%         xlabel('Subcarrier index');
%         ylabel('Relative phase');
%         legend('Rx 2 - Rx 1', 'Rx 3 - Rx 2', 'Rx 3 - Rx 1');
%         title('Tx 3');
    end
   
%     
%     drawnow;
%     clf
    
end
    