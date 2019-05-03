clearvars;
close all;
clc;

testName    =   'multiple_schemes_1/scheme_15';
directory   =   strcat('Results/', testName);
filePath    =   strcat(directory, '/data.mat');
load(filePath);

fig         =   [];
radToPlot   =   4:4; % Indices of radius to show on 2D plot

% Bias and variance plots over azimuth
if azim.steps > 1
    radLegend = cell(1, rad.steps);
    for r = 1:rad.steps
        radLegend{r} = sprintf("R=%d", mov.radVals(r));
    end
    %- Bias of the position
    %-- TDoA/FDoA
    fig = [fig, figure]; set(gcf, 'Position', [10, 600, 400, 500]);
    subplot(2,1,1);
    plot(mov.azimVals, pos.x.biasA, '-o');
    title("Position bias (TDoA/FDoA)");
    ylabel("Bias of position (X) (m)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    subplot(2,1,2);
    plot(mov.azimVals, pos.y.biasA, '-o');
    ylabel("Bias of position (Y) (m)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    
    %-- RSS/DoA
    fig = [fig, figure]; set(gcf, 'Position', [10, 0, 400, 500]);
    subplot(2,1,1);
    plot(mov.azimVals, pos.x.biasB, '-o');
    title("Position bias (RSS/DoA)");
    ylabel("Bias of position (X) (m)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    subplot(2,1,2);
    plot(mov.azimVals, pos.y.biasB, '-o');
    ylabel("Bias of position (Y) (m)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    
    %- Standard deviation of the position
    %-- TDoA/FDoA
    fig = [fig, figure]; set(gcf, 'Position',  [420, 600, 400, 500]);
    subplot(2,1,1);
    plot(mov.azimVals, pos.x.stdA, '-o');
    title("Position standard deviation (TDoA/FDoA)");
    ylabel("STD of position (X) (m)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    subplot(2,1,2);
    plot(mov.azimVals, pos.y.stdA, '-o');
    ylabel("STD of position (Y) (m)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    
    %-- RSS/DoA
    fig = [fig, figure]; set(gcf, 'Position',  [420, 0, 400, 500]);
    subplot(2,1,1);
    plot(mov.azimVals, pos.x.stdB, '-o');
    title("Position standard deviation (RSS/DoA)");
    ylabel("STD of position (X) (m)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    subplot(2,1,2);
    plot(mov.azimVals, pos.y.stdB, '-o');
    ylabel("STD of position (Y) (m)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    
    %- Bias of the velocity
    fig = [fig, figure];  set(gcf, 'Position',  [850, 600, 400, 500]);
    subplot(2,1,1);
    plot(mov.azimVals, vel.x.biasA, '-o');
    title("Velocity bias (TDoA/FDoA)");
    ylabel("Bias of velocity (X) (m/s)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    subplot(2,1,2);
    plot(mov.azimVals, vel.y.biasA, '-o');
    ylabel("Bias of velocity (Y) (m/s)");
    xlabel("Azimuth (deg)");
    legend(radLegend);

    %- Standard deviation of the velocity
    fig = [fig, figure];  set(gcf, 'Position',  [1240, 600, 400, 500]);
    subplot(2,1,1);
    plot(mov.azimVals, vel.x.stdA, '-o');
    title("Velocity standard deviation (TDoA/FDoA)");
    ylabel("STD of velocity (X) (m/s)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
    subplot(2,1,2);
    plot(mov.azimVals, vel.y.stdA, '-o');
    ylabel("STD of velocity (Y) (m/s)");
    xlabel("Azimuth (deg)");
    legend(radLegend);
end

% Bias and variance plots over radius
if rad.steps > 1
    azimLegend = cell(1, azim.steps);
    for a = 1:azim.steps
    azimLegend{a} = sprintf("a=%d", mov.azimVals(a));
    end
    
    %- Bias of the position
    %-- TDoA/FDoA
    fig = [fig, figure]; set(gcf, 'Position', [10, 600, 400, 500]);
    subplot(2,1,1);
    plot(mov.radVals, pos.x.biasA.', '-o');
    title("Position bias (TDoA/FDoA)");
    ylabel("Bias of position (X) (m)");
    xlabel("Radius (m)");
    legend(azimLegend);
    subplot(2,1,2);
    plot(mov.radVals, pos.y.biasA.', '-o');
    ylabel("Bias of position (Y) (m)");
    xlabel("Radius (m)");
    legend(azimLegend);

    %-- RSS/DoA
    fig = [fig, figure]; set(gcf, 'Position', [10, 0, 400, 500]);
    subplot(2,1,1);
    plot(mov.radVals, pos.x.biasB.', '-o');
    title("Position bias (RSS/DoA)");
    ylabel("Bias of position (X) (m)");
    xlabel("Radius (m)");
    legend(azimLegend);
    subplot(2,1,2);
    plot(mov.radVals, pos.y.biasB.', '-o');
    ylabel("Bias of position (Y) (m)");
    xlabel("Radius (m)");
    legend(azimLegend);

    %- Standard deviation of the position
    %-- TDoA/FDoA
    fig = [fig, figure]; set(gcf, 'Position',  [420, 600, 400, 500]);
    subplot(2,1,1);
    plot(mov.radVals, pos.x.stdA.', '-o');
    title("Position standard deviation (TDoA/FDoA)");
    ylabel("STD of position (X) (m)");
    xlabel("Radius (m)");
    legend(azimLegend);
    subplot(2,1,2);
    plot(mov.radVals, pos.y.stdA.', '-o');
    ylabel("STD of position (Y) (m)");
    xlabel("Radius (m)");
    legend(azimLegend);

    %-- RSS/DoA
    fig = [fig, figure]; set(gcf, 'Position',  [420, 0, 400, 500]);
    subplot(2,1,1);
    plot(mov.radVals, pos.x.stdB.', '-o');
    title("Position standard deviation (RSS/DoA)");
    ylabel("STD of position (X) (m)");
    xlabel("Radius (m)");
    legend(azimLegend);
    subplot(2,1,2);
    plot(mov.radVals, pos.y.stdB.', '-o');
    ylabel("STD of position (Y) (m)");
    xlabel("Radius (m)");
    legend(azimLegend);
    
    %- Bias of the velocity
    fig = [fig, figure];  set(gcf, 'Position',  [850, 600, 400, 500]);
    subplot(2,1,1);
    plot(mov.radVals, vel.x.biasA.', '-o');
    title("Velocity bias (TDoA/FDoA)");
    ylabel("Bias of velocity (X) (m/s)");
    xlabel("Radius (m)");
    legend(azimLegend);
    subplot(2,1,2);
    plot(mov.radVals, vel.y.biasA.', '-o');
    ylabel("Bias of velocity (Y) (m/s)");
    xlabel("Radius (m)");
    legend(azimLegend);

    %- Standard deviation of the velocity
    fig = [fig, figure];  set(gcf, 'Position',  [1240, 600, 400, 500]);
    subplot(2,1,1);
    plot(mov.radVals, vel.x.stdA.', '-o');
    title("Velocity standard deviation (TDoA/FDoA)");
    ylabel("STD of velocity (X) (m/s)");
    xlabel("Radius (m)");
    legend(azimLegend);
    subplot(2,1,2);
    plot(mov.radVals, vel.y.stdA.', '-o');
    ylabel("STD of velocity (Y) (m/s)");
    xlabel("Radius (m)");
    legend(azimLegend);
end

errorA      =   zeros(rad.steps, azim.steps);
errorB      =   zeros(rad.steps, azim.steps);
err2dA      =   zeros(rad.steps, nDim, azim.steps);
err2dB      =   zeros(rad.steps, nDim, azim.steps);
for a = 1:azim.steps
    for r = 1:rad.steps
       errorA(r, a) = sqrt(sum((tx(r, a).pos - estA(r, a).pos).^2));
       errorB(r, a) = sqrt(sum((tx(r, a).pos - estB(r, a).pos).^2));
       
       err2dA(r, :, a) = tx(r, a).pos - estA(r, a).pos;
       err2dB(r, :, a) = tx(r, a).pos - estB(r, a).pos;
    end
end

radLegend   =   cell(size(mov.radVals));
azLegend    =   cell(size(mov.azimVals));
for r = 1:length(mov.radVals)
    radLegend{r} = sprintf('R = %d m', mov.radVals(r));
end

for a = 1:length(mov.azimVals)
    azLegend{a} = sprintf('az = %d º', mov.azimVals(a));
end


fig = [fig, figure];
for r = 1:rad.steps
    cdfplot(errorA(r, :)); hold on;
end
xlabel('Error [m]');
legend(radLegend, 'Location', 'southeast'); 
legend('boxoff');
title("CDF of TDoA/FDoA method over radius variation");

fig = [fig, figure];
for r = 1:rad.steps
    cdfplot(errorB(r, :)); hold on;
end
xlabel('Error [m]');
legend(radLegend, 'Location', 'southeast'); 
legend('boxoff');
title("CDF of RSS/DoA method over radius variation");


fig = [fig, figure];
for a = 1:azim.steps
    cdfplot(errorA(:, a)); hold on;
end
xlabel('Error [m]');
legend(azLegend, 'Location', 'southeast'); 
legend('boxoff');
title("CDF of TDoA/FDoA method over azimuth variation");

fig = [fig, figure];
for a = 1:azim.steps
    cdfplot(errorB(:, a)); hold on;
end
xlabel('Error [m]');
legend(azLegend, 'Location', 'southeast'); 
legend('boxoff');
title("CDF of RSS/DoA method over azimuth variation");

scale = 10;
fig = [fig, figure]; set(gcf, 'Position',  [400, 50, 950, 900]);
legend;
for r = radToPlot
    for a = 1:azim.steps
        %- Actual positions
        name    =   sprintf("Receiver at az=%d, rad=%d", a, r);
        scatter(tx(r, a).pos(1), tx(r, a).pos(2), 'g', 'o', 'DisplayName', name); hold on;
        %- Estimated positions
        %-- TDoA/FDoA
        name    =   sprintf("(TDoA/FDoA) Estimation at az=%d, rad=%d", a, r);
        scatter(estA(r, a).pos(1), estA(r, a).pos(2), 'r', 'x', 'DisplayName', name); hold on;
        C       =   cov(txEstPosA(:, :, r, a));
        error_ellipse(C, estA(r, a).pos);
        %-- RSS/DoA
        name    =   sprintf("(RSS/DoA) Estimation at az=%d, rad=%d", a, r);
        scatter(estB(r, a).pos(1), estB(r, a).pos(2), 'm', 'x', 'DisplayName', name); hold on;
        C       =   cov(txEstPosB(:, :, r, a));
        error_ellipse(C, estB(r, a).pos);
    end
end

for i = 1:scen.numRx
    scatter(rx(i).pos(1), rx(i).pos(2), 'b', 'x', 'DisplayName', 'Receivers'); hold on;
    quiver(rx(i).pos(1), rx(i).pos(2), ...
        rx(i).vel(1)*scale, rx(i).vel(2)*scale, 'b'); hold on;
end
xlabel('x'); ylabel('y');

fprintf('Selected test: %s \n\n', testName);
saveAnswer  =   menu('Save figures?', 'YES', 'NO');
if saveAnswer == 1
    prompt      =   strcat('Name the figures folder (inside: ', directory, '/ ): ');
    dlgtitle    =   'Figures folder';
    dims        =   [1 35];
    definput    =   {'name'};
    figDirName  =   inputdlg(prompt, dlgtitle, dims, definput);
   
    directory = strcat(directory, '/', figDirName{1}, '/');
    if ~exist(directory, 'dir')
        mkdir(directory);
    end

    for i = 1:length(fig)
        saveas(figure(i), sprintf('%sfig_%d.fig', directory, i));
    end
    close all
    
else
    closeAnswer  =   menu('Close figures?', 'YES', 'NO');
    if closeAnswer == 1
        close all
    end
end



