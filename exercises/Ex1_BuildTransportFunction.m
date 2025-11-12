%[text] # Exercise 1: Calculate Annual Transport Emissions
%[text] 
%[text] Transportation is typically the largest controllable source of personal carbon emissions in developed countries, and a rapidly growing source in developing regions.
%[text] 

%
% <<../images/transport_overview.png>>


%[text] Some key facts to consider about this Global Transport Challenge:
%[text] - Transport = 16-20% of global CO₂ emissions
%[text] - Cars + motorcycles = 75% of passenger transport emissions
%[text] - Asia-Pacific region: 83% of global transport emission growth since Paris Agreement
%[text] - Aviation emissions surged 5.5% in 2024 despite efficiency improvements \
%[text] Mode choice matters MORE than distance traveled. Same 10km journey:
%[text] - Walking/Cycling: 0 g CO₂
%[text] - Electric train: 60 g CO₂ (6 g/pkm × 10km)
%[text] - Urban bus: 850 g CO₂ (85 g/pkm × 10km)  
%[text] - Personal car (alone): 1,640 g CO₂ (164 g/pkm × 10km)
%[text] - Short-haul flight: 2,550 g CO₂ (255 g/pkm × 10km) \
%[text] **Same distance, 40x difference in emissions!**
%[text] ## **Your Mission**
%[text] Finish building a function that calculates **annual** CO₂-equivalent emissions from personal transportation, including: Daily commute (car, public transit, cycling, walking), Flights (domestic and international) and Other regular travel (weekends, errands).
%[text] You'll use **MATLAB Copilot** to help write the code, then use a **unit test** to ensure it works correctly across different global scenarios.


%% Your Mission
% 
%
% You'll use **MATLAB Copilot** to help write the code, then create 
% **unit tests** to ensure it works correctly across different global scenarios.

%% Step 1: Explore the Emission Factors Database
% Let's load and examine the global transport emission factors

transportData = readtable('../data/transportEmissionFactors.csv');

% Display sample of emission factors
disp('=== Sample Transport Emission Factors (g CO₂e per unit) ===')
disp(transportData(1:10,:))

% Show regional variation for cars
carData = transportData(contains(transportData.Transport_Mode, 'Car_Gasoline') & ...
                       strcmp(transportData.Vehicle_Type, 'Average'), :);
disp(' ')
disp('=== Regional Variation: Average Gasoline Car (g CO₂/km) ===')
disp(carData(:, {'Region', 'CO2e_Factor_g_per_unit'}))

%% Key Insights from the Data
% Notice the variation:
% • Cars: 109-214 g/km depending on size and region
% • Electric cars: 5-140 g/km depending on grid carbon intensity
% • Buses: 27-150 g/pkm depending on occupancy and type
% • Trains: 6-41 g/pkm (high-speed rail is extremely efficient!)
% • Aviation: 147-588 g/pkm (class matters - business class = 3x economy!)
%
% *This is why engineering and data matter.*

%% Step 2: Open the Starter Function
% Navigate to: functions/calculateTransportEmissions.m

edit functions/calculateTransportEmissions.m

% READ the function signature carefully. You'll complete 4 sections:
% 1. Input validation
% 2. Load emission factors
% 3. Calculate daily commute emissions
% 4. Calculate flight emissions
% 5. Calculate other travel emissions
% 6. Annualize and return total

%% Step 3: Use MATLAB Copilot Effectively
% *How to work with Copilot in R2025a:*
%
% 1. Open the function file
% 2. Read each TODO comment carefully
% 3. Position cursor where you need code
% 4. Press *Ctrl+I* (Windows/Linux) or *Cmd+I* (Mac)
% 5. Type a specific prompt in natural language
% 6. Review suggestion, press Tab to accept, Esc to reject
% 7. Iterate if needed
%
% *Example Good Prompts:*
% • "Validate that dailyCommuteKm is a non-negative number"
% • "Load transportEmissionFactors.csv into a table"
% • "Calculate car emissions by multiplying distance by emission factor for region"
% • "Sum all emission components and convert annual total from g to kg"
%
% *Pro Tips:*
% • Be specific: mention variable names, data types, operations
% • One task per prompt
% • Check suggestions before accepting - Copilot isn't always perfect!
% • Use comments to guide Copilot toward better suggestions

