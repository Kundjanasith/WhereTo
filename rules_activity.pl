:- module(rules_activity, []).

% Swimming
activity(Activity, Month, Continent, Country) :-
  Activity = swimming,
  facts_type:continent(Continent),
  facts_is_in:is_in(Country, Continent),
  facts_country_feature:has(Country, sea),
  facts_monthly_climate:monthly_climate(Month, Country, Weather),
  Weather = warm.

% Skiing
activity(Activity, Month, Continent, Country) :-
  Activity = skiing,
  facts_type:continent(Continent),
  facts_is_in:is_in(Country, Continent),
  facts_country_feature:has(Country, mountain),
  facts_monthly_climate:monthly_climate(Month, Country, Weather),
  Weather = snow.

% Hiking
activity(Activity, Month, Continent, Country) :-
  Activity = hiking,
  facts_type:continent(Continent),
  facts_is_in:is_in(Country, Continent),
  facts_country_feature:has(Country, mountain),
  facts_monthly_climate:monthly_climate(Month, Country, Weather),
  (Weather = warm; Weather = rain).

activity(Activity, Month, Country) :-
  facts_type:activity(Activity),
  activity(Activity, Month, _, Country).
