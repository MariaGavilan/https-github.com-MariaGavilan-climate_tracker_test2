%[text] # Exercise 2: Your Personal Carbon Impact Story

% *An Interactive Data-Driven Climate Narrative*
%
% In Exercise 1, you built a transport emissions calculator. Now it's time 
% to tell YOUR complete carbon story - with all emissions sources, regional 
% context, and data visualizations that reveal where YOUR impact comes from.
%
% <<../images/carbon_story_header.png>>

%% 📖 The Story You'll Tell
% By the end of this exercise, you'll have answered:
% 
% 1. *What's my total annual carbon footprint?*
% 2. *How does it compare to my region and the world?*
% 3. *Where does my impact come from?* (Transport? Home? Food? Digital?)
% 4. *What makes my region different?* (Grid, infrastructure, lifestyle)
% 5. *Where can I make the biggest difference?*
%
% This is YOUR data story, contextualized globally but personalized locally.

%% 🌍 Part 1: Set Your Regional Context
% *Your geography determines your baseline carbon intensity*
%
% Different regions have vastly different carbon profiles due to:
% • Electricity grid mix (coal vs. hydro vs. solar)
% • Transportation infrastructure (car-dependent vs. transit-rich)
% • Climate (heating/cooling needs)
% • Economic development stage
% • Cultural consumption patterns

%% INTERACTIVE: Select Your Region

% TODO: Update this with YOUR location
myRegion = 'USA';  % Options: 'USA', 'Europe', 'Asia', 'China', 'India', 
                   %          'Norway', 'Brazil', 'Global', etc.

% Load regional context data
regionalData = readtable('../data/regionalAverages.csv');
myRegionalContext = regionalData(strcmp(regionalData.Region, myRegion), :);

% Display your regional baseline
fprintf('\n╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                   YOUR REGIONAL CONTEXT                        ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n');
fprintf('  Region: %s\n', myRegion);
fprintf('  Grid Carbon Intensity: %d g CO₂/kWh\n', myRegionalContext.GridIntensity_gCO2_per_kWh);
fprintf('  Avg Per-Capita Emissions: %.1f tons CO₂/year\n', myRegionalContext.PerCapita_Total_Tons);
fprintf('  Dominant Grid Source: %s\n', myRegionalContext.DominantGridSource);
fprintf('  Primary Transport Mode: %s\n', myRegionalContext.PrimaryTransportMode);
fprintf('  Climate Zone: %s\n', myRegionalContext.ClimateZone);
fprintf('════════════════════════════════════════════════════════════════\n\n');

%% 📊 Visualize: How Your Region Compares Globally

% Load global comparison data
globalComparison = readtable('../data/regionalAverages.csv');

figure('Name', 'Global Carbon Context', 'Position', [100 100 1200 500]);

% Subplot 1: Grid Carbon Intensity by Region
subplot(1,3,1)
regions = globalComparison.Region;
gridIntensity = globalComparison.GridIntensity_gCO2_per_kWh;

% Highlight your region
colors = repmat([0.7 0.7 0.7], length(regions), 1);
myIdx = strcmp(regions, myRegion);
colors(myIdx, :) = [0.2 0.6 0.8];  % Blue for your region

barh(categorical(regions), gridIntensity, 'FaceColor', 'flat', 'CData', colors);
xlabel('Grid Carbon Intensity (g CO₂/kWh)');
title('Electricity Grid Emissions by Region');
grid on;

% Subplot 2: Per-Capita Total Emissions
subplot(1,3,2)
perCapita = globalComparison.PerCapita_Total_Tons;
colors = repmat([0.7 0.7 0.7], length(regions), 1);
colors(myIdx, :) = [0.2 0.6 0.8];

barh(categorical(regions), perCapita, 'FaceColor', 'flat', 'CData', colors);
xlabel('Per-Capita Emissions (tons CO₂/year)');
title('Total Emissions by Region');
xline(mean(perCapita), '--r', 'Global Average', 'LineWidth', 2);
grid on;

% Subplot 3: Emissions Breakdown by Source
subplot(1,3,3)
transportPct = globalComparison.Transport_Percent;
homePct = globalComparison.Home_Percent;
otherPct = 100 - transportPct - homePct;

% Your region vs global average
globalAvg = [mean(transportPct), mean(homePct), mean(otherPct)];
yourRegion = [transportPct(myIdx), homePct(myIdx), otherPct(myIdx)];