%% Step 4: Test Your Function Manually
% Once you've completed the function, test it with realistic scenarios

% SCENARIO 1: US suburban commuter
annualCO2_US = calculateTransportEmissions(...
    'USA', ...           % Region
    'Car_Gasoline', ...  % Daily commute mode
    25, ...              % Daily commute distance (km)
    250, ...             % Commute days per year
    2, ...               % Domestic flights per year
    1500, ...            % Avg domestic flight distance (km)
    1, ...               % International flights per year  
    8000, ...            % International flight distance (km)
    50);                 % Other travel per week (km)

fprintf('\n=== SCENARIO 1: US Suburban Commuter ===\n');
fprintf('Annual transport emissions: %.1f kg CO₂e\n', annualCO2_US);
fprintf('Equivalent to: %.2f tons CO₂e\n', annualCO2_US/1000);

% SCENARIO 2: European train commuter
annualCO2_EU = calculateTransportEmissions(...
    'Europe', ...
    'Train_Rail', ...    % Takes train to work!
    35, ...
    240, ...
    3, ...
    800, ...
    0, ...
    0, ...
    30);

fprintf('\n=== SCENARIO 2: European Train Commuter ===\n');
fprintf('Annual transport emissions: %.1f kg CO₂e\n', annualCO2_EU);
fprintf('Equivalent to: %.2f tons CO₂e\n', annualCO2_EU/1000);
fprintf('Reduction vs US scenario: %.0f%%n', (1-annualCO2_EU/annualCO2_US)*100);

% SCENARIO 3: Asian urban resident (transit + scooter)
annualCO2_Asia = calculateTransportEmissions(...
    'Asia', ...
    'Motorcycle', ...    % Scooter commute
    15, ...
    300, ...
    1, ...
    1200, ...
    0, ...
    0, ...
    20);

fprintf('\n=== SCENARIO 3: Asian Urban Resident ===\n');
fprintf('Annual transport emissions: %.1f kg CO₂e\n', annualCO2_Asia);
fprintf('Equivalent to: %.2f tons CO₂e\n', annualCO2_Asia/1000);

% Compare to benchmarks
fprintf('\n=== Global Context ===\n');
fprintf('Global average transport emissions: ~1.2 tons CO₂/year per person\n');
fprintf('US average: ~4.8 tons CO₂/year\n');
fprintf('EU average: ~2.1 tons CO₂/year\n');
fprintf('Source: Our World in Data, Transport CO₂ per capita\n');

%% Step 5: Write Unit Tests
% Professional engineers test their code. Let's ensure your function works!

edit tests/TestTransportEmissions.m

% Your tests should verify:
% 1. Zero inputs → zero emissions
% 2. Known calculation → correct result
% 3. Regional variation → different results for same inputs
% 4. Input validation → errors on negative/invalid inputs
% 5. Boundary conditions → handles extreme but valid values

%% Step 6: Run Your Tests Using Test Browser Panel (R2025a!)
% MATLAB R2025a introduced the Test Browser Panel - let's use it!
%
% *Option A: Use Test Browser Panel (Recommended)*
% 1. Look for "Test Browser" in the left sidebar (new in R2025a!)
% 2. Click to open the panel
% 3. Navigate to tests/TestTransportEmissions.m
% 4. Click "Run" button
% 5. Watch tests execute with visual feedback
%
% *Option B: Command Window*
results = runtests('tests/TestTransportEmissions.m');

% Display results
disp(' ')
disp('=== Test Results ===')
disp(results)

if all([results.Passed])
    disp('✓ SUCCESS: All tests passed! Your function is working correctly.')
    disp('✓ You can now confidently use this function for global calculations.')
