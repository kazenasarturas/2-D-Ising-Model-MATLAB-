%{

imagePlot: displaying spin configuration of each element in an array in black and white.

Animated gif is created in the same directory when process runs. 
gif is overwritten every time the process is run.
%}

function imagePlot(data,size,tempIndex)
    f = figure;
    filename = 'spin_configuration.gif';

    image(data,'CDataMapping','scaled');
    colormap(bone);
    grid on
    title(['                        Spin plot of a ' num2str(size) 'x' num2str(size) ' array'...
                                    '\newline'...
                                    'Negative spin (-1) = black | Positive spin (1) = white'])
    ax = gca;
    ax.GridColor = [0, 1, 0];  % [R, G, B]

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