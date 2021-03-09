function x = add_cyclic_prefix(x)
    % Add the cyclic prefix to the signal by appending the fist 16 values
    % in the signal to it. Note that this function currently only operates
    % on a single block of 64 bits and it simply adds the fist 16 bits to
    % the vector to create an 80 bit block.
    % Input:
    % x : 64 character input block without cyclic prefix.
    % Output
    % x : 80 character block with cyclic prefix.
    x = [x(1:16) x]; 
end