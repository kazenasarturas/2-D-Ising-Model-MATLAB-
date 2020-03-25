%{
linePlot: displaying change in average magnetisation and energy levels of
the array.
%}

function linePlot(kT, kTc, numTemps, Emean, Mmean, tempIndex)
    f = figure;
    filename = 'Magnetisation.gif';
    
    % Plot energy of spins vs temperature
    subplot(2,1,1);
    plot(kT / kTc, Emean, '.')
    hold on
    window = (2^-3)*numTemps - 1;
    plot(kT / kTc, movmean(  Emean, window));
    plot(kT / kTc, movmedian(Emean, window));
    hold off;

    title('Mean Energy vs Temperature')
    xlabel('Temperature');
    ylabel('<Energy>');
    grid on;
    legend('raw',...
        [num2str(window) ' pt. moving mean'],...
        [num2str(window) ' pt. moving median'],...
        'Location', 'NorthWest');


    % Plot magnetisation of spins vs temperature
    subplot(2,1,2);
    plot(kT / kTc, abs(Mmean), '.');
    hold on;
    window = (2^-3)*numTemps - 1;
    plot(kT / kTc, movmean(  abs(Mmean), window));
    plot(kT / kTc, movmedian(abs(Mmean), window));
    hold off;
    title('Magnetization vs Temperature');
    xlabel('Temperature');
    ylabel('Magnetisation');
    grid on;
    legend('raw',...
        [num2str(window) ' pt. moving mean'],...
        [num2str(window) ' pt. moving median'],...
        'Location', 'NorthEast');
    
    % Capturing plot as an image
    frame = getframe(f);
    img = frame2im(frame);
    [imgind, cm] = rgb2ind(img, 256);
    
    % Write to the GIF File 
    if tempIndex == 1 
        imwrite(imgind,cm,filename,'gif', 'Loopcount',inf); 
    else 
        imwrite(imgind,cm,filename,'gif', 'WriteMode','append'); 
    end 
    close(f)
end