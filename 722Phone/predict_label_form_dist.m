function predict_label = predict_label_form_dist(p_label,dist)
label_list(:,1) = [3,9,15,21,27,33,39,45,51,57,63];
if abs(dist-label_list(p_label,1)) < 5
    predict_label = p_label;
elseif abs(dist) < 6
    predict_label = 1;
elseif (abs(dist) < 12)&&(abs(dist) >= 6)
    predict_label = 2;
elseif (abs(dist) < 18)&&(abs(dist) >= 12)
    predict_label = 3;
elseif (abs(dist) < 24)&&(abs(dist) >= 18)
    predict_label = 4;
elseif (abs(dist) < 30)&&(abs(dist) >= 24)
    predict_label = 5;
elseif (abs(dist) < 36)&&(abs(dist) >= 30)
    predict_label = 6;
elseif (abs(dist) < 42)&&(abs(dist) >= 36)
    predict_label = 7;
elseif (abs(dist) < 48)&&(abs(dist) >= 42)
    predict_label = 8;
elseif (abs(dist) < 54)&&(abs(dist) >= 48)
    predict_label = 9;
elseif (abs(dist) < 60)&&(abs(dist) >= 54)
    predict_label = 10;
elseif (abs(dist) < 66)&&(abs(dist) >= 60)
    predict_label = 11;
end     