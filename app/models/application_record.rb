class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end

## Application record serve as an abstract base class 
#class that cannot be instantiated directly 
#provides a blueprint for other classes to inherit from
#abstract class that can be can be use as a base for application's models