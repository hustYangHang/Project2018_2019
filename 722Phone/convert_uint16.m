function ret = convert_uint16(bytes, endian_format)
    x = bytes(1);
    y = bytes(2);
    if endian_format == 0   % 0 denotes little endian, 1 denotes big endian
        bytepeck = uint16(y);
        bytepeck = bitshift(bytepeck, 8);
        ret = bitor(bytepeck, uint16(x));
    else
        bytepeck = uint16(x);
        bytepeck = bitshift(bytepeck, 8);
        ret = bitor(bytepeck, uint16(y));
        
        bytepeck_tmp = uint16(y);
        bytepeck_tmp = bitshift(bytepeck_tmp, 8);
        ret_tmp = bitor(bytepeck_tmp, uint16(x));
        fprintf('ret tmp: %d\n', ret_tmp);
    end
end