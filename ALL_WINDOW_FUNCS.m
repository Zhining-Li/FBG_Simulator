classdef ALL_WINDOW_FUNCS
%   This Class generates a window function from
%   [rectangular, hamming, hann, barlett, blackman]
%
%   This Class could also be used to plot a single window function, or all
%   window function
%
%   Example Usage:
%
%    hamming_window = ALL_WINDOW_FUNCS().hamming_wdw_fn(N);
%    rect_window = ALL_WINDOW_FUNCS().hamming_wdw_fn(N);
%
%    ALL_WINDOW_FUNCS().plotWindowFunction('hamming',100);
%    ALL_WINDOW_FUNCS().plotAllWindowFunctions(100);
%
%        where N defines the window length

    methods(Static)
        function rectangular = rectangular_wdw_fn(N)
            rectangular = ones(1,N);
        end

        function hann = hann_wdw_fn(N)
            n = 1:1:N;
            hann = sin(pi.*n/(N-1)).^2;
        end

        function hamming = hamming_wdw_fn(N)
            n = 1:1:N;
            hamming = 0.54-0.46*cos(2*pi*n/(N-1));
        end

        function barlett = barlett_wdw_fn(N)
            n = 1:1:N;
            barlett = 1-abs((n-(N-1)/2)/((N-1)/2));
        end

        function blackman = blackman_wdw_fn(N)
            n = 1:1:N;
            blackman = 0.42-0.5*cos(2*pi*n/(N-1))+0.08*cos(4*pi*n/(N-1));
        end

        function gaussian = gaussian_wdw_fn(N)
            alpha = 3.5;
            sigma = (N - 1) / (2 * alpha);
            n = linspace(-N/2,N/2,N);
            gaussian = exp(-0.5 *(n/ sigma).^2);
        end
          
    end

    methods
        function plotWindowFunction(obj, windowType, N)
            switch windowType
                case 'rectangular'
                    window = obj.rectangular_wdw_fn(N);
                    titleStr = 'Rectangular Window';
                case 'hann'
                    window = obj.hann_wdw_fn(N);
                    titleStr = 'Hann Window';
                case 'hamming'
                    window = obj.hamming_wdw_fn(N);
                    titleStr = 'Hamming Window';
                case 'barlett'
                    window = obj.barlett_wdw_fn(N);
                    titleStr = 'Barlett Window';
                case 'blackman'
                    window = obj.blackman_wdw_fn(N);
                    titleStr = 'Blackman Window';
                case 'gaussian'
                    window = obj.gaussian_wdw_fn(N);
                    titleStr = 'Gaussian Window';
                otherwise
                    error('Invalid window type');
            end
            plot(window);
            title(titleStr);
            xlabel('Sample');
            ylabel('Window Value');
        end

        function plotAllWindowFunctions(obj, N)
            x = 1:N;
            windowTypes = {'rectangular', 'hann', 'hamming', 'barlett', 'blackman','gaussian'};
            numWindows = numel(windowTypes);
            
            figure;
            hold on;
            
            for i = 1:numWindows
                windowType = windowTypes{i};
                window = obj.getWindowFunction(windowType, N);
                
                plot(x, window, 'DisplayName', windowType);
            end
            
            hold off;
            
            title('Window Functions');
            xlabel('Sample');
            ylabel('Window Value');
            legend('Location', 'best');
        end
        
        function window = getWindowFunction(obj, windowType, N)
            switch windowType
                case 'rectangular'
                    window = obj.rectangular_wdw_fn(N);
                case 'hann'
                    window = obj.hann_wdw_fn(N);
                case 'hamming'
                    window = obj.hamming_wdw_fn(N);
                case 'barlett'
                    window = obj.barlett_wdw_fn(N);
                case 'blackman'
                    window = obj.blackman_wdw_fn(N);
                case 'gaussian'
                    window = obj.gaussian_wdw_fn(N);
                otherwise
                    error('Invalid window type');
            end
        end
    end
end