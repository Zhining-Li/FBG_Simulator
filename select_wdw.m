function wdw_fn = select_wdw(window_func,length)
% This function selects the desired window function

    if strcmp(window_func, 'rectangular')
        wdw_fn = ALL_WINDOW_FUNCS().rectangular_wdw_fn(length);
    elseif strcmp(window_func, 'hann')
        wdw_fn = ALL_WINDOW_FUNCS().hann_wdw_fn(length);
    elseif strcmp(window_func, 'hamming')
        wdw_fn = ALL_WINDOW_FUNCS().hamming_wdw_fn(length);
    elseif strcmp(window_func, 'barlett')
        wdw_fn = ALL_WINDOW_FUNCS().barlett_wdw_fn(length);
    elseif strcmp(window_func, 'blackman')
        wdw_fn = ALL_WINDOW_FUNCS().blackman_wdw_fn(length);
    elseif strcmp(window_func, 'gaussian')
        wdw_fn = ALL_WINDOW_FUNCS().gaussian_wdw_fn(length);
    else
        error('Invalid window function. Please choose from "rectangular", "hann", "hamming", "bartlett", or "blackman".');
    end

end