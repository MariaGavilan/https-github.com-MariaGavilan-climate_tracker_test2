function annualEmissionsCO2e_kg = calculateTransportEmissions(region, commuteMode, ...
    dailyCommuteKm, commuteDaysPerYear, domesticFlightsPerYear, avgDomesticFlightKm, ...
    internationalFlightsPerYear, avgInternationalFlightKm, otherTravelKmPerWeek)
%CALCULATETRANSPORTEMISSIONS Calculate annual CO₂-equivalent emissions from personal transportation
%
%   annualEmissionsCO2e_kg = CALCULATETRANSPORTEMISSIONS(region, commuteMode, 
%       dailyCommuteKm, commuteDaysPerYear, domesticFlightsPerYear, 
%       avgDomesticFlightKm, internationalFlightsPerYear, 
%       avgInternationalFlightKm, otherTravelKmPerWeek)
%
%   Calculates total annual carbon dioxide equivalent emissions in kilograms 
%   from various personal transportation activities including daily commute, 
%   flights, and other regular travel.
%
%   INPUTS:
%       region                      - Geographic region (string): 'Global', 'USA', 
%                                     'Europe', 'Asia', 'China', 'India', 'Norway', etc.
%       commuteMode                 - Daily commute mode (string): 
%                                     'Car_Gasoline', 'Car_Diesel', 'Car_Electric_BEV',
%                                     'Bus', 'Train_Rail', 'Motorcycle', 'Cycling', 'Walking'
%       dailyCommuteKm              - One-way daily commute distance (km)
%       commuteDaysPerYear          - Number of commuting days per year (typical: 200-250)
%       domesticFlightsPerYear      - Number of domestic round-trip flights per year
%       avgDomesticFlightKm         - Average one-way domestic flight distance (km)
%       internationalFlightsPerYear - Number of international round-trip flights per year
%       avgInternationalFlightKm    - Average one-way international flight distance (km)
%       otherTravelKmPerWeek        - Other travel per week: errands, weekends (km)
%
%   OUTPUT:
%       annualEmissionsCO2e_kg - Total annual CO₂-equivalent emissions in kilograms
%
%   EMISSION FACTORS:
%       Based on authoritative global sources:
%       - UK DEFRA 2024 Greenhouse Gas Conversion Factors
%       - US EPA Emission Factors 2024
%       - IEA Transport and CO₂ Report 2024
%       - IPCC AR6 Working Group III Chapter 10
%       - EMEP/EEA Emission Inventory Guidebook 2020
%
%   GLOBAL CONTEXT:
%       - Global average transport emissions: 1.2 tons CO₂/year per person
%       - US average: 4.8 tons CO₂/year per person
%       - EU average: 2.1 tons CO₂/year per person
%       - Asia-Pacific: 83% of global transport emission growth since Paris Agreement
%
%   EXAMPLE:
%       % US suburban car commuter with occasional flights
%       emissions = calculateTransportEmissions('USA', 'Car_Gasoline', ...
%           25, 250, 2, 1500, 1, 8000, 50);
%       fprintf('Annual emissions: %.1f kg CO₂e (%.2f tons)\n', ...
%           emissions, emissions/1000);
%
%   See also: calculateHomeEmissions, calculateFoodEmissions, calculateTotalFootprint

%% TODO 1: Input Validation
% Use Copilot to validate all inputs
% HINT: Prompt Copilot with: "Validate that region is a string and all numeric 
%       inputs are non-negative numbers. Use arguments block with validation."
%
% SOLUTION APPROACH: Use arguments...end block with validation functions




%% TODO 2: Load Emission Factors Database
% Load the transportEmissionFactors.csv file into a table
% HINT: Prompt Copilot with: "Read transportEmissionFactors.csv from ../data/ 
%       folder into a table called emissionData"



%% TODO 3: Calculate Daily Commute Emissions
% Calculate annual emissions from daily commuting
%
% STEPS:
% a) Find the emission factor for the specified commuteMode and region
% b) Calculate round-trip daily emissions (dailyCommuteKm * 2 * emissionFactor)
% c) Annualize: daily emissions * commuteDaysPerYear
% d) Handle special modes (Walking, Cycling = 0 emissions)
%
% HINT: Prompt Copilot with: "Find the row in emissionData where Transport_Mode 
%       matches commuteMode and Region matches region. Extract the CO2e_Factor_g_per_unit.
%       If not found for specific region, use 'Global' as fallback."

commuteEmissions_g = 0;  % TODO: Replace with calculation

% HINT: For calculation prompt: "Calculate annual commute emissions as:
%       dailyCommuteKm * 2 (round trip) * emissionFactor * commuteDaysPerYear"



%% TODO 4: Calculate Flight Emissions
% Calculate emissions from domestic and international flights
%
% AVIATION NOTES (from DEFRA 2024):
% - Domestic flights (<1600km): Use 'Aviation,Domestic_Medium' (~156 g/pkm)
% - International flights (>1600km): Use 'Aviation,International_Long' (~147 g/pkm)
% - Emission factors include radiative forcing index (RFI) - the additional
%   warming effect from high-altitude emissions beyond just CO₂
%
% HINT: Prompt Copilot with: "Find emission factor for 'Aviation' mode with
%       Vehicle_Type 'Domestic_Medium' and 'International_Long' from emissionData.
%       Calculate total flight emissions for round trips."

domesticFlightEmissions_g = 0;  % TODO: Replace with calculation


internationalFlightEmissions_g = 0;  % TODO: Replace with calculation


%% TODO 5: Calculate Other Regular Travel Emissions
% Calculate emissions from other weekly travel (errands, weekends, social)
% Assume same mode as daily commute unless it's Walking/Cycling, then use 'Car_Gasoline'
%
% HINT: Prompt Copilot with: "If commuteMode is Walking or Cycling, use Car_Gasoline
%       emission factor for other travel. Otherwise use same mode. Calculate annual
%       emissions from otherTravelKmPerWeek * 52 weeks."

otherTravelEmissions_g = 0;  % TODO: Replace with calculation


%% TODO 6: Sum All Components and Convert to kg
% Sum all emission components and convert from grams to kilograms
%
% HINT: Prompt Copilot with: "Sum commuteEmissions_g, domesticFlightEmissions_g,
%       internationalFlightEmissions_g, and otherTravelEmissions_g, then divide
%       by 1000 to convert to kg"

annualEmissionsCO2e_kg = 0;  % TODO: Replace with calculation


end