else
    disp('✗ FAILURE: Some tests failed. Review error messages and fix:')
    failedTests = results(~[results.Passed]);
    for i = 1:length(failedTests)
        fprintf('  - %s: %s\n', failedTests(i).Name, failedTests(i).Details.DiagnosticRecord.Report);
    end
end

%% Understanding Your Test Coverage
% Good tests cover:
% • **Normal operation**: Typical user inputs
% • **Edge cases**: Zero values, single modes, maximum values
% • **Error conditions**: Negative inputs, invalid regions
% • **Regional variation**: Same behavior, different factors
%
% *Why test?*
% This function will be used globally, with different:
% • Regions (USA, Europe, Asia, Latin America)
% • Transport modes (car, train, bus, motorcycle, flights)
% • Input ranges (urban commuter vs. frequent flyer)
%
% Tests ensure it works correctly for ALL scenarios, not just yours!

%% Calculate YOUR Annual Transport Footprint
% Now it's personal. Calculate YOUR transport emissions:

% TODO: Update these values with YOUR typical travel patterns
myRegion = 'USA';              % Change to your region
myCommuteMode = 'Car_Gasoline'; % Change to your mode
myDailyCommuteKm = 20;         % One-way distance
myCommuteDays = 250;           % Working days per year
myDomesticFlights = 2;         % Round trips
myDomesticFlightKm = 1500;     % Avg distance per flight
myIntlFlights = 0;             % Round trips
myIntlFlightKm = 0;            % Avg distance
myOtherTravelKm = 40;          % Weekend/errands per week

% Calculate
myAnnualEmissions = calculateTransportEmissions(...
    myRegion, myCommuteMode, myDailyCommuteKm, myCommuteDays, ...
    myDomesticFlights, myDomesticFlightKm, ...
    myIntlFlights, myIntlFlightKm, myOtherTravelKm);

fprintf('\n========================================\n');
fprintf('YOUR ANNUAL TRANSPORT FOOTPRINT\n');
fprintf('========================================\n');
fprintf('Total emissions: %.1f kg CO₂e (%.2f tons)\n', ...
        myAnnualEmissions, myAnnualEmissions/1000);

% Context
if myAnnualEmissions/1000 < 1.2
    fprintf('✓ Below global average (1.2 tons/year)\n');
elseif myAnnualEmissions/1000 < 2.1
    fprintf('≈ Around EU average (2.1 tons/year)\n');
elseif myAnnualEmissions/1000 < 4.8
    fprintf('⚠ Above global but below US average (4.8 tons/year)\n');
else
    fprintf('⚠ Above US average - significant reduction opportunity!\n');
end

%% Reflection: Where's Your Biggest Impact?
% Before moving to Exercise 2, consider:
%
% *Questions to think about:*
% 1. Which component is largest: commute, flights, or other travel?
% 2. What mode change would reduce your footprint by 30%?
% 3. If you switched your commute to the next-cleanest mode available,
%    what would your new annual emissions be?
% 4. How does YOUR footprint compare to your regional average?
%
% *The engineering mindset:*
% • Not "I should feel guilty"
% • But "Where can I get the biggest leverage?"
% • Mode choice > distance traveled in many cases!

%% Next: Exercise 2 - Your Personal Impact Story
% In Exercise 2, you'll:
% • Use this function (and others) in an interactive Live Script
% • Calculate your COMPLETE carbon footprint (not just transport)
% • Visualize where YOUR impact comes from
% • Compare against regional and global averages
% • Tell your data-driven climate story
%
% Click to continue: <matlab:open('exercises/Ex2_PersonalImpactStory.mlx') Exercise 2 →>

%% Key Takeaways from Exercise 1
% ✓ You built a robust, tested function for global transport emissions
% ✓ You learned to use MATLAB Copilot for efficient code generation
% ✓ You practiced professional unit testing with the Test Browser Panel (R2025a)
% ✓ You understand emission factors vary dramatically by mode and region
% ✓ You calculated YOUR transport footprint with real data
% ✓ You learned that **engineering choices matter more than sacrifice**
%
% *Remember:* Same 10km journey can be 0-2550 g CO₂ depending on mode!

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":15.6}
%---
