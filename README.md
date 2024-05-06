# GastronomyHub API

The proposed solution outlines the architecture for an API designed to manage restaurant reviews and associated data. Here's a breakdown of the key components:

Users: Users are identified by their email addresses and have the ability to claim tags and categories. They are also associated with reviews they create.
Tags and Categories: Tags and categories categorize restaurants and reviews. Users can claim them for personalized categorization. Each tag and category has a creator, ensuring accountability and ownership.
Restaurants: Restaurants have basic information like name, description, and contact details. They can be associated with multiple categories and tags.
Reviews: Users can create reviews for specific restaurants. Reviews include content, recommendation status, ratings for aspects like ambience and service, and the visit date.
Locations: Restaurant locations are represented with address details, including city, state, and country. This enables accurate geographical representation.
Geographical Entities: Cities, states, and countries are modeled separately for efficient organization and retrieval of location data.
Overall, this solution offers a robust API for managing restaurant reviews, featuring user authentication, categorization, and detailed review attributes. The data model is designed for scalability, data integrity, and extensibility to meet future requirements.


## Check all the details here
https://pinnate-chinchilla-f1b.notion.site/GastronomyHub-API-9bf8520691584ad5b9b54ecc69e62586
