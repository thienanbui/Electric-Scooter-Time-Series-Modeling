# Forecasting Demand in Chicago’s Emerging E-Scooter Market Using Spatiotemporal Analysis


## Overview
The work documented in this repository was submitted as a Capstone Project in partial fulfillment of the requirements for the Master of Science in Analytics at the University of Chicago. The project focuses on leveraging time series modeling to optimize resource allocation, reduce costs, and facilitate revenue growth for e-scooter companies in Chicago through forecasting e-scooter availability.

## Team Members
- Anargha Ajoykumar
- [Thien-An Bui](https://www.linkedin.com/in/thien-an-bui/)
- [Cathy Ouyang](https://www.linkedin.com/in/cathy-ouyang/)
- Hussein Abou Nassif Mourad


## Project Abstract
The project Forecasting Demand in Chicago’s Emerging Electric Scooter (ie. E-Scooter) Market Using Spatiotemporal Analyses employed a Long Short Term Memory (LSTM) model to forecast e-scooter demand in Chicago. The primary objective was to optimize resource allocation and facilitate revenue growth for e-scooter companies. By combining the LSTM model with a supply-demand analysis, we identified three key communities with low supply yet high demand where targeted demand could increase quarterly revenue by 3% to 5%. These predictions offer practical findings that enhance operational efficiency. Furthermore, by integrating auxiliary datasets like weather conditions, our analysis explored spatiotemporal patterns, providing insights into user behavior and geographical utilization.

## Our Approach
To make informed supply decisions, Chicago’s e-scooter companies must gain a comprehensive understanding of the demand dynamics for their products, with the overarching goal of capturing market share and maintaining profit margins. This project used forecasting models to address these critical business problems. Our models sought to capture the underlying behavioral patterns to derive strategies for strengthening and expanding the customer base.
- Challenge: E-scooter companies face a trade-off between underestimating and overestimating demand.
  - Underestimation: Leads to missed revenue opportunities and customer dissatisfaction.
  - Overestimation: Results in increased operational costs and unused resources.
- Opportunity: By leveraging advanced demand forecasting, companies can strategically position e-scooters, ensuring availability in high-demand areas and gaining a competitive edge in the market.

![Slide 1](/PPT_slides_abbrev/problem_statement.PNG "Demand Forecasting Significance")

## Data Overview

Our project leveraged six data sources to analyze and forecast e-scooter demand in Chicago. Our main dataset described e-scooter trips taken, paired with five additional datasets that bring in external variables of weather, crime, gas price, demographics, and public transportation. 

The main dataset’s columns included start/end times, start/end locations, trip distances, durations, and community area information. This dataset directly captured the usage patterns needed to model e-scooter demand. To clean it, we identified and removed entries with missing start or end times. Missing locations were handled by excluding trips where critical location data was absent. Missing rows only accounted for about 0.17% of total data.

![Slide 2](/PPT_slides_abbrev/Dataset_overview.PNG "E-Scooter Dataset Overview")

## Methodology
We forecasted e-scooter demand with several different models. The response variable for each of these models were the hourly trip counts within the individual community areas. We describe the specifics of each model below. 
When modeling, we tested ARIMAX, SARIMAX, Long-Short Term Memory (LSTM), Deep Auto Regressive (DeepAR), Prophet, Extreme Gradient Boosting Regressor (XGBR), random forest, and linear regression. Based on the nature of the models, some were run individually for each community while others were an aggregate model that measured trips within all communities together. We evaluated community area clusters before aggregating them into a composite model to understand consumer demand patterns. This hierarchical time series model offers many advantages such as mitigating any loss of information and accurately capturing the dynamics of individual series. 

Our Root Mean Squared Error (RMSE) scores show that LSTM is the best performing model for recognizing patterns in Chicago e-scooter demand. By leveraging predictive modeling techniques, such as demand forecasting and revenue projection, e-scooter companies can make informed decisions to optimize resource allocation, enhance customer experience, and drive business growth. These analytical goals enable companies to strategically deploy e-scooter fleets, optimize pricing strategies, identify untapped market segments, and mitigate customer churn. By integrating these analytical insights into their operational and strategic planning, e-scooter companies can position themselves for success in a dynamic and competitive market landscape.

![Slide 3](/PPT_slides_abbrev/Models_Selected.PNG "Models Employed")

The supply and unmet demand calculations supplement our demand forecasting analysis. These calculations explored the likelihood of supply shortages and unmet demand occurrences across various communities and times. We developed two indices to represent these dynamics: the Supply Index and the Unmet Demand Index. The Supply Index (ranging from 0 to 3) indicates the likelihood of insufficient scooter availability, while the Unmet Demand Index (ranging from 0 to 7) represents the likelihood of unmet demand being present. These indices were derived using the following approach:
- The predicted trip counts were extracted from the LSTM model output.
- The Supply Index was calculated using a backpropagation method.
- The Unmet Demand Index was derived from the Supply Index and through pattern recognition techniques.

These calculations, however, come with certain limitations. Due to the absence of actual supply and unmet demand data, there is no definitive method for validating these indices. While our predictions regarding communities with higher supply and unmet demand indices appear plausible—supported by relevant factors discussed in the following sections—the lack of empirical validation remains a constraint. Nevertheless, we contend that these insights into supply shortages and unmet demand can still serve as valuable approximations for e-scooter companies, offering a foundational understanding of potential operational needs.

![Slide 5](/PPT_slides_abbrev/Supply_Demand_Process.PNG "Supply-Demand Methodology")

## Results and Recommendations
After testing several models, we employed a Long Short Term Memory (LSTM) model that effectively predicted e-scooter trip count in Chicago. The findings highlighted communities 14 (Albany Park), 45 (Avalon Park), and 67 (West Englewood) as high potential areas where investment could be particularly beneficial due to their low supply and high demand, which is projected to yield a 3% to 5% quarterly increase in revenue. 

![Slide 4](/PPT_slides_abbrev/LSTM_forecasts.PNG "Model Forecasts for E-Scooter Demand")

To synthesize the results of our analysis, we developed an R-Shiny dashboard designed to assist e-scooter companies in comprehending supply-demand dynamics. The dashboard features three filters, allowing users to select the community, date, and hour of interest. Based on these selections, the dashboard displays the predicted start count, predicted end count, supply index, and unmet demand index. Additionally, two visualizations are provided: one illustrating the e-scooter trip counts for the selected community and date, and another depicting the variation in the supply and unmet demand indices across different hours of the day. 

![Slide 6](/PPT_slides_abbrev/RShiny_Dashboard.PNG "Supply-Demand Dashboard")

We recommend that e-scooter companies align their operational strategies with all of our findings, specifically by focusing on Albany Park, Avalon Park, and West Englewood. Our analysis has identified these communities as having low supply yet high demand, making them ideal targets for optimization. Therefore, we recommend that companies place more of their e-scooters in these areas. 

By integrating spatiotemporal and external datasets, our model effectively captures demand fluctuations across different locations and times. This approach enables e-scooter companies to:
- Maximize customer satisfaction by meeting demand.
- Optimize resource allocation to reduce costs.
- Gain a competitive advantage through precise forecasting.

![Slide 7](/PPT_slides_abbrev/Recommendations.PNG "Phase 1 Recommendations")

## Next Steps
Our project demonstrates the importance of data-driven approaches to optimize e-scooter operations. Future research directions may include exploring the impact of other external factors on e-scooter demand, expanding the project scope to simulate optimal supply strategies, and refining forecasting models to better accommodate evolving user preferences and urban dynamics.

![Slide 7](/PPT_slides_abbrev/Next_Steps.PNG "Continued Work")

We identified areas with increased likelihood of low supply and unmet demand using our derived indices and estimations. Our analysis did not seek to provide perfect predictions on this front since we can never observe the true value of these latent variables and thus, cannot validate our estimates to determine their exact accuracy. Rather, we focused on establishing criteria that translated into increased likelihood that a given location would have interested riders coupled with inadequate supply to better inform business decisions around the relative distribution of scooter supply in the environment. Despite its limitations, our analysis still stands as a powerful framework that helps e-scooter companies make informed data-driven decisions about fleet distribution, enhancing their ability to respond to dynamic market conditions.

The practical applications of our work extends into real-world settings, providing actionable insights for operational strategy. In our recent discussion with Qing Qin, a data scientist at Lime, one of Chicago’s leading e-scooter companies, we gained valuable insight on their operational practices. He shared that Lime’s local teams regularly monitor supply and demand metrics, with e-scooters being relocated approximately once a week to align with these crucial insights. Integrating our model into Lime’s data analysis framework could further enhance these strategies. Since Qin highlighted that supply and demand metrics are fundamental to Lime’s success, they could use our high-performing LSTM model to forecast demand across Chicago and identify key areas with high potential, then strategically allocate e-scooters to those underserved communities. This targeted approach would allow Lime to expand their service areas, tap into new customer bases, and achieve notable increases in ridership and revenue. In addition, our R-Shiny dashboard offers an interactive platform for visualizing these insights. The dashboard enables users to easily drill down into specific communities and track predicted trip counts, providing a dynamic tool to inform and refine operational decisions. These insights underscore the tangible benefits and strategic value that our work can deliver to e-scooter companies like Lime.

## Acknowledgements
Our team would like to extend our thanks to the University of Chicago's Applied Data Science program for their support throughout this project. Special thanks to Jonathan Williams and Fan Yang, who served as our facility advisors. 

Thank you to you, the reader, for allowing us to share our process and findings with you. The team encourages you to reach out to us through our LinkedIn profiles for continued discussion on our work and opportunities for future collaborations. Please refer to the "Team Members" section for our contact information.

