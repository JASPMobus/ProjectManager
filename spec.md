Specs:

x Using Ruby on Rails for the project

x Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
    Users and Projects both have_many Tasks
    
x Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
    Tasks belong_to Users and Projects
    
x Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
    Users have_many Projects through Tasks and vice versa
    
x Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
    See above.
    
x The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
    Tasks have a Summary and Description.
    
x Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    Projects have validation in their name, Tasks in their summary
    
 Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
 
x Include signup (how e.g. Devise)
    Through Devise
    
x Include login (how e.g. Devise)
    Through Devise
    
x Include logout (how e.g. Devise)
    Through Devise
    
x Include third party signup/login (how e.g. Devise/OmniAuth)
    Through Devise
    
x Include nested resource show or index (URL e.g. users/2/recipes)
    Tasks completely nested beneath projects
    
x Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
    Tasks completely nested beneath projects
    
x Include form display of validation errors (form URL e.g. /recipes/new)
    For forms of Projects, Tasks
    
Confirm:

 The application is pretty DRY
 
 Limited logic in controllers
 
 Views use helper methods if appropriate
 
x Views use partials if appropriate
    Forms for Projects, Tasks
    