bar([globalAvg; yourRegion]');
set(gca, 'XTickLabel', {'Transport', 'Home Energy', 'Other'});
ylabel('Percentage of Total Emissions (%)');
title('Emissions Breakdown');
legend({'Global Average', ['Your Region: ' myRegion]}, 'Location', 'best');
grid on;

%% 🚗 Part 2: Calculate Your Transport Emissions
% *Using the function you built in Exercise 1*
%
% Transportation is typically the largest controllable emissions source.
% Your choices here have more impact than almost anything else.

%% INTERACTIVE: Your Transportation Profile

fprintf('\n╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║              CALCULATE YOUR TRANSPORT EMISSIONS                ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

% TODO: Customize these values for YOUR typical travel patterns

% Daily Commute
myCommuteMode = 'Car_Gasoline';  % Options: 'Car_Gasoline', 'Car_Electric_BEV', 
                                 %          'Bus', 'Train_Rail', 'Motorcycle',
                                 %          'Cycling', 'Walking'
myDailyCommuteKm = 20;           % One-way distance
myCommuteDays = 250;             % Working days per year

% Air Travel
myDomesticFlights = 2;           % Round trips per year
myAvgDomesticFlightKm = 1500;    % Average distance
myInternationalFlights = 1;      % Round trips per year
myAvgInternationalFlightKm = 8000;  % Average distance

% Other Regular Travel
myOtherTravelKm = 50;            % Errands, weekends (km per week)

% Calculate using your Exercise 1 function
myTransportEmissions = calculateTransportEmissions(...
    myRegion, myCommuteMode, myDailyCommuteKm, myCommuteDays, ...
    myDomesticFlights, myAvgDomesticFlightKm, ...
    myInternationalFlights, myAvgInternationalFlightKm, ...
    myOtherTravelKm);

fprintf('  Daily Commute Mode: %s\n', myCommuteMode);
fprintf('  Daily Distance (one-way): %d km\n', myDailyCommuteKm);
fprintf('  Annual Commute Days: %d\n', myCommuteDays);
fprintf('  Domestic Flights: %d per year\n', myDomesticFlights);
fprintf('  International Flights: %d per year\n', myInternationalFlights);
fprintf('  ────────────────────────────────────────\n');
fprintf('  YOUR TRANSPORT EMISSIONS: %.1f kg CO₂e (%.2f tons)\n', ...
    myTransportEmissions, myTransportEmissions/1000);
fprintf('  Regional Transport Avg: %.1f tons/year\n', ...
    myRegionalContext.PerCapita_Total_Tons * myRegionalContext.Transport_Percent/100);
fprintf('════════════════════════════════════════════════════════════════\n\n');

%% 📊 Visualize: Your Transport Emissions Breakdown

% Calculate component breakdown
commuteEmissionsFactor = getEmissionFactor(myRegion, myCommuteMode);
commuteEmissions = myDailyCommuteKm * 2 * commuteEmissionsFactor * myCommuteDays / 1000;

domesticFlightFactor = 156;  % g/pkm for domestic medium
domesticEmissions = myDomesticFlights * 2 * myAvgDomesticFlightKm * domesticFlightFactor / 1000;

intlFlightFactor = 147;  % g/pkm for international long
intlEmissions = myInternationalFlights * 2 * myAvgInternationalFlightKm * intlFlightFactor / 1000;

otherEmissions = myTransportEmissions - commuteEmissions - domesticEmissions - intlEmissions;

figure('Name', 'Your Transport Story', 'Position', [100 100 1400 600]);

% Subplot 1: Pie chart of transport breakdown
subplot(2,3,1)
transportComponents = [commuteEmissions, domesticEmissions, intlEmissions, otherEmissions];
transportLabels = {'Daily Commute', 'Domestic Flights', 'International Flights', 'Other Travel'};
pie(transportComponents, transportLabels);
title(sprintf('Your Transport Breakdown\nTotal: %.1f tons CO₂', myTransportEmissions/1000));
colormap([0.2 0.6 0.8; 0.8 0.4 0.2; 0.9 0.6 0.2; 0.5 0.5 0.5]);

% Subplot 2: Mode comparison - what if you switched?
subplot(2,3,2)
alternativeModes = {'Walking', 'Cycling', 'Bus', 'Train_Rail', 'Car_Electric_BEV', 'Car_Gasoline'};
alternativeEmissions = zeros(size(alternativeModes));

for i = 1:length(alternativeModes)
    alternativeEmissions(i) = calculateTransportEmissions(...
        myRegion, alternativeModes{i}, myDailyCommuteKm, myCommuteDays, ...
        0, 0, 0, 0, myOtherTravelKm) / 1000;  % Convert to tons
end

% Highlight current mode
colors = repmat([0.7 0.7 0.7], length(alternativeModes), 1);
currentIdx = strcmp(alternativeModes, myCommuteMode);
colors(currentIdx, :) = [0.2 0.6 0.8];

barh(categorical(alternativeModes), alternativeEmissions, 'FaceColor', 'flat', 'CData', colors);
xlabel('Annual Emissions (tons CO₂)');
title('Mode Switching Impact');
grid on;

% Subplot 3: Flight impact visualization
subplot(2,3,3)
totalFlightEmissions = domesticEmissions + intlEmissions;
nonFlightEmissions = myTransportEmissions/1000 - totalFlightEmissions;

bar([nonFlightEmissions, totalFlightEmissions; nonFlightEmissions, 0], 'stacked');
set(gca, 'XTickLabel', {'Your Total', 'Without Flights'});
ylabel('Emissions (tons CO₂/year)');
title('Flight Impact on Total');
legend({'Ground Transport', 'Flights'}, 'Location', 'best');
grid on;

% Subplot 4: Regional comparison
subplot(2,3,4)
regionalTransportAvg = myRegionalContext.PerCapita_Total_Tons * myRegionalContext.Transport_Percent/100;
globalTransportAvg = 1.2;  % tons/year global average

bar([myTransportEmissions/1000, regionalTransportAvg, globalTransportAvg]);
set(gca, 'XTickLabel', {'You', [myRegion ' Avg'], 'Global Avg'});
ylabel('Transport Emissions (tons CO₂/year)');
title('How You Compare');
grid on;

% Subplot 5: Annualized daily commute visual
subplot(2,3,5)
dailyCommuteEmissions = myDailyCommuteKm * 2 * commuteEmissionsFactor / 1000;  % kg per day
weeklyEmissions = dailyCommuteEmissions * 5;  % Assuming 5-day work week
monthlyEmissions = commuteEmissions / 12;
annualEmissions = commuteEmissions;

bar([dailyCommuteEmissions, weeklyEmissions, monthlyEmissions, annualEmissions]);
set(gca, 'XTickLabel', {'Daily', 'Weekly', 'Monthly', 'Annual'});
ylabel('Commute Emissions (kg CO₂)');
title('Your Commute Over Time');
grid on;

% Subplot 6: Carbon intensity of different distances
subplot(2,3,6)
distances = [10, 50, 100, 500, 1000];  % km
modesForComparison = {'Car_Gasoline', 'Bus', 'Train_Rail'};
emissionsMatrix = zeros(length(modesForComparison), length(distances));

for i = 1:length(modesForComparison)
    factor = getEmissionFactor(myRegion, modesForComparison{i});
    emissionsMatrix(i, :) = distances * factor / 1000;  % Convert to kg
end

plot(distances, emissionsMatrix', '-o', 'LineWidth', 2);
xlabel('Distance (km)');
ylabel('Emissions (kg CO₂)');
title('Emissions by Mode & Distance');
legend(modesForComparison, 'Location', 'northwest');
grid on;

%% 🏠 Part 3: Calculate Your Home Energy Emissions
% *Geography matters most here - your grid determines your impact*
%
% Home energy is where regional differences are most dramatic:
% • Norway (hydro grid): 30 g CO₂/kWh
% • India (coal grid): 708 g CO₂/kWh
% • Same appliance, 24x different impact!

%% INTERACTIVE: Your Home Energy Profile

fprintf('\n╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║               CALCULATE YOUR HOME EMISSIONS                    ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

% TODO: Customize these values for YOUR home energy use

% Electricity consumption
myMonthlyElectricityKWh = 900;   % Check your utility bill!
                                 % USA avg: 877 kWh/month
                                 % Europe avg: 300-400 kWh/month
                                 % Varies by climate, home size, appliances

% Heating fuel (if applicable)
myMonthlyNaturalGasKWh = 300;    % For heating (if you use gas)
                                 % Set to 0 if electric/other heating
                                 % USA avg: 500 kWh/month in winter

% Climate context
myClimateZone = 'Temperate';     % Options: 'Tropical', 'Temperate', 'Cold'
myHomeType = 'Apartment';        % Options: 'Apartment', 'Single-Family', 'Townhouse'
myHomeSize_sqm = 100;            % Square meters

% Load home emissions function (provided)
myHomeEmissions = calculateHomeEmissions(myRegion, ...
    myMonthlyElectricityKWh * 12, myMonthlyNaturalGasKWh * 12);

fprintf('  Monthly Electricity Use: %d kWh\n', myMonthlyElectricityKWh);
fprintf('  Grid Carbon Intensity: %d g CO₂/kWh\n', myRegionalContext.GridIntensity_gCO2_per_kWh);
fprintf('  Monthly Natural Gas Use: %d kWh\n', myMonthlyNaturalGasKWh);
fprintf('  Climate Zone: %s\n', myClimateZone);
fprintf('  Home Type: %s (%d m²)\n', myHomeType, myHomeSize_sqm);
fprintf('  ────────────────────────────────────────\n');
fprintf('  YOUR HOME EMISSIONS: %.1f kg CO₂e (%.2f tons)\n', ...
    myHomeEmissions, myHomeEmissions/1000);
fprintf('  Regional Home Energy Avg: %.1f tons/year\n', ...
    myRegionalContext.PerCapita_Total_Tons * myRegionalContext.Home_Percent/100);
fprintf('════════════════════════════════════════════════════════════════\n\n');

%% 📊 Visualize: Your Home Energy Story

figure('Name', 'Your Home Energy Story', 'Position', [100 100 1400 600]);

% Subplot 1: Monthly energy profile
subplot(2,3,1)
months = 1:12;
% Simulate seasonal variation (higher in winter/summer depending on climate)
if strcmp(myClimateZone, 'Cold')
    seasonalFactor = 1 + 0.5*cos((months-1)*pi/6);  % Peak in winter
elseif strcmp(myClimateZone, 'Tropical')
    seasonalFactor = 1 + 0.3*cos((months-7)*pi/6);  % Peak in summer (cooling)
else
    seasonalFactor = 1 + 0.2*cos((months-1)*pi/6);  % Mild seasonal variation
end

monthlyElectricity = myMonthlyElectricityKWh * seasonalFactor;
monthlyGas = myMonthlyNaturalGasKWh * seasonalFactor;

bar(months, [monthlyElectricity', monthlyGas'], 'stacked');
xlabel('Month');
ylabel('Energy Use (kWh)');
title('Your Monthly Energy Profile');
legend({'Electricity', 'Natural Gas'}, 'Location', 'best');
grid on;
set(gca, 'XTick', 1:12, 'XTickLabel', {'J','F','M','A','M','J','J','A','S','O','N','D'});

% Subplot 2: Grid impact - your emissions vs. different grids
subplot(2,3,2)
gridsToCompare = {'Norway', 'Europe', 'USA', 'China', 'India'};
gridIntensities = [30, 230, 384, 550, 708];  % g CO₂/kWh
emissionsInDifferentGrids = myMonthlyElectricityKWh * 12 * gridIntensities / 1000;  % kg

% Highlight your region
colors = repmat([0.7 0.7 0.7], length(gridsToCompare), 1);
if ismember(myRegion, gridsToCompare)
    myGridIdx = strcmp(gridsToCompare, myRegion);
    colors(myGridIdx, :) = [0.2 0.6 0.8];
end

barh(categorical(gridsToCompare), emissionsInDifferentGrids, 'FaceColor', 'flat', 'CData', colors);
xlabel('Annual Emissions (kg CO₂)');
title(sprintf('Your Electricity Use (%d kWh/year)\nIn Different Grids', myMonthlyElectricityKWh*12));
grid on;

% Subplot 3: Home energy breakdown by end use
subplot(2,3,3)
% Typical breakdown (adjust based on home type and climate)
if strcmp(myClimateZone, 'Cold')
    endUses = {'Heating', 'Water Heating', 'Appliances', 'Lighting', 'Electronics', 'Cooling'};
    percentages = [35, 20, 20, 10, 10, 5];
elseif strcmp(myClimateZone, 'Tropical')
    endUses = {'Cooling', 'Appliances', 'Water Heating', 'Electronics', 'Lighting', 'Heating'};
    percentages = [30, 25, 15, 15, 10, 5];
else
    endUses = {'Heating/Cooling', 'Water Heating', 'Appliances', 'Electronics', 'Lighting'};
    percentages = [25, 20, 25, 15, 15];
end

pie(percentages, endUses);
title('Typical Home Energy End Uses');
colormap(jet(length(endUses)));

% Subplot 4: Emissions per square meter comparison
subplot(2,3,4)
homeTypes = {'Apartment', 'Townhouse', 'Single-Family'};
typicalSizes = [80, 130, 200];  % m²
typicalEmissions = [1800, 2400, 3200];  % kg CO₂/year (varies by region)

% Your home
yourEmissionsPerSqm = myHomeEmissions / myHomeSize_sqm;
typicalEmissionsPerSqm = typicalEmissions ./ typicalSizes;

bar([typicalEmissionsPerSqm, yourEmissionsPerSqm]);
set(gca, 'XTickLabel', [homeTypes, 'Your Home']);
ylabel('Emissions per m² (kg CO₂/year/m²)');
title('Home Efficiency Comparison');
grid on;

% Subplot 5: Annual cost vs emissions trade-off
subplot(2,3,5)
% Estimate electricity cost (varies by region)
electricityCostPerKWh = 0.15;  % USD, adjust for region
annualElectricityCost = myMonthlyElectricityKWh * 12 * electricityCostPerKWh;
annualGasCost = myMonthlyNaturalGasKWh * 12 * 0.10;  % USD estimate

totalEnergyCost = annualElectricityCost + annualGasCost;
totalEnergyEmissions = myHomeEmissions;

scatter(totalEnergyCost, totalEnergyEmissions/1000, 200, 'filled');
xlabel('Annual Energy Cost (USD)');
ylabel('Annual Emissions (tons CO₂)');
title('Your Home: Cost vs. Carbon');
text(totalEnergyCost*1.05, totalEnergyEmissions/1000, ...
    sprintf('  You\n  $%.0f/year\n  %.1f tons', totalEnergyCost, totalEnergyEmissions/1000));
grid on;

% Subplot 6: Decarbonization pathways
subplot(2,3,6)
scenarios = {'Current', 'LED Lighting', '+ Efficient Appliances', ...
             '+ Better Insulation', '+ Solar Panels', '+ Heat Pump'};
emissionReductions = [100, 95, 85, 70, 40, 25];  % Percentage of current
scenarioEmissions = myHomeEmissions/1000 * emissionReductions/100;

barh(categorical(scenarios), scenarioEmissions, 'FaceColor', [0.2 0.6 0.8]);
xlabel('Annual Emissions (tons CO₂)');
title('Home Decarbonization Pathways');
grid on;

%% 🍽️ Part 4: Calculate Your Food Emissions
% *Diet choice is one of the highest-impact decisions you make 3x per day*

%% INTERACTIVE: Your Dietary Profile

fprintf('\n╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                 CALCULATE YOUR FOOD EMISSIONS                  ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

% TODO: Select your typical diet pattern
myDietType = 'balanced';  % Options: 'meat-heavy', 'balanced', 'vegetarian', 'vegan'

% Load food emissions function (provided)
myFoodEmissions = calculateFoodEmissions(myDietType);

% Display
fprintf('  Your Diet Type: %s\n', myDietType);
fprintf('  ────────────────────────────────────────\n');
fprintf('  YOUR FOOD EMISSIONS: %.1f kg CO₂e (%.2f tons)\n', ...
    myFoodEmissions, myFoodEmissions/1000);
fprintf('  Global Food Avg: 1.8 tons CO₂/year\n');
fprintf('════════════════════════════════════════════════════════════════\n\n');

%% 📊 Visualize: Your Food Impact

figure('Name', 'Your Food Story', 'Position', [100 100 1200 500]);

% Subplot 1: Diet comparison
subplot(1,3,1)
dietTypes = {'vegan', 'vegetarian', 'balanced', 'meat-heavy'};
dietEmissions = zeros(size(dietTypes));
for i = 1:length(dietTypes)
    dietEmissions(i) = calculateFoodEmissions(dietTypes{i}) / 1000;
end

% Highlight your diet
colors = repmat([0.7 0.7 0.7], length(dietTypes), 1);
myDietIdx = strcmp(dietTypes, myDietType);
colors(myDietIdx, :) = [0.2 0.6 0.8];

barh(categorical(dietTypes), dietEmissions, 'FaceColor', 'flat', 'CData', colors);
xlabel('Annual Emissions (tons CO₂)');
title('Dietary Patterns Comparison');
grid on;

% Subplot 2: Food category breakdown
subplot(1,3,2)
if strcmp(myDietType, 'meat-heavy')
    categories = {'Beef/Lamb', 'Poultry', 'Pork', 'Dairy', 'Grains/Veg', 'Processed'};
    percentages = [35, 15, 10, 15, 15, 10];
elseif strcmp(myDietType, 'balanced')
    categories = {'Poultry', 'Pork', 'Dairy', 'Grains/Veg', 'Processed', 'Beef/Lamb'};
    percentages = [20, 15, 20, 30, 10, 5];
elseif strcmp(myDietType, 'vegetarian')
    categories = {'Dairy', 'Eggs', 'Grains/Veg', 'Processed', 'Legumes'};
    percentages = [30, 15, 35, 10, 10];
else  % vegan
    categories = {'Grains/Veg', 'Legumes', 'Processed', 'Nuts/Seeds'};
    percentages = [45, 25, 20, 10];
end

pie(percentages, categories);
title(sprintf('Your Food Breakdown\n(%s diet)', myDietType));

% Subplot 3: Impact of shifting one day per week
subplot(1,3,3)
currentWeekly = myFoodEmissions / 52;  % Per week
dietOptions = {'Current', 'One Vegan Day/Week', 'Two Vegan Days/Week', 'Weekday Veg'};
weeklyReductions = [100, 86, 72, 60];  % Percent of current
modifiedEmissions = currentWeekly * weeklyReductions/100 * 52 / 1000;  % Annual tons

bar(modifiedEmissions, 'FaceColor', [0.2 0.6 0.8]);
set(gca, 'XTickLabel', dietOptions);
ylabel('Annual Emissions (tons CO₂)');
title('Small Changes, Big Impact');
grid on;

%% 💻 Part 5: Calculate Your Digital Footprint
% *The hidden emissions of our connected lives*

%% INTERACTIVE: Your Digital Profile

fprintf('\n╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║               CALCULATE YOUR DIGITAL EMISSIONS                 ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

% TODO: Estimate your digital usage
myStreamingHoursPerDay = 2;          % Video streaming (Netflix, YouTube, etc.)
myAIQueriesPerDay = 10;              % ChatGPT, Copilot, etc.
myCloudStorageGB = 100;              % Google Drive, Dropbox, iCloud, etc.
myVideoCallHoursPerWeek = 5;         % Zoom, Teams, etc.
myEmailsPerDay = 50;                 % Sent + received

% Load digital emissions function (provided)
myDigitalEmissions = calculateDigitalEmissions(...
    myStreamingHoursPerDay, myAIQueriesPerDay, myCloudStorageGB, ...
    myVideoCallHoursPerWeek, myEmailsPerDay);

fprintf('  Streaming: %.1f hours/day\n', myStreamingHoursPerDay);
fprintf('  AI Queries: %d per day\n', myAIQueriesPerDay);
fprintf('  Cloud Storage: %d GB\n', myCloudStorageGB);
fprintf('  Video Calls: %.1f hours/week\n', myVideoCallHoursPerWeek);
fprintf('  Emails: %d per day\n', myEmailsPerDay);
fprintf('  ────────────────────────────────────────\n');
fprintf('  YOUR DIGITAL EMISSIONS: %.1f kg CO₂e (%.2f tons)\n', ...
    myDigitalEmissions, myDigitalEmissions/1000);
fprintf('  Note: Digital is typically <5%% of total footprint\n');
fprintf('════════════════════════════════════════════════════════════════\n\n');

%% 📊 Visualize: Your Digital Impact

figure('Name', 'Your Digital Story', 'Position', [100 100 1000 400]);

% Subplot 1: Digital breakdown
subplot(1,2,1)
streamingEmissions = myStreamingHoursPerDay * 365 * 0.055;  % kg
aiEmissions = myAIQueriesPerDay * 365 * 0.01;
storageEmissions = myCloudStorageGB * 0.002 * 365;
videoCallEmissions = myVideoCallHoursPerWeek * 52 * 0.15;
emailEmissions = myEmailsPerDay * 365 * 0.004;

digitalComponents = [streamingEmissions, aiEmissions, storageEmissions, ...
                    videoCallEmissions, emailEmissions];
digitalLabels = {'Streaming', 'AI Queries', 'Cloud Storage', 'Video Calls', 'Email'};

pie(digitalComponents, digitalLabels);
title(sprintf('Your Digital Footprint\nTotal: %.1f kg CO₂', myDigitalEmissions));

% Subplot 2: Comparison to other activities
subplot(1,2,2)
activities = {'1 Day Digital', '1 Day Commute', '1 Domestic Flight', 'Annual Digital'};
activityEmissions = [
    myDigitalEmissions / 365;
    myTransportEmissions / 365;
    myDomesticFlights > 0, avgDomesticFlightKm * 2 * 156 / 1000;
    myDigitalEmissions
];

bar(activityEmissions, 'FaceColor', [0.2 0.6 0.8]);
set(gca, 'XTickLabel', activities);
ylabel('Emissions (kg CO₂)');
title('Digital vs. Physical Activities');
grid on;

%% 🛍️ Part 6: Calculate Your Consumption Emissions
% *Everything we buy has embedded carbon*

%% INTERACTIVE: Your Consumption Profile

fprintf('\n╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║             CALCULATE YOUR CONSUMPTION EMISSIONS               ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

% TODO: Estimate your consumption patterns
myShoppingFrequency = 'moderate';    % Options: 'minimal', 'moderate', 'frequent'
myClothingPurchases = 10;            % New items per year
myElectronicsPurchases = 1;          % New devices per year
myFurniturePurchases = 0;            % Large items per year

% Load consumption emissions function (provided)
myConsumptionEmissions = calculateConsumptionEmissions(...
    myShoppingFrequency, myClothingPurchases, ...
    myElectronicsPurchases, myFurniturePurchases);

fprintf('  Shopping Pattern: %s\n', myShoppingFrequency);
fprintf('  Clothing Purchases: %d items/year\n', myClothingPurchases);
fprintf('  Electronics: %d devices/year\n', myElectronicsPurchases);
fprintf('  ────────────────────────────────────────\n');
fprintf('  YOUR CONSUMPTION EMISSIONS: %.1f kg CO₂e (%.2f tons)\n', ...
    myConsumptionEmissions, myConsumptionEmissions/1000);
fprintf('════════════════════════════════════════════════════════════════\n\n');

%% 📊 YOUR COMPLETE CARBON STORY
% *Bringing it all together*

myTotalEmissions = myTransportEmissions + myHomeEmissions + ...
                   myFoodEmissions + myDigitalEmissions + myConsumptionEmissions;

fprintf('\n');
fprintf('╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                  YOUR COMPLETE CARBON FOOTPRINT                ║\n');
fprintf('╠════════════════════════════════════════════════════════════════╣\n');
fprintf('║                                                                ║\n');
fprintf('║  🚗 Transport:     %8.1f kg (%5.1f tons)  %5.1f%%        ║\n', ...
    myTransportEmissions, myTransportEmissions/1000, ...
    myTransportEmissions/myTotalEmissions*100);
fprintf('║  🏠 Home Energy:   %8.1f kg (%5.1f tons)  %5.1f%%        ║\n', ...
    myHomeEmissions, myHomeEmissions/1000, ...
    myHomeEmissions/myTotalEmissions*100);
fprintf('║  🍽️  Food:          %8.1f kg (%5.1f tons)  %5.1f%%        ║\n', ...
    myFoodEmissions, myFoodEmissions/1000, ...
    myFoodEmissions/myTotalEmissions*100);
fprintf('║  💻 Digital:       %8.1f kg (%5.1f tons)  %5.1f%%        ║\n', ...
    myDigitalEmissions, myDigitalEmissions/1000, ...
    myDigitalEmissions/myTotalEmissions*100);
fprintf('║  🛍️  Consumption:   %8.1f kg (%5.1f tons)  %5.1f%%        ║\n', ...
    myConsumptionEmissions, myConsumptionEmissions/1000, ...
    myConsumptionEmissions/myTotalEmissions*100);
fprintf('║  ──────────────────────────────────────────────────────────  ║\n');
fprintf('║  📊 TOTAL:         %8.1f kg (%5.1f tons)                  ║\n', ...
    myTotalEmissions, myTotalEmissions/1000);
fprintf('║                                                                ║\n');
fprintf('╠════════════════════════════════════════════════════════════════╣\n');
fprintf('║                      GLOBAL CONTEXT                            ║\n');
fprintf('╠════════════════════════════════════════════════════════════════╣\n');
fprintf('║  Your Region (%s): %.1f tons/year average                ║\n', ...
    myRegion, myRegionalContext.PerCapita_Total_Tons);
fprintf('║  Global Average: 4.7 tons/year                                ║\n');
fprintf('║  Paris Agreement Target: ~2.0 tons/year by 2030               ║\n');
fprintf('║  Net Zero Target: ~0.5 tons/year by 2050                      ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

%% 📊 The Grand Finale: Your Complete Story Visualized

figure('Name', 'YOUR COMPLETE CARBON STORY', 'Position', [50 50 1600 900]);

% Main: Total breakdown with percentages
subplot(3,3,[1 2 4 5])
categories = {'Transport', 'Home Energy', 'Food', 'Digital', 'Consumption'};
emissions = [myTransportEmissions, myHomeEmissions, myFoodEmissions, ...
            myDigitalEmissions, myConsumptionEmissions] / 1000;  % Convert to tons
colors_custom = [0.2 0.6 0.8; 0.9 0.6 0.2; 0.4 0.8 0.4; 0.8 0.4 0.6; 0.6 0.6 0.6];

pie(emissions, categories);
title(sprintf('YOUR CARBON FOOTPRINT\nTotal: %.2f tons CO₂/year', myTotalEmissions/1000), ...
    'FontSize', 16, 'FontWeight', 'bold');
colormap(colors_custom);

% Comparison bars
subplot(3,3,[3 6])
comparisonData = [
    myTotalEmissions/1000;
    myRegionalContext.PerCapita_Total_Tons;
    4.7;  % Global average
    2.0;  % Paris target 2030
];
comparisonLabels = {
    'You';
    [myRegion ' Avg'];
    'Global Avg';
    'Paris 2030';
};

barh(categorical(comparisonLabels), comparisonData, 'FaceColor', [0.2 0.6 0.8]);
xlabel('Emissions (tons CO₂/year)');
title('Where You Stand');
xline(2.0, '--r', 'Paris Target', 'LineWidth', 2);
grid on;

% Top emitting category highlighted
subplot(3,3,7)
[maxEmission, maxIdx] = max(emissions);
bar(emissions, 'FaceColor', [0.7 0.7 0.7]);
hold on;
bar(maxIdx, maxEmission, 'FaceColor', [0.9 0.3 0.3]);
set(gca, 'XTickLabel', categories);
ylabel('Emissions (tons CO₂/year)');
title('Your Biggest Impact Area');
text(maxIdx, maxEmission*1.1, sprintf('⚠️\n%.1f tons', maxEmission), ...
    'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold');
grid on;

% Monthly emissions timeline
subplot(3,3,8)
monthlyTotal = myTotalEmissions / 12;
cumulativeEmissions = cumsum(repmat(monthlyTotal, 1, 12)) / 1000;  % Tons

area(1:12, cumulativeEmissions, 'FaceColor', [0.2 0.6 0.8], 'FaceAlpha', 0.5);
hold on;
yline(myTotalEmissions/1000, '--r', 'Annual Total', 'LineWidth', 2);
xlabel('Month');
ylabel('Cumulative Emissions (tons CO₂)');
title('Your Annual Accumulation');
grid on;
set(gca, 'XTick', 1:12, 'XTickLabel', {'J','F','M','A','M','J','J','A','S','O','N','D'});

% Per-day impact
subplot(3,3,9)
dailyEmissions = myTotalEmissions / 365;
activitiesPerDay = [
    dailyEmissions;
    10;  % Planting 1 tree offsets ~10 kg/year
    20;  % Typical car trip
];
activityLabels = {'Your Daily Total', '1 Tree/Year Offset', 'Typical 20km Drive'};

barh(categorical(activityLabels), activitiesPerDay, 'FaceColor', [0.2 0.6 0.8]);
xlabel('Emissions (kg CO₂)');
title('Daily Perspective');
grid on;

%% 🎯 Your Key Insights

fprintf('\n╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                       KEY INSIGHTS                             ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

% Find biggest contributor
[~, biggestIdx] = max(emissions);
biggestCategory = categories{biggestIdx};

fprintf('1. YOUR BIGGEST IMPACT: %s (%.1f%% of total)\n', ...
    biggestCategory, emissions(biggestIdx)/sum(emissions)*100);
fprintf('   → This is your highest-leverage area for reduction\n\n');

% Regional comparison
if myTotalEmissions/1000 < myRegionalContext.PerCapita_Total_Tons
    fprintf('2. REGIONAL COMPARISON: Below average ✓\n');
    fprintf('   You''re %.1f%% below your regional average\n\n', ...
        (1 - myTotalEmissions/1000/myRegionalContext.PerCapita_Total_Tons)*100);
else
    fprintf('2. REGIONAL COMPARISON: Above average\n');
    fprintf('   You''re %.1f%% above your regional average\n\n', ...
        (myTotalEmissions/1000/myRegionalContext.PerCapita_Total_Tons - 1)*100);
end

% Paris alignment
parisTarget = 2.0;  % tons/year by 2030
reductionNeeded = max(0, myTotalEmissions/1000 - parisTarget);
if reductionNeeded > 0
    fprintf('3. PARIS AGREEMENT ALIGNMENT:\n');
    fprintf('   You need to reduce by %.1f tons (%.0f%%) to meet 2030 target\n\n', ...
        reductionNeeded, reductionNeeded/(myTotalEmissions/1000)*100);
else
    fprintf('3. PARIS AGREEMENT ALIGNMENT: You''re on track! ✓\n\n');
end

% Geographic factor
fprintf('4. GEOGRAPHIC INFLUENCE:\n');
fprintf('   Your grid intensity (%d g/kWh) means the same lifestyle has\n', ...
    myRegionalContext.GridIntensity_gCO2_per_kWh);
fprintf('   different carbon impact in different regions.\n');
if myRegionalContext.GridIntensity_gCO2_per_kWh > 400
    fprintf('   → Your grid is carbon-intensive (coal/gas heavy)\n');
    fprintf('   → Solar panels would have high impact for you\n\n');
else
    fprintf('   → Your grid is relatively clean\n');
    fprintf('   → Focus on transport and consumption instead\n\n');
end

%% 🚀 Next Steps

fprintf('╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                          NEXT STEPS                            ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');
fprintf('In Exercise 3, you''ll:\n');
fprintf('• Model a building energy management system with Simulink/Simscape\n');
fprintf('• Optimize HVAC, solar, and battery systems\n');
fprintf('• See how engineering reduces emissions by 30-50%% without sacrifice\n\n');
fprintf('In Exercise 4, you''ll:\n');
fprintf('• Build an interactive app to plan YOUR reduction strategy\n');
fprintf('• Explore cost vs. impact trade-offs\n');
fprintf('• Test your code professionally\n\n');
fprintf('In Exercise 5, you''ll:\n');
fprintf('• Publish everything to GitHub\n');
fprintf('• Share your climate engineering story\n');
fprintf('• Inspire others with data and solutions\n\n');

fprintf('Click to continue: ');
fprintf('<a href="matlab:open(''exercises/Ex3_BuildingEnergySystem.slx'')">Exercise 3 → Simulink Modeling</a>\n\n');

%% 🎓 Key Takeaways from Exercise 2

fprintf('╔════════════════════════════════════════════════════════════════╗\n');
fprintf('║                       KEY TAKEAWAYS                            ║\n');
fprintf('╚════════════════════════════════════════════════════════════════╝\n\n');

fprintf('✓ You calculated your COMPLETE carbon footprint: %.2f tons/year\n', myTotalEmissions/1000);
fprintf('✓ You understand geographic context: %s region influences your baseline\n', myRegion);
fprintf('✓ You identified your biggest impact: %s\n', biggestCategory);
fprintf('✓ You visualized where emissions come from across 5 categories\n');
fprintf('✓ You compared yourself to regional and global benchmarks\n');
fprintf('✓ You learned: Engineering > Guilt, Data > Assumptions, Systems > Sacrifice\n\n');

fprintf('Remember: This is YOUR data. These are YOUR choices.\n');
fprintf('The next exercises show how ENGINEERING makes the difference.\n');
fprintf('════════════════════════════════════════════════════════════════\n');

%% Helper Functions (placed at end of Live Script)

function factor = getEmissionFactor(region, mode)
    % Helper to extract emission factor from CSV
    emissionData = readtable('../data/transportEmissionFactors.csv');
    idx = find(strcmp(emissionData.Transport_Mode, mode) & strcmp(emissionData.Region, region), 1);
    if isempty(idx)
        idx = find(strcmp(emissionData.Transport_Mode, mode) & strcmp(emissionData.Region, 'Global'), 1);
    end
    if ~isempty(idx)
        factor = emissionData.CO2e_Factor_g_per_unit(idx);
    else
        factor = 0;
        warning('Emission factor not found for %s in %s', mode, region);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":13.3}
%---
