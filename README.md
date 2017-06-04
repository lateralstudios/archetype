# Archetype

This project rocks and uses MIT-LICENSE.

An admin tool for Ruby on Rails project with bootstrap style

## Example

To use archetype create an dashboard controller 

app/controllers/archetype/dashboard_controller.rb

```
module Archetype
  class DashboardController < ApplicationController
    include Base
    include Dashboard
  end
end
```


Then for each model you want to include in the dashboard, create an controller
 
 example: app/controllers/archetype/users_controller.rb
 
 ```
module Archetype
  class UsersController < ApplicationController
    include Archetype::Base
    include Archetype::Resourceful
    
    archetype.interface do
      navigable :users, ->{ users_path }, icon: 'user'
    end

    archetype.resourceful do
      actions :all
    end

    archetype.attributes do

      attributes :telephone, context: {except: :index}
      attributes :activated_at, context: [:show]
      attributes :activated, type: :boolean, input: {as: :boolean}, context: [:index, :new, :create, :edit, :update]
    end

  
  end
end

```

Note the icon `user` used for the interface is coming from the bootstrap elements (see [bootstrap](http://getbootstrap.com/components/) )
 
Name of related model displayed on the dashboard will use the `to_s` , `name` or `title` definition.
therefore you can add new method as alias it, if it is not defined
    
```
   class User < ActiveRecord::Base
    
 ....   
     def to_s
        "#{forename} #{surname}"
      end
      
  ...
    end
      
```