# Ckeditor Bootstrap

[![Build Status](https://semaphoreci.com/api/v1/projects/9c3e4e36-9716-4362-aaa5-ef9644c72313/565007/badge.svg)](https://semaphoreci.com/igor-galeta/ckeditor)
[![Code Climate](https://codeclimate.com/github/galetahub/ckeditor/badges/gpa.svg)](https://codeclimate.com/github/galetahub/ckeditor)

CKEditor Bootstrap is a WYSIWYG text editor designed to simplify web content creation.Its is overridden  from (https://github.com/galetahub/ckeditor), It brings common word processing features directly to your web pages. Enhance your website experience with our community maintained editor.
[ckeditor.com](http://ckeditor.com/)

##  Features

* Overriding of Ckeditor(https://github.com/galetahub/ckeditor) version 4.5.10 (13 Jul 2016)
* Rails 4.2-5 integration
* Files browser
* HTML5 file uploader
* Hooks for formtastic and simple_form forms generators
* Integrated with authorization framework CanCan and Pundit

## Installation

For basic usage just include the ckeditor gem:


use the latest version from Github:

```
gem 'ckeditor', , :git => 'https://github.com/alishahpakneeds/ckeditor.git',:branch => "bootstrap"
```

Initialy it has the support of  [ckeditor as normal](https://github.com/galetahub/ckeditor).but in future its going to be reponsive interfaces , specially photo gallery

#### After these configuration (ActiveRecord + paperclip or ActiveRecord + carrierwave)

```
   rails generate ckeditor:install --orm=active_record --backend=paperclip
   rails generate ckeditor:install --orm=active_record --backend=carrierwave

```

And if you set the your config variable in
```ruby
#new added feature because pictures that uploaded from other system rather than ck it wont be shown , we added to show those pictures here,
#Go to to Your Your
# in app/models/ckeditor/asset.rb , add the following line
class Ckeditor::Asset < ActiveRecord::Base
    self.table_name = 'your_custom_table_name'
end
```
#One More thing your your custom table should contain following columns
# Create a migration
```
    rails g migration add_ck_editor_columns in custom table
```
```ruby
#eg

class AddCkEditorColumns < ActiveRecord::Migration
  def up
    add_column :images,:data_file_name,:string
    add_column :images,:data_content_type,:string
    add_column :images,:data_file_size,:integer
    add_column :images,:assetable_id,:integer
    add_column :images,:assetable_type,:string, limit: 30
    add_column :images,:type,:string, limit: 30
    add_column :images,:width,:integer
    add_column :images,:height,:integer




    # add_index :images, ["assetable_type", "type", "assetable_id"], name: "idx_image_assetable_type"
    # add_index :images, ["assetable_type", "assetable_id"], name: "idx_image_assetable"

  end

  def down

    remove_column :images,:data_file_name
    remove_column :images,:data_content_type
    remove_column :images,:data_file_size
    remove_column :images,:assetable_id
    remove_column :images,:assetable_type
    remove_column :images,:type
    remove_column :images,:width
    remove_column :images,:height

    # remove_index :images,  column: ["assetable_type", "type", "assetable_id"],name:"idx_image_assetable_type"
    # remove_index :images,  column: ["assetable_type", "assetable_id"],name: "idx_image_assetable"
  end
end


```


```ruby
#Now go to following file
# in config/initializers/ckeditor.rb
Ckeditor.setup do |config|

  #config.system_attachment_model { YourCustomModelForAttachment } eg ,but your table name should be same for Ckeditor::Picture
  config.system_attachment_model { Image }
end
```

#Now in Your custom model add following line for concern

```ruby
  #YourCustomModelForAttachment
  class Image <  ActiveRecord::Base

    include CkEditorConcern

  end
```